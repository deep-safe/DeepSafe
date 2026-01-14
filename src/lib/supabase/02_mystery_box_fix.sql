-- 1. Create Loot Table if not exists
CREATE TABLE IF NOT EXISTS mystery_box_loot (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    box_id TEXT NOT NULL, -- references shop_items(id) ideally, but text is fine for loose coupling
    reward_type TEXT NOT NULL, -- 'xp', 'credits', 'lives', 'streak_freeze', 'avatar'
    reward_value INTEGER DEFAULT 0,
    weight FLOAT DEFAULT 1.0,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Ensure Mystery Box Item Exists in Shop
INSERT INTO shop_items (id, name, description, cost, icon, effect_type, is_visible, is_limited)
VALUES (
    'mystery_box',
    'Cassa Crittografata',
    'Tenta la fortuna! Contiene premi casuali.',
    1000,
    '🎁',
    'mystery_box',
    true,
    false
)
ON CONFLICT (id) DO NOTHING;

-- 3. Seed Loot Data
DO $$
DECLARE
    v_box_id TEXT := 'mystery_box';
BEGIN
    -- Clear existing loot for this box to avoid duplicates/stale data
    DELETE FROM mystery_box_loot WHERE box_id = v_box_id;

    -- XP Rewards (Total 30%)
    -- NOTE: XP is deprecated for Ranking, but kept as a reward for legacy or maybe converted to Credits? 
    -- User removed XP from UI. Maybe we should swap XP rewards for Emeralds or just more Credits?
    -- Let's keep XP for now as hidden stat or 'Legacy XP', OR swap to small credit amounts.
    -- Let's swap XP to Credits to be safe and consistent with the new direction.
    
    -- Credits Rewards (Expanded to replace XP)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'credits', 25,  15, 'Crediti Base'),
    (v_box_id, 'credits', 50,  10, 'Crediti Extra'),
    (v_box_id, 'credits', 100, 5,  'Gruzzolo Crediti'),
    (v_box_id, 'credits', 200, 2,  'Tesoro Crediti'),
    (v_box_id, 'credits', 10,  20, 'Bagel di Consolazione'), -- Replaces low XP
    (v_box_id, 'credits', 500, 1,  'JACKPOT Crediti');

    -- Lives (25%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'lives', 5, 25, 'Ricarica Vite (+5)');

    -- Streak Freeze (12%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'streak_freeze', 1, 12, 'Congela Serie');

    -- Avatar (10%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'avatar', 0, 10, 'Nuovo Avatar');
    
END $$;

-- 4. Create/Update RPC Function
CREATE OR REPLACE FUNCTION open_mystery_box(p_user_id UUID)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_profile RECORD;
    v_cost INT := 500;
    
    -- Variables for Weighted Logic
    v_loot_record RECORD;
    v_total_weight FLOAT := 0;
    v_random_weight FLOAT;
    v_current_weight FLOAT := 0;
    v_selected_loot RECORD;
    v_box_id TEXT := 'mystery_box';
    
    -- Variables for Reward Processing
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

    -- 2. Validate Loot Exists
    SELECT SUM(weight) INTO v_total_weight FROM mystery_box_loot WHERE box_id = v_box_id;
    
    IF v_total_weight IS NULL OR v_total_weight = 0 THEN
        RETURN jsonb_build_object('success', false, 'message', 'Cassa vuota (Nessun loot configurato)');
    END IF;

    -- 3. Deduct Credits
    UPDATE profiles 
    SET credits = credits - v_cost 
    WHERE id = p_user_id;

    -- 4. Select Loot (Weighted Random)
    v_random_weight := random() * v_total_weight;
    
    FOR v_loot_record IN SELECT * FROM mystery_box_loot WHERE box_id = v_box_id ORDER BY weight DESC LOOP
        v_current_weight := v_current_weight + v_loot_record.weight;
        IF v_random_weight <= v_current_weight THEN
            v_selected_loot := v_loot_record;
            EXIT;
        END IF;
    END LOOP;

    -- Fallback
    IF v_selected_loot IS NULL THEN
         UPDATE profiles SET credits = credits + v_cost WHERE id = p_user_id; -- Refund
         RETURN jsonb_build_object('success', false, 'message', 'Errore estrazione premio');
    END IF;

    v_reward_type := v_selected_loot.reward_type;
    v_reward_value_int := v_selected_loot.reward_value;

    -- 5. Process Specific Reward Types
    
    -- Credits
    IF v_reward_type = 'credits' THEN
        UPDATE profiles SET credits = credits + v_reward_value_int WHERE id = p_user_id;
        
    -- Lives
    ELSIF v_reward_type = 'lives' THEN
        -- Increment hearts, capped at 5
        UPDATE profiles 
        SET current_hearts = LEAST(COALESCE(current_hearts, 0) + v_reward_value_int, 5) 
        WHERE id = p_user_id;
        
    -- Streak Freeze
    ELSIF v_reward_type = 'streak_freeze' THEN
        UPDATE profiles SET streak_freezes = COALESCE(streak_freezes, 0) + v_reward_value_int WHERE id = p_user_id;
        
    -- Avatar
    ELSIF v_reward_type = 'avatar' THEN
        SELECT * INTO v_avatar_record FROM avatars ORDER BY random() LIMIT 1;
        
        IF v_avatar_record IS NULL THEN
             -- Fallback: 50 Credits
             v_reward_type := 'credits';
             v_reward_value_int := 50; 
             v_message := 'Nessun avatar disponibile';
             UPDATE profiles SET credits = credits + 50 WHERE id = p_user_id;
        ELSE
             v_owned_avatars := COALESCE(v_profile.owned_avatars, '{}');
             
             IF v_avatar_record.id = ANY(v_owned_avatars) THEN
                 -- Duplicate: 50 Credits
                 v_reward_type := 'credits';
                 v_reward_value_int := 50;
                 v_message := 'Conversione per duplicato';
                 
                 UPDATE profiles SET credits = credits + 50 WHERE id = p_user_id;
             ELSE
                 -- New Avatar
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
