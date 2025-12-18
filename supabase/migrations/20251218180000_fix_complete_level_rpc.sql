-- Migration to fix complete_level RPC signature and logic
-- This function matches the frontend call: completeLevel(levelId, score, status = 'completed')
-- It ensures proper parameter handling and reward distribution

CREATE OR REPLACE FUNCTION public.complete_level(
    p_user_id UUID,
    p_level_id TEXT,
    p_score INT,
    p_status TEXT DEFAULT 'completed'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_mission_reward INT;
    v_current_nc INT;
    v_new_nc INT;
    v_prev_status TEXT;
    v_updated_row JSONB;
BEGIN
    -- 1. Get mission reward/info
    SELECT nc_reward INTO v_mission_reward
    FROM missions
    WHERE id = p_level_id;

    -- Default reward if mission not found (though it should be)
    IF v_mission_reward IS NULL THEN
        v_mission_reward := 0;
    END IF;

    -- 2. Check previous status in user_progress
    SELECT status INTO v_prev_status
    FROM user_progress
    WHERE user_id = p_user_id AND mission_id = p_level_id;

    -- 3. Update or Insert into user_progress
    INSERT INTO user_progress (user_id, mission_id, score, status, completed_at, updated_at)
    VALUES (p_user_id, p_level_id, p_score, p_status, NOW(), NOW())
    ON CONFLICT (user_id, mission_id)
    DO UPDATE SET
        score = GREATEST(user_progress.score, EXCLUDED.score),
        status = EXCLUDED.status,
        completed_at = CASE 
            WHEN user_progress.status <> 'completed' AND EXCLUDED.status = 'completed' THEN NOW()
            ELSE user_progress.completed_at 
        END,
        updated_at = NOW()
    RETURNING to_jsonb(user_progress.*) INTO v_updated_row;

    -- 4. Award NC (NeuroCredits) ONLY if completing for the first time
    IF p_status = 'completed' AND (v_prev_status IS NULL OR v_prev_status <> 'completed') AND v_mission_reward > 0 THEN
        UPDATE profiles
        SET nc = nc + v_mission_reward
        WHERE id = p_user_id
        RETURNING nc INTO v_new_nc;
    ELSE
        SELECT nc INTO v_new_nc FROM profiles WHERE id = p_user_id;
    END IF;

    -- 5. Return result
    RETURN jsonb_build_object(
        'success', true,
        'mission_id', p_level_id,
        'new_status', p_status,
        'nc_awarded', CASE WHEN p_status = 'completed' AND (v_prev_status IS NULL OR v_prev_status <> 'completed') THEN v_mission_reward ELSE 0 END,
        'total_nc', v_new_nc,
        'progress', v_updated_row
    );
END;
$$;
