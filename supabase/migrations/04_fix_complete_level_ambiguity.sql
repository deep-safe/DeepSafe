-- Fix RPC Ambiguity for complete_level
-- Drops conflicting function signatures to resolve PGRST203 error.

-- 1. Drop ALL known variations of complete_level to clean the slate.
DROP FUNCTION IF EXISTS public.complete_level(uuid, text, int);
DROP FUNCTION IF EXISTS public.complete_level(text, text, int);
DROP FUNCTION IF EXISTS public.complete_level(uuid, text, int, int);
DROP FUNCTION IF EXISTS public.complete_level(text, text, int, int);

-- 2. Re-create the CORRECT function (Single Source of Truth)
-- matches: p_user_id (text), p_level_id (text), p_score (int)
-- Logic: fetches nc_reward from DB.

CREATE OR REPLACE FUNCTION complete_level(
  p_user_id TEXT,
  p_level_id TEXT,
  p_score INT,
  p_status TEXT DEFAULT 'completed'
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_uuid UUID;
  v_level_uuid UUID;
  v_nc_reward INT;
  v_new_credits INT;
  v_previous_status TEXT;
  v_already_awarded BOOLEAN := FALSE;
BEGIN
  -- Cast user_id to UUID explicitly
  BEGIN
    v_user_uuid := p_user_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object('success', FALSE, 'error', 'Invalid user_id format');
  END;

  -- 1. Safely Cast Level ID to UUID (Mission IDs are UUIDs, legacy might be slugs)
  BEGIN
    v_level_uuid := p_level_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    v_level_uuid := NULL; -- It's a slug, not a UUID
  END;

  -- 2. Fetch Mission Reward (Only if it's a UUID)
  v_nc_reward := 0;
  IF v_level_uuid IS NOT NULL THEN
    SELECT nc_reward INTO v_nc_reward
    FROM public.missions
    WHERE id = v_level_uuid;
  END IF;

  IF v_nc_reward IS NULL THEN
    v_nc_reward := 0;
  END IF;

  -- Check previous status to avoid re-awarding (Infinite Money Glitch Fix + Reward Logic)
  SELECT status INTO v_previous_status 
  FROM public.user_progress 
  WHERE user_id = v_user_uuid AND quiz_id = p_level_id;

  -- 3. Mark Mission/Level in User Progress
  -- We allow 'attempted' status for non-perfect scores.
  -- Logic: 
  --   - If new status is 'completed', it overrides everything.
  --   - If new status is 'attempted', it ONLY overrides if current status is NULL.
  --   - Score is ALWAYS updated to the MAX value (GREATEST).
  
  INSERT INTO public.user_progress (user_id, quiz_id, score, status, completed_at)
  VALUES (v_user_uuid, p_level_id, p_score, p_status, NOW())
  ON CONFLICT (user_id, quiz_id)
  DO UPDATE SET
    score = GREATEST(user_progress.score, EXCLUDED.score),
    status = CASE 
        WHEN user_progress.status = 'completed' THEN 'completed' -- Once completed, always completed
        WHEN EXCLUDED.status = 'completed' THEN 'completed'      -- Upgrade to completed
        ELSE EXCLUDED.status                                     -- Keep as attempted/other
    END,
    completed_at = NOW();

  -- 4. Update User Profile Credits (NC)
  -- Only award if:
  --   a) New status is 'completed'
  --   b) Reward > 0
  --   c) Was NOT previously completed (prevent double dipping)
  IF v_nc_reward > 0 AND p_status = 'completed' AND (v_previous_status IS DISTINCT FROM 'completed') THEN
      UPDATE public.profiles
      SET credits = credits + v_nc_reward
      WHERE id = v_user_uuid
      RETURNING credits INTO v_new_credits;
      v_already_awarded := TRUE;
  ELSE
      SELECT credits INTO v_new_credits FROM public.profiles WHERE id = v_user_uuid;
      v_already_awarded := FALSE;
  END IF;

  RETURN json_build_object(
    'success', TRUE,
    'new_credits', v_new_credits,
    'reward_awarded', CASE WHEN v_already_awarded THEN v_nc_reward ELSE 0 END,
    'status_update', p_status
  );

EXCEPTION WHEN OTHERS THEN
  RETURN json_build_object(
    'success', FALSE,
    'error', SQLERRM
  );
END;
$$;
