-- Add badge_reward_id to levels table
ALTER TABLE levels ADD COLUMN IF NOT EXISTS badge_reward_id TEXT REFERENCES badges(id);

-- Update complete_level to award badges
CREATE OR REPLACE FUNCTION complete_level(
    p_user_id UUID,
    p_level_id TEXT,
    p_score INTEGER,
    p_earned_xp INTEGER
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_current_xp INTEGER;
    v_new_xp INTEGER;
    v_current_credits INTEGER;
    v_badge_reward_id TEXT;
    v_badge_earned BOOLEAN := false;
    v_existing_badges JSONB;
BEGIN
    -- Get current stats and existing badges
    SELECT xp, credits, earned_badges INTO v_current_xp, v_current_credits, v_existing_badges
    FROM profiles
    WHERE id = p_user_id;

    -- Get badge reward for this level
    SELECT badge_reward_id INTO v_badge_reward_id
    FROM levels
    WHERE id = p_level_id;

    -- Calculate new stats
    v_new_xp := COALESCE(v_current_xp, 0) + p_earned_xp;
    
    -- Handle Badge Awarding
    IF v_badge_reward_id IS NOT NULL THEN
        -- Check if already earned
        IF NOT (v_existing_badges @> jsonb_build_array(jsonb_build_object('id', v_badge_reward_id))) THEN
            -- Add new badge
            v_existing_badges := COALESCE(v_existing_badges, '[]'::jsonb) || jsonb_build_object('id', v_badge_reward_id, 'earned_at', NOW());
            v_badge_earned := true;
        END IF;
    END IF;

    -- Update profile
    UPDATE profiles
    SET 
        xp = v_new_xp,
        credits = COALESCE(v_current_credits, 0) + p_earned_xp, -- Dual Ledger: XP = Lifetime, Credits = Spendable
        earned_badges = v_existing_badges,
        updated_at = NOW()
    WHERE id = p_user_id;

    -- Log to XP Ledger
    INSERT INTO xp_ledger (user_id, amount, source, details)
    VALUES (p_user_id, p_earned_xp, 'level', jsonb_build_object('level_id', p_level_id, 'score', p_score));

    -- Log to User Activities
    INSERT INTO user_activities (user_id, activity_type, details)
    VALUES (p_user_id, 'level_complete', jsonb_build_object(
        'level_id', p_level_id, 
        'score', p_score, 
        'xp_earned', p_earned_xp,
        'badge_earned', CASE WHEN v_badge_earned THEN v_badge_reward_id ELSE NULL END
    ));

    RETURN jsonb_build_object(
        'success', true, 
        'new_xp', v_new_xp,
        'new_badge_id', CASE WHEN v_badge_earned THEN v_badge_reward_id ELSE NULL END
    );
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;

-- Insert missing badges if they don't exist
INSERT INTO badges (id, name, description, icon, category, xp_reward, rarity, condition_type, condition_value)
VALUES 
    ('shield_bearer', 'Portatore dello Scudo', 'Hai configurato l''Autenticazione a Due Fattori (2FA).', '🛡️', 'security', 150, 'rare', 'mission_complete', '2fa_setup'),
    ('scam_slayer', 'Cacciatore di Truffe', 'Hai imparato a riconoscere il Phishing.', '🎣', 'security', 100, 'common', 'mission_complete', 'phishing_101')
ON CONFLICT (id) DO NOTHING;

-- Seed Data: Link badges to specific levels
-- Level 3: Password Sicure -> shield_bearer
UPDATE levels 
SET badge_reward_id = 'shield_bearer' 
WHERE id = '70007efe-b145-4216-9e10-366cd145a811';

-- Level 2: Riconoscere il Phishing -> scam_slayer
UPDATE levels 
SET badge_reward_id = 'scam_slayer' 
WHERE id = '8024aa31-ae3c-4516-87a5-70468d7cde41';
