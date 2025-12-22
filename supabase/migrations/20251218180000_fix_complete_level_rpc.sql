-- Migration to fix complete_level RPC signature and logic (V4 Strategy - ADAPIIVE)
-- Handles both UUIDs (Database Missions) and Slugs (Hardcoded 'phishing-mission-1' etc)
-- Skips missions table lookup for Slugs to avoid "operator does not exist: uuid = text"
-- Attempts to insert Slugs as TEXT into user_progress.

CREATE OR REPLACE FUNCTION public.complete_level_v4(
    p_user_id TEXT,
    p_level_id TEXT,
    p_score INT,
    p_status TEXT DEFAULT 'completed'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_uuid UUID;
    v_level_uuid UUID;
    v_is_level_uuid BOOLEAN := FALSE;
    v_mission_reward INT := 0;
    v_new_nc INT;
    v_prev_status TEXT;
    v_updated_row JSONB;
BEGIN
    -- 1. Safe Cast User ID (Must be UUID)
    BEGIN
        v_user_uuid := p_user_id::UUID;
    EXCEPTION WHEN invalid_text_representation THEN
        RETURN jsonb_build_object('success', false, 'error', 'Invalid UUID format for user_id');
    END;

    -- 2. Check if Level ID is UUID (for Mission Lookup)
    BEGIN
        v_level_uuid := p_level_id::UUID;
        v_is_level_uuid := TRUE;
    EXCEPTION WHEN invalid_text_representation THEN
        v_level_uuid := NULL;
        v_is_level_uuid := FALSE;
    END;

    -- 3. Get mission reward/info (ONLY IF UUID)
    IF v_is_level_uuid THEN
        -- Try missions table first (nc_reward)
        SELECT nc_reward INTO v_mission_reward
        FROM missions
        WHERE id = v_level_uuid;

        -- If not found, try levels table (xp_reward) as fallback
        IF v_mission_reward IS NULL THEN
            SELECT xp_reward INTO v_mission_reward
            FROM levels
            WHERE id = v_level_uuid;
        END IF;
    END IF;

    -- Default reward if not found or Slug
    IF v_mission_reward IS NULL THEN
        v_mission_reward := 0;
    END IF;

    -- 4. Check previous status in user_progress
    -- We use p_level_id (TEXT) here to support Slugs.
    -- If user_progress.quiz_id is UUID, this query might fail for Slugs unless we cast column to text?
    -- Standard text comparison should work if column is text.
    -- If column is UUID, we can't query it with a slug anyway.
    
    SELECT status INTO v_prev_status
    FROM user_progress
    WHERE user_id = v_user_uuid AND quiz_id = p_level_id;

    -- 5. Update or Insert into user_progress
    INSERT INTO user_progress (user_id, quiz_id, score, status, completed_at)
    VALUES (v_user_uuid, p_level_id, p_score, p_status, NOW())
    ON CONFLICT (user_id, quiz_id)
    DO UPDATE SET
        score = GREATEST(user_progress.score, EXCLUDED.score),
        status = EXCLUDED.status,
        completed_at = CASE 
            WHEN user_progress.status <> 'completed' AND EXCLUDED.status = 'completed' THEN NOW()
            ELSE user_progress.completed_at 
        END
    RETURNING to_jsonb(user_progress.*) INTO v_updated_row;

    -- 6. Award NC (NeuroCredits) ONLY if completing for the first time
    IF p_status = 'completed' AND (v_prev_status IS NULL OR v_prev_status <> 'completed') AND v_mission_reward > 0 THEN
        UPDATE profiles
        SET credits = credits + v_mission_reward
        WHERE id = v_user_uuid
        RETURNING credits INTO v_new_nc;
    ELSE
        SELECT credits INTO v_new_nc FROM profiles WHERE id = v_user_uuid;
    END IF;

    -- 7. Return result
    RETURN jsonb_build_object(
        'success', true,
        'mission_id', p_level_id,
        'new_status', p_status,
        'nc_awarded', CASE WHEN p_status = 'completed' AND (v_prev_status IS NULL OR v_prev_status <> 'completed') THEN v_mission_reward ELSE 0 END,
        'total_nc', v_new_nc,
        'new_credits', v_new_nc,
        'progress', v_updated_row
    );
END;
$$;

-- FORCE SCHEMA CACHE REFRESH (Hack)
NOTIFY pgrst, 'reload schema';
