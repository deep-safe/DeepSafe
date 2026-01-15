-- =====================================================
-- INVITE CODE REFERRAL SYSTEM WITH PRO SUBSCRIPTION
-- =====================================================
-- This migration creates the infrastructure for:
-- 1. Tracking referrals (who invited whom)
-- 2. Earning Pro months through successful invites
-- 3. Manual Pro subscription activation
-- =====================================================

-- Step 1: Create referrals tracking table
-- =====================================================
CREATE TABLE IF NOT EXISTS referrals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    referrer_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    referred_user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    referral_code TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Ensure unique referral relationship
    UNIQUE(referrer_id, referred_user_id),
    
    -- Prevent self-referral at database level
    CHECK (referrer_id != referred_user_id)
);

-- Add indexes for performance
CREATE INDEX idx_referrals_referrer ON referrals(referrer_id);
CREATE INDEX idx_referrals_referred ON referrals(referred_user_id);
CREATE INDEX idx_referrals_created_at ON referrals(created_at DESC);

-- Enable RLS
ALTER TABLE referrals ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Users can view their own referrals (as referrer)
CREATE POLICY "Users can view referrals they made"
    ON referrals FOR SELECT
    USING (auth.uid() = referrer_id);

-- RLS Policy: Users can view referrals where they were referred
CREATE POLICY "Users can view referrals where they are referred"
    ON referrals FOR SELECT
    USING (auth.uid() = referred_user_id);

-- Step 2: Add Pro subscription fields to profiles
-- =====================================================
ALTER TABLE profiles 
    ADD COLUMN IF NOT EXISTS pro_months_earned INTEGER DEFAULT 0 CHECK (pro_months_earned >= 0 AND pro_months_earned <= 12),
    ADD COLUMN IF NOT EXISTS pro_expires_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS pro_activated_at TIMESTAMPTZ;

-- Add index for Pro expiration checks
CREATE INDEX IF NOT EXISTS idx_profiles_pro_expires ON profiles(pro_expires_at) WHERE pro_expires_at IS NOT NULL;

-- Step 3: Update existing redeem_code function
-- =====================================================
CREATE OR REPLACE FUNCTION redeem_code(code TEXT)
RETURNS JSON AS $$
DECLARE
    referrer_id UUID;
    referrer_current_hearts INT;
    referrer_referral_count INT;
    new_user_current_hearts INT;
BEGIN
    -- Find the referrer by code
    SELECT id, current_hearts INTO referrer_id, referrer_current_hearts
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

    -- Update referrer: +10 hearts (cap at 5), +1 pro month
    UPDATE profiles
    SET 
        current_hearts = LEAST(5, current_hearts + 10),
        pro_months_earned = LEAST(12, pro_months_earned + 1)
    WHERE id = referrer_id;

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

-- Step 4: Create function to get referral statistics
-- =====================================================
CREATE OR REPLACE FUNCTION get_referral_stats()
RETURNS JSON AS $$
DECLARE
    referral_count INT;
    months_earned INT;
    is_pro_active BOOLEAN;
    pro_expiry TIMESTAMPTZ;
    pro_activation TIMESTAMPTZ;
    referral_list JSON;
BEGIN
    -- Get user's referral stats
    SELECT 
        pro_months_earned,
        is_premium,
        pro_expires_at,
        pro_activated_at
    INTO 
        months_earned,
        is_pro_active,
        pro_expiry,
        pro_activation
    FROM profiles
    WHERE id = auth.uid();

    -- Count successful referrals
    SELECT COUNT(*) INTO referral_count
    FROM referrals
    WHERE referrer_id = auth.uid();

    -- Get list of referrals with details
    SELECT json_agg(json_build_object(
        'referred_user_id', r.referred_user_id,
        'username', p.username,
        'created_at', r.created_at
    ) ORDER BY r.created_at DESC)
    INTO referral_list
    FROM referrals r
    LEFT JOIN profiles p ON r.referred_user_id = p.id
    WHERE r.referrer_id = auth.uid();

    RETURN json_build_object(
        'referral_count', COALESCE(referral_count, 0),
        'pro_months_earned', COALESCE(months_earned, 0),
        'is_pro_active', COALESCE(is_pro_active, false),
        'pro_expires_at', pro_expiry,
        'pro_activated_at', pro_activation,
        'referrals', COALESCE(referral_list, '[]'::json)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Step 5: Create function to activate Pro subscription
-- =====================================================
CREATE OR REPLACE FUNCTION activate_pro_subscription()
RETURNS JSON AS $$
DECLARE
    months_earned INT;
    current_is_premium BOOLEAN;
    current_expires_at TIMESTAMPTZ;
    new_expires_at TIMESTAMPTZ;
BEGIN
    -- Get user's current Pro status
    SELECT 
        pro_months_earned,
        is_premium,
        pro_expires_at
    INTO 
        months_earned,
        current_is_premium,
        current_expires_at
    FROM profiles
    WHERE id = auth.uid();

    -- Validation: No months earned
    IF months_earned IS NULL OR months_earned = 0 THEN
        RETURN json_build_object(
            'success', false, 
            'message', 'Non hai mesi PRO da attivare. Invita amici per guadagnare mesi PRO!'
        );
    END IF;

    -- Validation: Already active and not expired
    IF current_is_premium = true AND current_expires_at > NOW() THEN
        RETURN json_build_object(
            'success', false, 
            'message', 'Hai già un abbonamento PRO attivo fino al ' || to_char(current_expires_at, 'DD/MM/YYYY')
        );
    END IF;

    -- Calculate new expiration date
    new_expires_at := NOW() + (months_earned || ' months')::INTERVAL;

    -- Activate Pro subscription
    UPDATE profiles
    SET 
        is_premium = true,
        pro_activated_at = NOW(),
        pro_expires_at = new_expires_at
    WHERE id = auth.uid();

    RETURN json_build_object(
        'success', true,
        'message', 'PRO attivato con successo!',
        'expires_at', new_expires_at,
        'months_activated', months_earned
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Step 6: Create function to check and update expired Pro subscriptions
-- =====================================================
-- This function should be called on user login or periodically
CREATE OR REPLACE FUNCTION check_pro_expiration()
RETURNS VOID AS $$
BEGIN
    -- Deactivate expired Pro subscriptions
    UPDATE profiles
    SET is_premium = false
    WHERE is_premium = true 
    AND pro_expires_at IS NOT NULL 
    AND pro_expires_at < NOW();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Step 7: Add comment documentation
-- =====================================================
COMMENT ON TABLE referrals IS 'Tracks successful referral invitations between users';
COMMENT ON COLUMN profiles.pro_months_earned IS 'Number of Pro months earned through referrals (max 12)';
COMMENT ON COLUMN profiles.pro_expires_at IS 'Timestamp when Pro subscription expires';
COMMENT ON COLUMN profiles.pro_activated_at IS 'Timestamp when user manually activated their Pro subscription';
COMMENT ON FUNCTION redeem_code IS 'Redeems a referral code, awards hearts and Pro months';
COMMENT ON FUNCTION get_referral_stats IS 'Returns user referral statistics and Pro status';
COMMENT ON FUNCTION activate_pro_subscription IS 'Manually activates Pro subscription using earned months';
COMMENT ON FUNCTION check_pro_expiration IS 'Deactivates expired Pro subscriptions';
