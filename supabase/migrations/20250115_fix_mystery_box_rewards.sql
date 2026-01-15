-- Fix: Remove lives rewards (lives column doesn't exist in profiles)
-- Use only credits as rewards

-- 1. Clear existing loot
DELETE FROM mystery_box_loot WHERE box_id IN ('mystery_box_basic', 'mystery_box_rare', 'mystery_box_legendary');

-- 2. BASIC BOX - Only credits, various amounts
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description)
VALUES
('mystery_box_basic', 'credits', 50, 35, '50 NC'),
('mystery_box_basic', 'credits', 100, 30, '100 NC'),
('mystery_box_basic', 'credits', 150, 20, '150 NC'),
('mystery_box_basic', 'credits', 200, 10, '200 NC'),
('mystery_box_basic', 'credits', 300, 8, '300 NC'),
('mystery_box_basic', 'credits', 500, 5, '500 NC'),
('mystery_box_basic', 'credits', 800, 2, '800 NC JACKPOT!');

-- 3. RARE BOX - Better credit amounts
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description)
VALUES
('mystery_box_rare', 'credits', 150, 25, '150 NC'),
('mystery_box_rare', 'credits', 250, 25, '250 NC'),
('mystery_box_rare', 'credits', 400, 20, '400 NC'),
('mystery_box_rare', 'credits', 600, 15, '600 NC'),
('mystery_box_rare', 'credits', 800, 10, '800 NC'),
('mystery_box_rare', 'credits', 1200, 8, '1200 NC'),
('mystery_box_rare', 'credits', 2000, 2, '2000 NC JACKPOT!');

-- 4. WOW BOX - High credit amounts
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, weight, description)
VALUES
('mystery_box_legendary', 'credits', 500, 20, '500 NC'),
('mystery_box_legendary', 'credits', 800, 20, '800 NC'),
('mystery_box_legendary', 'credits', 1200, 18, '1200 NC'),
('mystery_box_legendary', 'credits', 1500, 15, '1500 NC'),
('mystery_box_legendary', 'credits', 2000, 12, '2000 NC'),
('mystery_box_legendary', 'credits', 3000, 8, '3000 NC'),
('mystery_box_legendary', 'credits', 5000, 5, '5000 NC MEGA!'),
('mystery_box_legendary', 'credits', 10000, 2, '10000 NC ULTRA MEGA!');

-- 5. Simplified purchase_item function (credits only)
DROP FUNCTION IF EXISTS purchase_item(uuid, text);

CREATE FUNCTION purchase_item(p_user_id uuid, p_item_id text)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_item_cost int;
    v_user_credits int;
    v_loot record;
    v_total_weight int;
    v_random_weight int;
    v_current_weight int;
    v_reward_value int;
BEGIN
    -- Check item cost
    SELECT cost INTO v_item_cost FROM shop_items WHERE id = p_item_id;
    IF NOT FOUND THEN
        RETURN json_build_object('success', false, 'message', 'Item not found');
    END IF;

    -- Check user credits
    SELECT credits INTO v_user_credits FROM profiles WHERE id = p_user_id;
    IF v_user_credits < v_item_cost THEN
        RETURN json_build_object('success', false, 'message', 'Insufficient credits');
    END IF;

    -- Deduct credits
    UPDATE profiles SET credits = credits - v_item_cost WHERE id = p_user_id;

    -- Handle Mystery Box
    IF p_item_id LIKE 'mystery_box%' THEN
        -- Calculate total weight
        SELECT SUM(weight) INTO v_total_weight FROM mystery_box_loot WHERE box_id = p_item_id;
        
        -- Pick random weight
        v_random_weight := floor(random() * v_total_weight + 1);
        v_current_weight := 0;

        -- Select loot (all rewards are credits now)
        FOR v_loot IN SELECT * FROM mystery_box_loot WHERE box_id = p_item_id ORDER BY weight DESC LOOP
            v_current_weight := v_current_weight + v_loot.weight;
            IF v_random_weight <= v_current_weight THEN
                v_reward_value := v_loot.reward_value;
                EXIT;
            END IF;
        END LOOP;

        -- Grant credits reward
        UPDATE profiles SET credits = credits + v_reward_value WHERE id = p_user_id;
        RETURN json_build_object(
            'success', true, 
            'message', 'Mystery Box opened!', 
            'reward', json_build_object('type', 'credits', 'value', v_reward_value)
        );
    ELSE
        -- Normal Item Purchase
        RETURN json_build_object('success', true, 'message', 'Item purchased');
    END IF;
END;
$$;
