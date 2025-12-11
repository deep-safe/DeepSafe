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
  p_score INT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_uuid UUID;
  v_nc_reward INT;
  v_new_credits INT;
BEGIN
  -- Cast user_id to UUID explicitly
  BEGIN
    v_user_uuid := p_user_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object('success', FALSE, 'error', 'Invalid user_id format');
  END;

  -- 1. Fetch Mission Reward
  SELECT nc_reward INTO v_nc_reward
  FROM public.missions
  WHERE id = p_level_id;

  IF v_nc_reward IS NULL THEN
    v_nc_reward := 0;
  END IF;

  -- 2. Mark Mission/Level as Completed
  INSERT INTO public.user_progress (user_id, quiz_id, score, status, completed_at)
  VALUES (v_user_uuid, p_level_id, p_score, 'completed', NOW())
  ON CONFLICT (user_id, quiz_id)
  DO UPDATE SET
    score = GREATEST(user_progress.score, EXCLUDED.score),
    status = 'completed',
    completed_at = NOW();

  -- 3. Update User Profile Credits (NC)
  IF v_nc_reward > 0 THEN
      UPDATE public.profiles
      SET credits = credits + v_nc_reward
      WHERE id = v_user_uuid
      RETURNING credits INTO v_new_credits;
  ELSE
      SELECT credits INTO v_new_credits FROM public.profiles WHERE id = v_user_uuid;
  END IF;

  RETURN json_build_object(
    'success', TRUE,
    'new_credits', v_new_credits,
    'reward_awarded', v_nc_reward
  );

EXCEPTION WHEN OTHERS THEN
  RETURN json_build_object(
    'success', FALSE,
    'error', SQLERRM
  );
END;
$$;
