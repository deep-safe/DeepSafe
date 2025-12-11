-- Migration to rename xp_reward to nc_reward and update complete_level RPC

-- 1. Rename the column in missions table
ALTER TABLE public.missions 
RENAME COLUMN xp_reward TO nc_reward;

-- 2. Update the complete_level function to:
--    a) Fetch the mission's nc_reward from the database (Secure)
--    b) Add it to the user's credits (NC) balance
--    c) Mark the mission as completed in user_progress

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
  v_mission_exists BOOLEAN;
BEGIN
  -- Cast user_id to UUID explicitly
  BEGIN
    v_user_uuid := p_user_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object('success', FALSE, 'error', 'Invalid user_id format');
  END;

  -- 1. Fetch Mission Reward (Source of Truth)
  SELECT nc_reward INTO v_nc_reward
  FROM public.missions
  WHERE id = p_level_id;

  IF v_nc_reward IS NULL THEN
    -- Fallback/Error if mission not found (or legacy level logic?)
    -- Assuming this RPC is primarily for MISSIONS now.
    -- If it's null, maybe it's 0.
    v_nc_reward := 0;
  END IF;

  -- 2. Mark Mission/Level as Completed in user_progress
  -- We do this FIRST to handle "First Completion" logic if we wanted (e.g. only reward on first).
  -- Requirement says: "controlli che nc_reward venga effettivamente accreditata"
  -- Usually we award every time OR only first time? 
  -- In this app's logic (viewed earlier in store), completeLevel seems to check 'wasCompleted' client side for gems/rubies.
  -- For NC (Credits), let's assume we award it every time they complete it successfully (grinding)? 
  -- OR strictly first time?
  -- Most "training" apps give rewards only on first completion or reduced on repeat.
  -- Given the user didn't specify "only first time", but implied "when passing the mission", I will award it.
  -- SAFEST APPROACH: Check if already completed to decide on reward?
  -- User request: "controlli che nc_reward venga effettivamente accreditata"
  -- I will award it. If strict logic is needed later, we can adjust.
  
  INSERT INTO public.user_progress (user_id, quiz_id, score, status, completed_at)
  VALUES (v_user_uuid, p_level_id, p_score, 'completed', NOW())
  ON CONFLICT (user_id, quiz_id)
  DO UPDATE SET
    score = GREATEST(user_progress.score, EXCLUDED.score),
    status = 'completed',
    completed_at = NOW();

  -- 3. Update User Profile Credits (NC) 
  -- Only if reward > 0
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
