-- =====================================================
-- FIX PRO REWARDS LOGIC (2026-01-15)
-- =====================================================
-- Problem: If user is already Pro, earning months (referral/feedback) 
-- only incremented 'pro_months_earned' but didn't extend the actual subscription.
--
-- Solution:
-- 1. If PRO is ACTIVE: Immediately extend 'pro_expires_at' by 1 month.
-- 2. Update 'pro_months_earned' to reflect lifetime earnings (soft cap check adjusted).
-- =====================================================

-- 1. Update redeem_code function
-- =====================================================
CREATE OR REPLACE FUNCTION redeem_code(code TEXT)
RETURNS JSON AS $$
DECLARE
    referrer_id UUID;
    referrer_current_hearts INT;
    referrer_referral_count INT;
    referrer_is_premium BOOLEAN;
    referrer_expires_at TIMESTAMPTZ;
    new_user_current_hearts INT;
BEGIN
    -- Find the referrer by code
    SELECT id, current_hearts, is_premium, pro_expires_at 
    INTO referrer_id, referrer_current_hearts, referrer_is_premium, referrer_expires_at
    FROM profiles
    WHERE referral_code = UPPER(code);

    -- Validation: Invalid code
    IF referrer_id IS NULL THEN
        RETURN json_build_object('success', false, 'message', 'Codice invito non valido');
    END IF;

    -- Validation: Cannot redeem own code
    IF referrer_id = auth.uid() THEN
        RETURN json_build_object('success', false, 'message', 'Non puoi riscattare il tuo codice invito');
    END IF;

    -- Check if user already redeemed a code
    IF EXISTS (SELECT 1 FROM referrals WHERE referred_user_id = auth.uid()) THEN
        RETURN json_build_object('success', false, 'message', 'Hai già riscattato un codice invito');
    END IF;

    -- Check referrer's referral count (max 12)
    SELECT COUNT(*) INTO referrer_referral_count
    FROM referrals
    WHERE referrer_id = referrer_id;

    IF referrer_referral_count >= 12 THEN
        RETURN json_build_object('success', false, 'message', 'Limite massimo di inviti raggiunto per questo utente');
    END IF;

    -- Get current user's hearts
    SELECT current_hearts INTO new_user_current_hearts
    FROM profiles
    WHERE id = auth.uid();

    -- Create referral record
    INSERT INTO referrals (referrer_id, referred_user_id, referral_code)
    VALUES (referrer_id, auth.uid(), UPPER(code));

    -- HANDLE REFERRER REWARD
    -- ======================
    -- Logic: 
    -- If PRO ACTIVE: Extend expiry date + increment earned counter (for stats)
    -- If PRO INACTIVE: Just increment earned counter (user activates manually)
    
    IF referrer_is_premium = TRUE AND referrer_expires_at > NOW() THEN
        -- Auto-extend active subscription
        UPDATE profiles
        SET 
            current_hearts = LEAST(5, current_hearts + 10),
            pro_months_earned = LEAST(12, pro_months_earned + 1), -- Keep tracking for UI stats
            pro_expires_at = pro_expires_at + INTERVAL '1 month'  -- Actual benefit
        WHERE id = referrer_id;
    ELSE
        -- Standard accumulation
        UPDATE profiles
        SET 
            current_hearts = LEAST(5, current_hearts + 10),
            pro_months_earned = LEAST(12, pro_months_earned + 1)
        WHERE id = referrer_id;
    END IF;

    -- Update new user: +10 hearts (cap at 5)
    UPDATE profiles
    SET current_hearts = LEAST(5, current_hearts + 10)
    WHERE id = auth.uid();

    RETURN json_build_object(
        'success', true, 
        'message', 'Codice riscattato! Hai ricevuto 10 cuori! Il tuo amico ha guadagnato 1 mese PRO.'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 2. Update compensation trigger for Feedback
-- =====================================================
CREATE OR REPLACE FUNCTION reward_pro_for_feedback()
RETURNS TRIGGER AS $$
DECLARE
    user_is_premium BOOLEAN;
    user_expires_at TIMESTAMPTZ;
BEGIN
    -- Check if this is the user's first feedback submission
    IF NOT EXISTS (
        SELECT 1 
        FROM profiles 
        WHERE id = NEW.user_id 
        AND has_submitted_feedback = TRUE
    ) THEN
        -- Get current Pro status
        SELECT is_premium, pro_expires_at 
        INTO user_is_premium, user_expires_at
        FROM profiles
        WHERE id = NEW.user_id;

        IF user_is_premium = TRUE AND user_expires_at > NOW() THEN
            -- Auto-extend active subscription
            UPDATE profiles
            SET 
                pro_months_earned = LEAST(12, COALESCE(pro_months_earned, 0) + 1),
                has_submitted_feedback = TRUE,
                pro_expires_at = pro_expires_at + INTERVAL '1 month'
            WHERE id = NEW.user_id
            AND COALESCE(pro_months_earned, 0) < 12;
            
        ELSE
             -- Standard accumulation
            UPDATE profiles
            SET 
                pro_months_earned = LEAST(12, COALESCE(pro_months_earned, 0) + 1),
                has_submitted_feedback = TRUE
            WHERE id = NEW.user_id
            AND COALESCE(pro_months_earned, 0) < 12;
        END IF;

        -- Mark this feedback as rewarded
        NEW.pro_reward_given := TRUE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
