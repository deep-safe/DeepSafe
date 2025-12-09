-- Create a stored procedure (RPC) for opening the mystery box atomically
-- Run this in the Supabase SQL Editor

CREATE OR REPLACE FUNCTION open_mystery_box(p_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER -- Runs with privileges of the creator (bypass RLS for update if needed)
AS $$
DECLARE
    v_profile RECORD;
    v_cost INT := 50;
    v_roll FLOAT;
    v_reward_type TEXT;
    v_reward_value_int INT;
    v_reward_value_str TEXT;
    v_message TEXT := '';
    v_avatar_record RECORD;
    v_owned_avatars TEXT[];
BEGIN
    -- 1. Get Profile & Check Credits
    SELECT * INTO v_profile FROM profiles WHERE id = p_user_id;
    
    IF v_profile IS NULL THEN
        RETURN jsonb_build_object('success', false, 'message', 'Profilo non trovato');
    END IF;

    IF (v_profile.credits < v_cost) THEN
        RETURN jsonb_build_object('success', false, 'message', 'Crediti insufficienti');
    END IF;

    -- 2. Deduct Credits
    UPDATE profiles 
    SET credits = credits - v_cost 
    WHERE id = p_user_id;

    -- 3. Logic
    v_roll := random() * 100;
    
    -- XP (30%)
    IF v_roll < 30 THEN
        v_reward_type := 'xp';
        IF random() < 0.6 THEN v_reward_value_int := 100;
        ELSIF random() < 0.9 THEN v_reward_value_int := 250;
        ELSE v_reward_value_int := 500;
        END IF;

        UPDATE profiles SET xp = COALESCE(xp, 0) + v_reward_value_int WHERE id = p_user_id;

    -- Credits (30%)
    ELSIF v_roll < 60 THEN
        v_reward_type := 'credits';
        IF random() < 0.5 THEN v_reward_value_int := 25;
        ELSIF random() < 0.8 THEN v_reward_value_int := 50;
        ELSIF random() < 0.95 THEN v_reward_value_int := 100;
        ELSE v_reward_value_int := 200;
        END IF;

        -- We already deducted 50, now we add the win.
        UPDATE profiles SET credits = credits + v_reward_value_int WHERE id = p_user_id;

    -- Lives (20%)
    ELSIF v_roll < 80 THEN
        v_reward_type := 'lives';
        v_reward_value_int := 5;
        UPDATE profiles SET current_hearts = 5 WHERE id = p_user_id;

    -- Streak Freeze (10%)
    ELSIF v_roll < 90 THEN
        v_reward_type := 'streak_freeze';
        v_reward_value_int := 1;
        UPDATE profiles SET streak_freezes = COALESCE(streak_freezes, 0) + 1 WHERE id = p_user_id;

    -- Avatar (10%)
    ELSE
        -- Select a random avatar
        SELECT * INTO v_avatar_record FROM avatars ORDER BY random() LIMIT 1;
        
        IF v_avatar_record IS NULL THEN
             -- Fallback if no avatars exist
             v_reward_type := 'credits';
             v_reward_value_int := 50;
             UPDATE profiles SET credits = credits + 50 WHERE id = p_user_id;
        ELSE
             v_owned_avatars := COALESCE(v_profile.owned_avatars, '{}');
             
             -- Check duplicate
             IF v_avatar_record.id = ANY(v_owned_avatars) THEN
                 -- DUPLICATE FALLBACK -> XP
                 v_reward_type := 'xp';
                 v_reward_value_int := 300;
                 v_message := 'Conversion for duplicate avatar';
                 UPDATE profiles SET xp = COALESCE(xp, 0) + 300 WHERE id = p_user_id;
             ELSE
                 -- NEW AVATAR
                 v_reward_type := 'avatar';
                 v_reward_value_str := v_avatar_record.id;
                 UPDATE profiles 
                 SET owned_avatars = array_append(v_owned_avatars, v_avatar_record.id)
                 WHERE id = p_user_id;
             END IF;
        END IF;
    END IF;

    -- Return Result
    RETURN jsonb_build_object(
        'success', true, 
        'reward', jsonb_build_object(
            'type', v_reward_type,
            'value', COALESCE(v_reward_value_str, v_reward_value_int::TEXT),
            'message', v_message
        )
    );
END;
$$;
