-- Fix for Ambiguous RPC calls
-- We create a v2 function with a distinct name to avoid overload resolution errors.

CREATE OR REPLACE FUNCTION admin_update_profile_v2(
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
        RETURN jsonb_build_object('success', true, 'message', 'User updated successfully (v2)');
    ELSE
        RETURN jsonb_build_object('success', false, 'message', 'No changes made or invalid parameters');
    END IF;

EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
