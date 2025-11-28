CREATE OR REPLACE FUNCTION debug_profile_types()
RETURNS TABLE(col_name text, col_type text)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY
    SELECT column_name::text, data_type::text
    FROM information_schema.columns
    WHERE table_name = 'profiles' AND column_name IN ('inventory', 'unlocked_provinces', 'earned_badges');
END;
$$;
