-- Fix complete_level function to work with Missions (removing dependency on 'levels' table)
-- This ensures that completing a mission (which has an ID not in 'levels') doesn't fail.

DROP FUNCTION IF EXISTS complete_level(uuid, text, int, int);
DROP FUNCTION IF EXISTS complete_level(text, text, int, int);

CREATE OR REPLACE FUNCTION complete_level(
  p_user_id TEXT,
  p_level_id TEXT,
  p_score INT,
  p_earned_xp INT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_uuid UUID;
  v_new_xp INT;
BEGIN
  -- Cast user_id to UUID explicitly
  BEGIN
    v_user_uuid := p_user_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object('success', FALSE, 'error', 'Invalid user_id format');
  END;

  -- 1. Update User Profile XP
  UPDATE public.profiles
  SET xp = COALESCE(xp, 0) + p_earned_xp,
      updated_at = NOW()
  WHERE id = v_user_uuid
  RETURNING xp INTO v_new_xp;

  -- 2. Mark Mission/Level as Completed in user_progress
  INSERT INTO public.user_progress (user_id, quiz_id, score, status, completed_at)
  VALUES (v_user_uuid, p_level_id, p_score, 'completed', NOW())
  ON CONFLICT (user_id, quiz_id)
  DO UPDATE SET
    score = GREATEST(user_progress.score, EXCLUDED.score),
    status = 'completed',
    completed_at = NOW();

  -- 3. (Optional) Legacy Next Level Logic
  -- We removed the 'levels' table dependency here to prevent errors when p_level_id is a Mission ID.
  -- If we need to unlock the next mission, we should handle it via a separate 'unlock_mission' logic 
  -- or rely on the frontend/province logic.

  RETURN json_build_object(
    'success', TRUE,
    'new_xp', v_new_xp
  );

EXCEPTION WHEN OTHERS THEN
  RETURN json_build_object(
    'success', FALSE,
    'error', SQLERRM
  );
END;
$$;
