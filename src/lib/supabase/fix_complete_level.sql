-- Create a robust complete_level function that accepts earned_xp
-- and ensures all necessary columns exist

-- 1. Ensure total_missions column exists
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS total_missions INTEGER DEFAULT 0;

-- 2. Ensure unlocked_missions_count column exists
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS unlocked_missions_count INTEGER DEFAULT 0;

-- 3. Redefine the function with the correct signature
CREATE OR REPLACE FUNCTION public.complete_level(
    p_user_id UUID,
    p_level_id TEXT,
    p_score INTEGER,
    p_earned_xp INTEGER
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_current_xp INTEGER;
    v_current_missions INTEGER;
    v_current_credits INTEGER;
    v_new_xp INTEGER;
    v_new_credits INTEGER;
BEGIN
    -- Get current stats
    SELECT 
        COALESCE(xp, 0), 
        COALESCE(total_missions, 0),
        COALESCE(credits, 0)
    INTO 
        v_current_xp, 
        v_current_missions,
        v_current_credits
    FROM public.profiles
    WHERE id = p_user_id;

    -- Calculate new values
    v_new_xp := v_current_xp + p_earned_xp;
    v_new_credits := v_current_credits + p_earned_xp; -- Dual ledger: XP = NC (Credits)

    -- Update profile
    UPDATE public.profiles
    SET 
        xp = v_new_xp,
        credits = v_new_credits,
        total_missions = v_current_missions + 1,
        updated_at = NOW()
    WHERE id = p_user_id;

    -- Return success
    RETURN jsonb_build_object(
        'success', true,
        'new_xp', v_new_xp,
        'new_credits', v_new_credits,
        'earned_xp', p_earned_xp
    );

EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object(
        'success', false,
        'error', SQLERRM,
        'detail', SQLSTATE
    );
END;
$$;
