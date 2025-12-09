-- 04_purchase_item_logic.sql

-- 1. Ensure the Streak Freeze Item exists in the Shop
INSERT INTO shop_items (id, name, description, cost, icon, effect_type, effect_value, is_visible, is_limited)
VALUES (
    'streak_freeze', 
    'Congelamento Serie', 
    'Proteggi la tua serie se salti un giorno di allenamento.', 
    2000, 
    '❄️', 
    'streak_freeze', 
    1, 
    true, 
    false
)
ON CONFLICT (id) DO UPDATE 
SET 
    cost = 2000,
    effect_type = 'streak_freeze',
    effect_value = 1,
    is_visible = true;

-- 1.5 Add last_freeze_purchase_at column if not exists
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'last_freeze_purchase_at') THEN 
        ALTER TABLE profiles ADD COLUMN last_freeze_purchase_at TIMESTAMPTZ; 
    END IF; 
END $$;

-- 2. Define/Update the purchase_item RPC
-- Drop first because we might be changing return type (e.g. JSON -> JSONB)
DROP FUNCTION IF EXISTS purchase_item(UUID, TEXT);

CREATE OR REPLACE FUNCTION purchase_item(p_user_id UUID, p_item_id TEXT)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_profile RECORD;
    v_item RECORD;
    v_new_credits INT;
    v_time_diff INTERVAL;
    v_hours_remaining INT;
BEGIN
    -- Get User
    SELECT * INTO v_profile FROM profiles WHERE id = p_user_id;
    IF v_profile IS NULL THEN
        RETURN jsonb_build_object('success', false, 'message', 'Utente non trovato');
    END IF;

    -- Get Item
    SELECT * INTO v_item FROM shop_items WHERE id = p_item_id;
    IF v_item IS NULL THEN
        RETURN jsonb_build_object('success', false, 'message', 'Oggetto non trovato');
    END IF;

    -- Check Streak Freeze Cooldown (24h)
    IF v_item.effect_type = 'streak_freeze' THEN
        IF v_profile.last_freeze_purchase_at IS NOT NULL AND (NOW() - v_profile.last_freeze_purchase_at) < INTERVAL '24 hours' THEN
             v_time_diff := INTERVAL '24 hours' - (NOW() - v_profile.last_freeze_purchase_at);
             v_hours_remaining := EXTRACT(HOUR FROM v_time_diff) + 1; -- Ceil approximation
             RETURN jsonb_build_object('success', false, 'message', format('Puoi acquistare un altro congelamento tra %s ore.', v_hours_remaining));
        END IF;
    END IF;

    -- Check Credits
    IF v_profile.credits < v_item.cost THEN
        RETURN jsonb_build_object('success', false, 'message', 'Crediti insufficienti');
    END IF;

    -- Check Stock (if limited)
    IF v_item.is_limited AND v_item.stock IS NOT NULL AND v_item.stock <= 0 THEN
        RETURN jsonb_build_object('success', false, 'message', 'Oggetto esaurito');
    END IF;

    -- DEDUCT CREDITS
    v_new_credits := v_profile.credits - v_item.cost;
    UPDATE profiles SET credits = v_new_credits WHERE id = p_user_id;

    -- DECREMENT STOCK (If Limited)
    IF v_item.is_limited AND v_item.stock IS NOT NULL THEN
        UPDATE shop_items SET stock = stock - 1 WHERE id = p_item_id;
    END IF;

    -- APPLY EFFECT
    -- A. Streak Freeze
    IF v_item.effect_type = 'streak_freeze' THEN
        UPDATE profiles 
        SET 
            streak_freezes = COALESCE(streak_freezes, 0) + COALESCE(v_item.effect_value, 1),
            last_freeze_purchase_at = NOW()
        WHERE id = p_user_id;
    
    -- B. Lives (Hearts) - UNCAPPED LOGIC
    ELSIF v_item.effect_type = 'lives_refill' OR v_item.effect_type = 'lives' THEN
         UPDATE profiles 
         SET current_hearts = COALESCE(current_hearts, 0) + COALESCE(v_item.effect_value, 5)
         WHERE id = p_user_id;

    -- C. XP Boost (Future proofing) or other types
    -- Add more conditions here as needed...

    END IF;

    -- Return Success
    RETURN jsonb_build_object(
        'success', true, 
        'message', 'Acquisto completato',
        'new_credits', v_new_credits,
        'reward', jsonb_build_object(
            'type', v_item.effect_type,
            'value', v_item.effect_value
        )
    );

EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
