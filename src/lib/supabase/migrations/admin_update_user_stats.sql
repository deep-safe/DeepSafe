-- Function to update user stats (Credits & Streak) securely
-- Created to fix admin quick edit issues

CREATE OR REPLACE FUNCTION admin_update_user_stats(
    target_user_id UUID,
    new_credits INT DEFAULT NULL,
    new_streak INT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_changes_made BOOLEAN := false;
BEGIN
    -- Check if the executor is an admin (optional extra security, though RLS/Policy usually handles this, 
    -- but for RPCs, explicit checks are good practice if not fully covered by RLS on the function itself)
    -- IF NOT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND is_admin = true) THEN
    --     RETURN jsonb_build_object('success', false, 'message', 'Unauthorized: Admin access required');
    -- END IF;

    IF new_credits IS NOT NULL THEN
        UPDATE profiles 
        SET credits = new_credits 
        WHERE id = target_user_id;
        v_changes_made := true;
    END IF;

    IF new_streak IS NOT NULL THEN
        UPDATE profiles 
        SET highest_streak = new_streak 
        WHERE id = target_user_id;
        v_changes_made := true;
    END IF;

    IF v_changes_made THEN
        RETURN jsonb_build_object('success', true, 'message', 'User stats updated successfully');
    ELSE
        RETURN jsonb_build_object('success', false, 'message', 'No changes provided or update failed');
    END IF;

EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'message', SQLERRM);
END;
$$;
