-- Migration to add update_rank_counters RPC for Emerald/Ruby awarding
-- This function is called by the frontend after province/region completion is detected

CREATE OR REPLACE FUNCTION public.update_rank_counters(
    p_user_id UUID,
    p_add_emeralds INTEGER DEFAULT 0,
    p_add_rubies INTEGER DEFAULT 0
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    UPDATE profiles
    SET 
        emeralds = COALESCE(emeralds, 0) + COALESCE(p_add_emeralds, 0),
        rubies = COALESCE(rubies, 0) + COALESCE(p_add_rubies, 0)
    WHERE id = p_user_id;
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.update_rank_counters(UUID, INTEGER, INTEGER) TO authenticated;
