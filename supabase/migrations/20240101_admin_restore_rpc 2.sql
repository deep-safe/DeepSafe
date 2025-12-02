-- Function to restore database from a JSON payload
-- This function is TRANSACTIONAL. If any step fails, it rolls back.

CREATE OR REPLACE FUNCTION admin_restore_data(payload JSONB)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER -- Runs with privileges of the creator (admin)
AS $$
DECLARE
    item JSONB;
BEGIN
    -- 1. DELETE Existing Data (Reverse Dependency Order)
    -- We use TRUNCATE CASCADE for speed and thoroughness, or DELETE if we want to be more surgical.
    -- Given this is a full restore, TRUNCATE is cleaner but might be too aggressive if we want to keep some system tables.
    -- Let's stick to DELETE for safety on specific tables.
    
    DELETE FROM user_progress;
    DELETE FROM mission_questions;
    DELETE FROM friendships;
    DELETE FROM challenges;
    DELETE FROM missions;
    DELETE FROM levels;
    DELETE FROM modules;
    DELETE FROM shop_items;
    DELETE FROM badges;
    DELETE FROM profiles; -- This cascades to many things usually, but we deleted children explicitly to be safe.

    -- 2. INSERT Data (Dependency Order)
    
    -- Profiles
    IF payload ? 'profiles' AND jsonb_array_length(payload->'profiles') > 0 THEN
        INSERT INTO profiles
        SELECT * FROM jsonb_populate_recordset(null::profiles, payload->'profiles');
    END IF;

    -- Modules
    IF payload ? 'modules' AND jsonb_array_length(payload->'modules') > 0 THEN
        INSERT INTO modules
        SELECT * FROM jsonb_populate_recordset(null::modules, payload->'modules');
    END IF;

    -- Levels
    IF payload ? 'levels' AND jsonb_array_length(payload->'levels') > 0 THEN
        INSERT INTO levels
        SELECT * FROM jsonb_populate_recordset(null::levels, payload->'levels');
    END IF;

    -- Missions
    IF payload ? 'missions' AND jsonb_array_length(payload->'missions') > 0 THEN
        INSERT INTO missions
        SELECT * FROM jsonb_populate_recordset(null::missions, payload->'missions');
    END IF;

    -- Mission Questions
    IF payload ? 'mission_questions' AND jsonb_array_length(payload->'mission_questions') > 0 THEN
        INSERT INTO mission_questions
        SELECT * FROM jsonb_populate_recordset(null::mission_questions, payload->'mission_questions');
    END IF;

    -- Shop Items
    IF payload ? 'shop_items' AND jsonb_array_length(payload->'shop_items') > 0 THEN
        INSERT INTO shop_items
        SELECT * FROM jsonb_populate_recordset(null::shop_items, payload->'shop_items');
    END IF;

    -- Badges
    IF payload ? 'badges' AND jsonb_array_length(payload->'badges') > 0 THEN
        INSERT INTO badges
        SELECT * FROM jsonb_populate_recordset(null::badges, payload->'badges');
    END IF;

    -- User Progress
    IF payload ? 'user_progress' AND jsonb_array_length(payload->'user_progress') > 0 THEN
        INSERT INTO user_progress
        SELECT * FROM jsonb_populate_recordset(null::user_progress, payload->'user_progress');
    END IF;

    -- Friendships
    IF payload ? 'friendships' AND jsonb_array_length(payload->'friendships') > 0 THEN
        INSERT INTO friendships
        SELECT * FROM jsonb_populate_recordset(null::friendships, payload->'friendships');
    END IF;

    -- Challenges
    IF payload ? 'challenges' AND jsonb_array_length(payload->'challenges') > 0 THEN
        INSERT INTO challenges
        SELECT * FROM jsonb_populate_recordset(null::challenges, payload->'challenges');
    END IF;

    RETURN jsonb_build_object('success', true, 'message', 'Restore completed successfully');

EXCEPTION WHEN OTHERS THEN
    -- The transaction will automatically rollback
    RAISE EXCEPTION 'Restore failed: %', SQLERRM;
END;
$$;
