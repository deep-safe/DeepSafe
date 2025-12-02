-- Update complete_level to award both Credits and XP (Lifetime NC)
-- This implements the "Dual Ledger" system where XP tracks lifetime earnings and Credits are spendable.

DROP FUNCTION IF EXISTS complete_level(uuid, text, int, int);
DROP FUNCTION IF EXISTS complete_level(text, text, int, int);

CREATE OR REPLACE FUNCTION complete_level(
  p_user_id TEXT,
  p_level_id TEXT,
  p_score INT,
  p_earned_xp INT -- This is now "Earned NC" which goes to both XP (Lifetime) and Credits (Wallet)
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_uuid UUID;
  v_new_xp INT;
  v_new_credits INT;
BEGIN
  -- Cast user_id to UUID explicitly
  BEGIN
    v_user_uuid := p_user_id::UUID;
  EXCEPTION WHEN OTHERS THEN
    RETURN json_build_object('success', FALSE, 'error', 'Invalid user_id format');
  END;

  -- 1. Update User Profile: Increment XP (Lifetime) AND Credits (Wallet)
  UPDATE public.profiles
  SET xp = COALESCE(xp, 0) + p_earned_xp,
      credits = COALESCE(credits, 0) + p_earned_xp, -- Dual Ledger: Earn spendable credits too
      updated_at = NOW()
  WHERE id = v_user_uuid
  RETURNING xp, credits INTO v_new_xp, v_new_credits;

  -- 2. Mark Mission/Level as Completed in user_progress
  INSERT INTO public.user_progress (user_id, quiz_id, score, status, completed_at)
  VALUES (v_user_uuid, p_level_id, p_score, 'completed', NOW())
  ON CONFLICT (user_id, quiz_id)
  DO UPDATE SET
    score = GREATEST(user_progress.score, EXCLUDED.score),
    status = 'completed',
    completed_at = NOW();

  RETURN json_build_object(
    'success', TRUE,
    'new_xp', v_new_xp,
    'new_credits', v_new_credits
  );

EXCEPTION WHEN OTHERS THEN
  RETURN json_build_object(
    'success', FALSE,
    'error', SQLERRM
  );
END;
$$;
