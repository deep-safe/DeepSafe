-- Migration to fix security warnings from Supabase Linter (2026-01-29) - V7 (VERIFIED & CLEANED)

-- 1. Create permissions for extensions schema (Best Practice)
CREATE SCHEMA IF NOT EXISTS extensions;
GRANT USAGE ON SCHEMA extensions TO postgres;
GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;

-- NOTE: 'pg_net' extension cannot be moved via ALTER EXTENSION.
-- Skipped to avoid errors.

-- 2. Fix Function Search Path Mutable warnings
-- Setting search_path to 'public, extensions, pg_temp' for security definer functions

-- Generic/Known Functions
ALTER FUNCTION public.get_analytics_overview() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_admin_user_emails() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.handle_new_user() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.delete_account() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_leaderboard_ranks() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_user_rank() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_user_growth() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_referral_stats() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_admin_referral_stats() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.debug_profile_types() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_agent_stats() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.get_advanced_stats() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.activate_pro_subscription() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.check_pro_expiration() SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.reward_pro_for_feedback() SET search_path = public, extensions, pg_temp;

-- Functions with Arguments (Verified via Introspection)

-- admin_update_user (3 overloads found)
ALTER FUNCTION public.admin_update_user(uuid, integer, integer, text[], boolean, text[], jsonb) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.admin_update_user(uuid, integer, integer, integer, boolean, text[], text[], jsonb) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.admin_update_user(uuid, integer, integer, integer, boolean, jsonb, text[], jsonb) SET search_path = public, extensions, pg_temp;

-- admin_update_user_stats
ALTER FUNCTION public.admin_update_user_stats(uuid, integer, integer) SET search_path = public, extensions, pg_temp;

-- claim_gift
ALTER FUNCTION public.claim_gift(uuid) SET search_path = public, extensions, pg_temp;

-- claim_mission_reward
ALTER FUNCTION public.claim_mission_reward(uuid, text) SET search_path = public, extensions, pg_temp;

-- complete_level variants (All use TEXT for user_id)
ALTER FUNCTION public.complete_level(text, text, integer, text) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.complete_level_v2(text, text, integer, text) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.complete_level_v3(text, text, integer, text) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.complete_level_v4(text, text, integer, text) SET search_path = public, extensions, pg_temp;

-- update_rank_counters
ALTER FUNCTION public.update_rank_counters(uuid, integer, integer) SET search_path = public, extensions, pg_temp;

-- admin functions
ALTER FUNCTION public.admin_reset_user(uuid) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.admin_restore_data(jsonb) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.admin_update_profile_v2(uuid, integer, integer, text[], boolean, text[], jsonb) SET search_path = public, extensions, pg_temp;

-- Other Verified Signatures
ALTER FUNCTION public.send_gift_notification_email(UUID, TEXT, INTEGER, TEXT) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.send_gift(UUID, TEXT, INTEGER, TEXT, TEXT, TEXT) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.process_leaderboard_rewards(TEXT) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.redeem_code(TEXT) SET search_path = public, extensions, pg_temp;
ALTER FUNCTION public.purchase_item(UUID, TEXT) SET search_path = public, extensions, pg_temp;

-- Removed drop_constraint_referencing (not found in DB)
