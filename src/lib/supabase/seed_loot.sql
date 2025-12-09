DO $$
DECLARE
    v_box_id TEXT;
BEGIN
    -- 1. Find the Mystery Box ID dynamically
    SELECT id INTO v_box_id FROM shop_items WHERE effect_type = 'mystery_box' LIMIT 1;

    -- If not found, you could optionally insert it, but for now we'll just warn
    IF v_box_id IS NULL THEN
        RAISE NOTICE 'Mystery Box item not found in shop_items. Please create it first.';
        RETURN;
    END IF;

    -- 2. Clear existing loot for this box
    DELETE FROM mystery_box_loot WHERE box_id = v_box_id;

    -- 3. Insert Defaults
    -- XP Rewards (Total 30%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'xp', 100, 18, 'Piccolo Boost XP'),   -- 60% of 30% = 18
    (v_box_id, 'xp', 250, 9,  'Medio Boost XP'),    -- 30% of 30% = 9
    (v_box_id, 'xp', 500, 3,  'Grande Boost XP');   -- 10% of 30% = 3

    -- Credits Rewards (Total 30%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'credits', 25,  15, 'Crediti Base'),      -- 50% of 30% = 15
    (v_box_id, 'credits', 50,  9,  'Crediti Extra'),     -- 30% of 30% = 9
    (v_box_id, 'credits', 100, 4.5, 'Gruzzolo Crediti'), -- 15% of 30% = 4.5
    (v_box_id, 'credits', 200, 1.5, 'Tesoro Crediti');   -- 5% of 30% = 1.5

    -- Lives (20%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'lives', 5, 20, 'Ricarica Vite (+5)');

    -- Streak Freeze (10%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'streak_freeze', 1, 10, 'Congela Serie');

    -- Avatar (10%)
    INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description) VALUES
    (v_box_id, 'avatar', 0, 10, 'Nuovo Avatar');
    
    RAISE NOTICE 'Loot seeded successfully for Box ID: %', v_box_id;

END $$;
