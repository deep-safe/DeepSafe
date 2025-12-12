-- Create a comprehensive User Reset Function
-- This function wipes all progress-related data for a user, effectively treating them as a new signup.

CREATE OR REPLACE FUNCTION admin_reset_user(target_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- 1. Reset Profile Stats (XP, Credits, Streak, Hearts, etc.)
    UPDATE profiles
    SET 
        xp = 0,
        credits = 0,
        current_hearts = 5,
        highest_streak = 0,
        unlocked_provinces = ARRAY['CB', 'IS'], -- Reset to default starting provinces
        inventory = '[]'::jsonb,                -- Clear inventory (JSONB)
        earned_badges = '[]'::jsonb,            -- Clear badges (legacy JSONB column)
        rubies = 0,
        emeralds = 0,
        total_missions = 0,
        unlocked_missions_count = 0,
        province_scores = '{}'::jsonb,
        streak_freezes = 0,
        streak_freeze_active = false,
        completed_tiers = '{}'::jsonb,
        has_seen_tutorial = false
    WHERE id = target_user_id;

    -- 2. Clear User Progress (Quizzes, Lessons)
    DELETE FROM user_progress WHERE user_id = target_user_id;

    -- 3. Clear User Missions (Mission completion status)
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_missions') THEN
        DELETE FROM user_missions WHERE user_id = target_user_id;
    END IF;

    -- 4. Clear User Badges (Relation table)
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_badges') THEN
        DELETE FROM user_badges WHERE user_id = target_user_id;
    END IF;

    -- 5. Clear Push Subscriptions (Optional, but often good for a 'hard' reset to re-prompt)
    -- We generally keep these as they are device-specific settings, but if 'reset' means 'wipe app state', we might keep them.
    -- Let's KEEP them for now as it's more about game progress.

    -- 6. Clear Friendships?
    -- Usually 'Reset Progress' implies game stats. Removing friends might be too aggressive.
    -- We will KEEP friends for now unless requested otherwise. 

    -- 7. Clear Challenges
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'challenges') THEN
        DELETE FROM challenges WHERE challenger_id = target_user_id OR opponent_id = target_user_id;
    END IF;

    RETURN jsonb_build_object('success', true, 'message', 'User progress fully reset.');

EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
