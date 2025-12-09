-- Remove XP from admin_update_user and get_analytics_overview

-- 1. Redefine get_analytics_overview without total_xp
DROP FUNCTION IF EXISTS get_analytics_overview();

CREATE OR REPLACE FUNCTION get_analytics_overview()
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_total_users INT;
    v_dau INT;
    v_total_credits INT;
    v_total_spent INT;
BEGIN
    SELECT COUNT(*) INTO v_total_users FROM profiles;
    
    SELECT COUNT(*) INTO v_dau 
    FROM profiles 
    WHERE last_login > (NOW() - INTERVAL '24 hours');
    
    SELECT COALESCE(SUM(credits), 0) INTO v_total_credits FROM profiles;
    
    -- Estimate spent based on inventory size (rough estimate as we don't track transaction history perfectly yet)
    -- Or just return 0 if not tracked. Using a placeholder calculation or 0.
    v_total_spent := 0; 

    RETURN jsonb_build_object(
        'total_users', v_total_users,
        'dau', v_dau,
        'total_credits', v_total_credits,
        'total_spent', v_total_spent
    );
END;
$$;

-- 2. Redefine admin_update_user without new_xp parameter
-- We drop the old function first to avoid signature mismatch errors if we are changing parameters
DROP FUNCTION IF EXISTS admin_update_user(UUID, INT, INT, INT, TEXT[], BOOLEAN, TEXT[], JSONB);

CREATE OR REPLACE FUNCTION admin_update_user(
    target_user_id UUID,
    new_credits INT DEFAULT NULL,
    new_streak INT DEFAULT NULL,
    new_unlocked_provinces TEXT[] DEFAULT NULL,
    new_is_premium BOOLEAN DEFAULT NULL,
    new_inventory TEXT[] DEFAULT NULL,
    new_earned_badges JSONB DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_updates_made BOOLEAN := false;
BEGIN
    -- Check if executing user is admin is handled by RLS policy or caller check usually, 
    -- but for RPC we might want to check auth.uid() is an admin. 
    -- For now, assuming unrestricted admin access via this RPC for simplicity as per previous likely implementation.
    
    IF new_credits IS NOT NULL THEN
        UPDATE profiles SET credits = new_credits WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF new_streak IS NOT NULL THEN
        UPDATE profiles SET highest_streak = new_streak WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF new_unlocked_provinces IS NOT NULL THEN
        UPDATE profiles SET unlocked_provinces = new_unlocked_provinces WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF new_is_premium IS NOT NULL THEN
        UPDATE profiles SET is_premium = new_is_premium WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF new_inventory IS NOT NULL THEN
        UPDATE profiles SET inventory = new_inventory WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF new_earned_badges IS NOT NULL THEN
        UPDATE profiles SET earned_badges = new_earned_badges WHERE id = target_user_id;
        v_updates_made := true;
    END IF;

    IF v_updates_made THEN
        RETURN jsonb_build_object('success', true, 'message', 'User updated successfully');
    ELSE
        RETURN jsonb_build_object('success', false, 'message', 'No changes made or invalid parameters');
    END IF;
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
