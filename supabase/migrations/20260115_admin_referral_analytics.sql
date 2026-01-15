-- =====================================================
-- ADMIN REFERRAL ANALYTICS
-- =====================================================
-- Creates a function to fetch aggregated referral statistics
-- for the admin dashboard.
-- =====================================================

CREATE OR REPLACE FUNCTION get_admin_referral_stats()
RETURNS JSON AS $$
DECLARE
    total_refs INT;
    total_months INT;
    top_refs JSON;
    daily_growth JSON;
    conversion_rate NUMERIC;
BEGIN
    -- 1. Total Referrals Count
    SELECT COUNT(*) INTO total_refs FROM referrals;

    -- 2. Total PRO Months Distributed
    SELECT COALESCE(SUM(pro_months_earned), 0) INTO total_months FROM profiles;

    -- 3. Top Referrers (Leaderboard)
    SELECT json_agg(t) INTO top_refs
    FROM (
        SELECT 
            p.username,
            COUNT(r.id) as count,
            p.pro_months_earned
        FROM profiles p
        JOIN referrals r ON r.referrer_id = p.id
        GROUP BY p.id, p.username, p.pro_months_earned
        ORDER BY count DESC
        LIMIT 10
    ) t;

    -- 4. Daily Growth (Last 30 Days)
    SELECT json_agg(d) INTO daily_growth
    FROM (
        SELECT 
            to_char(date_trunc('day', series), 'YYYY-MM-DD') as date,
            COUNT(r.created_at) as count
        FROM generate_series(
            NOW() - INTERVAL '30 days',
            NOW(),
            INTERVAL '1 day'
        ) as series
        LEFT JOIN referrals r ON date_trunc('day', r.created_at) = date_trunc('day', series)
        GROUP BY 1
        ORDER BY 1
    ) d;

    return json_build_object(
        'total_referrals', COALESCE(total_refs, 0),
        'total_pro_months_distributed', COALESCE(total_months, 0),
        'top_referrers', COALESCE(top_refs, '[]'::json),
        'daily_growth', COALESCE(daily_growth, '[]'::json)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
