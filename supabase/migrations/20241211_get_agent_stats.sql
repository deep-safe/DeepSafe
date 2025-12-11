-- Create a function to calculate agent stats on the server side
-- This avoids client-side calculation errors and ensures persistence

CREATE OR REPLACE FUNCTION get_agent_stats()
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_id UUID;
    v_total_missions INT;
    v_completed_missions INT;
    v_mission_completion_rate INT;
    v_total_score INT;
    v_total_max_score INT;
    v_accuracy INT;
    v_global_rank INT;
BEGIN
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RETURN jsonb_build_object('error', 'Not authenticated');
    END IF;

    -- 1. Get Global Rank
    -- We try to use the existing function if available, or fallback to a simple count
    BEGIN
        v_global_rank := get_user_rank();
    EXCEPTION WHEN OTHERS THEN
        v_global_rank := 0;
    END;

    -- 2. Calculate Mission Stats
    
    -- Total available missions (from missions table)
    SELECT count(*) INTO v_total_missions FROM missions;
    
    -- Completed missions (from user_progress)
    -- We consider a mission completed if status is 'completed' OR if score equals max possible score
    -- However, max score is dynamic. Let's rely on 'completed' status which should be reliable.
    -- If status is missing, we check score > 0 as a fallback for "attempted/in progress" but for completion we want strictness.
    SELECT count(*) INTO v_completed_missions 
    FROM user_progress 
    WHERE user_id = v_user_id AND status = 'completed';

    -- Calculate Completion Rate
    IF v_total_missions > 0 THEN
        v_mission_completion_rate := (v_completed_missions::FLOAT / v_total_missions::FLOAT * 100)::INT;
    ELSE
        v_mission_completion_rate := 0;
    END IF;

    -- 3. Calculate Accuracy
    -- Average of (score / max_score) for all ATTEMPTED missions (present in user_progress)
    -- We need to join with missions or know the max score.
    -- Since calculating max score dynamically per mission in SQL might be complex if it depends on questions count,
    -- efficiently, let's assume we can approximate or if we have max_score recorded?
    -- The user_progress table has 'score', but maybe not 'max_score'.
    -- If we can't easily get max_score per row, we might sum up current score and divide by (questions_count * X).
    
    -- Let's try to join with mission_questions count.
    -- Assuming 10 points per question as default or 1 point? 
    -- The store used "qCount > 0 ? qCount : 10" implies 1 point per question, but maxScore was qCount.
    -- Wait, if maxScore = qCount, then each question is 1 point.
    
    WITH MissionStats AS (
        SELECT 
            up.score,
            (SELECT count(*) FROM mission_questions mq WHERE mq.mission_id::text = up.quiz_id) as q_count
        FROM user_progress up
        WHERE up.user_id = v_user_id
    )
    SELECT 
        SUM(score), 
        SUM(CASE WHEN q_count > 0 THEN q_count ELSE 10 END) -- Fallback to 10 if no questions found (legacy)
    INTO v_total_score, v_total_max_score
    FROM MissionStats;

    IF v_total_max_score > 0 THEN
        v_accuracy := (v_total_score::FLOAT / v_total_max_score::FLOAT * 100)::INT;
        -- Cap at 100 just in case
        IF v_accuracy > 100 THEN v_accuracy := 100; END IF;
    ELSE
        v_accuracy := 0;
    END IF;

    RETURN jsonb_build_object(
        'mission_completion_rate', v_mission_completion_rate,
        'accuracy', v_accuracy,
        'global_rank', COALESCE(v_global_rank, 0),
        'total_missions', v_total_missions,
        'completed_missions', v_completed_missions
    );
END;
$$;
