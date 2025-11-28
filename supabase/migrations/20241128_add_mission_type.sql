
-- Add type column to missions table
ALTER TABLE missions ADD COLUMN IF NOT EXISTS type TEXT DEFAULT 'quiz';

-- Update existing missions to have a type (optional, can be refined based on content)
UPDATE missions SET type = 'quiz' WHERE type IS NULL;

-- Update claim_mission_reward to log mission type
CREATE OR REPLACE FUNCTION claim_mission_reward(
    p_user_id UUID,
    p_mission_id TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_mission_xp INTEGER;
    v_current_xp INTEGER;
    v_new_xp INTEGER;
    v_current_credits INTEGER;
    v_mission_title TEXT;
    v_mission_type TEXT;
BEGIN
    -- Get mission details
    SELECT xp_reward, title, type INTO v_mission_xp, v_mission_title, v_mission_type
    FROM missions
    WHERE id = p_mission_id;

    IF v_mission_xp IS NULL THEN
        v_mission_xp := 50; 
        v_mission_title := 'Missione';
        v_mission_type := 'quiz';
    END IF;

    -- Get current stats
    SELECT xp, credits INTO v_current_xp, v_current_credits
    FROM profiles
    WHERE id = p_user_id;

    -- Calculate new stats
    v_new_xp := COALESCE(v_current_xp, 0) + v_mission_xp;

    -- Update profile
    UPDATE profiles
    SET 
        xp = v_new_xp,
        credits = COALESCE(v_current_credits, 0) + v_mission_xp,
        updated_at = NOW()
    WHERE id = p_user_id;

    -- Log to XP Ledger
    INSERT INTO xp_ledger (user_id, amount, source, details)
    VALUES (p_user_id, v_mission_xp, 'mission', jsonb_build_object('mission_id', p_mission_id));

    -- Log to User Activities
    INSERT INTO user_activities (user_id, activity_type, details)
    VALUES (p_user_id, 'mission_complete', jsonb_build_object(
        'mission_id', p_mission_id, 
        'title', v_mission_title, 
        'xp_earned', v_mission_xp,
        'type', v_mission_type
    ));

    RETURN jsonb_build_object('success', true, 'new_xp', v_new_xp);
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
