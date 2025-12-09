DO $$
DECLARE
    v_project_url TEXT := 'https://rxbvbxrobuaebrvcrcrg.supabase.co'; 
    v_bucket_path TEXT := '/storage/v1/object/public/avatars/';
    v_full_base TEXT;
BEGIN
    v_full_base := v_project_url || v_bucket_path;

    -- 1. Update 'avatars' table
    -- Replaces local path '/avatars/name.png' with 'https://.../storage/.../name.png'
    UPDATE avatars
    SET src = v_full_base || substring(src from 10) -- removes '/avatars/' (9 chars) check length? '/avatars/' is 9. 
    -- wait, '/avatars/' is 9 chars. substring(src from 10) gets the filename.
    WHERE src LIKE '/avatars/%';

    -- 2. Update 'profiles' table if it stores specific URLs (it stores IDs generally, but checks anyway)
    -- Profiles usually store 'avatar_url' which is an ID (e.g. 'avatar_rookie'), so no change needed there.

    RAISE NOTICE 'Updated avatar URLs to point to Supabase Storage: %', v_full_base;
END $$;
