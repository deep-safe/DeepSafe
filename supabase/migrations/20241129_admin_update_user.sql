CREATE OR REPLACE FUNCTION admin_update_user(
    target_user_id UUID,
    new_xp INTEGER DEFAULT NULL,
    new_credits INTEGER DEFAULT NULL,
    new_streak INTEGER DEFAULT NULL,
    new_is_premium BOOLEAN DEFAULT NULL,
    new_unlocked_provinces JSONB DEFAULT NULL, -- Changed from TEXT[] to JSONB
    new_inventory TEXT[] DEFAULT NULL,
    new_earned_badges JSONB DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_admin_id UUID;
    v_is_admin BOOLEAN;
BEGIN
    -- Get current user ID
    v_admin_id := auth.uid();

    -- Check if executor is admin
    SELECT is_admin INTO v_is_admin
    FROM profiles
    WHERE id = v_admin_id;

    IF v_is_admin IS NOT TRUE THEN
        RETURN jsonb_build_object('success', false, 'message', 'Unauthorized: Admin access required');
    END IF;

    -- Update target user
    UPDATE profiles
    SET
        xp = COALESCE(new_xp, xp),
        credits = COALESCE(new_credits, credits),
        highest_streak = COALESCE(new_streak, highest_streak),
        is_premium = COALESCE(new_is_premium, is_premium),
        unlocked_provinces = COALESCE(new_unlocked_provinces, unlocked_provinces),
        inventory = COALESCE(new_inventory, inventory),
        earned_badges = COALESCE(new_earned_badges, earned_badges),
        updated_at = NOW()
    WHERE id = target_user_id;

    RETURN jsonb_build_object('success', true);
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
