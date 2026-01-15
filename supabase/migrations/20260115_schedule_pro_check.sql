-- =====================================================
-- AUTOMATIC PRO EXPIRATION CHECK
-- =====================================================
-- 1. Enable pg_cron for background checks
-- 2. Schedule daily check at midnight
-- 3. Update get_referral_stats to perform lazy check on access
-- =====================================================

-- Step 1: Enable pg_cron extension (if available)
-- Note: This might fail if the user doesn't have permissions or if it's not available in the plan.
-- We wrap it in a do block or just attempt it. Use CREATE EXTENSION IF NOT EXISTS.
CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA extensions;

-- Step 2: Schedule the daily check
-- Use a DO block to avoid errors if the job already exists
DO $$
BEGIN
    -- Check if the job already exists to avoid duplicates
    IF NOT EXISTS (SELECT 1 FROM cron.job WHERE jobname = 'daily_pro_check') THEN
        PERFORM cron.schedule(
            'daily_pro_check',   -- name of the job
            '0 0 * * *',         -- schedule: every day at midnight (UTC)
            $cmd$SELECT check_pro_expiration()$cmd$
        );
    END IF;
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not schedule cron job. Ensure pg_cron is enabled.';
END
$$;

-- Step 3: Update get_referral_stats to include "Lazy Check"
-- This ensures that even if the cron job fails or hasn't run yet,
-- the user sees the correct status immediately upon visiting the profile.

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
    -- LAZY CHECK: Immediately update status if expired
    -- This handles the edge case where the user visits right after expiration
    -- but before the cron job runs.
    UPDATE profiles
    SET is_premium = false
    WHERE id = auth.uid()
    AND is_premium = true
    AND pro_expires_at < NOW();

    -- Get user's referral stats (will reflect the update above)
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
