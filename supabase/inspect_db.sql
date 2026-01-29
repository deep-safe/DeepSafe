-- Script to inspect existing functions and their signatures
-- Run this in Supabase SQL Editor to see what functions actually exist.

SELECT 
    n.nspname as schema_name,
    p.proname as function_name,
    pg_get_function_arguments(p.oid) as arguments,
    CASE 
        WHEN p.prosecdef THEN 'SECURITY DEFINER' 
        ELSE 'INVOKER' 
    END as security_type,
    config.setting as search_path
FROM pg_proc p
JOIN pg_namespace n ON p.pronamespace = n.oid
LEFT JOIN LATERAL unnest(p.proconfig) AS config(setting) ON config.setting LIKE 'search_path=%'
WHERE n.nspname = 'public'
AND (
    p.proname LIKE 'complete_level%'
    OR p.proname = 'update_rank_counters'
    OR p.proname LIKE 'admin_%'
    OR p.proname = 'claim_gift'
    OR p.proname = 'claim_mission_reward'
    OR p.proname = 'open_mystery_box'
    OR p.proname = 'recalc_badges_counters'
    OR p.proname = 'get_mission_stats'
)
ORDER BY p.proname;
