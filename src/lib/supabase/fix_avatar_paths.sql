-- FIX SCRIPT: Avatar Paths to Storage
-- Replace 'YOUR_PROJECT_ID' below.

DO $$
DECLARE
    -- INPUT YOUR PROJECT URL BASE HERE
    v_project_url TEXT := 'https://rxbvbxrobuaebrvcrcrg.supabase.co'; 
    v_bucket_path TEXT := '/storage/v1/object/public/avatars/';
    v_full_base TEXT;
    v_updated_count INT;
BEGIN
    v_full_base := v_project_url || v_bucket_path;

    -- 1. Fix paths starting with '/avatars/' (e.g. '/avatars/rookie.png')
    UPDATE avatars
    SET src = v_full_base || substring(src from 10)
    WHERE src LIKE '/avatars/%';
    
    GET DIAGNOSTICS v_updated_count = ROW_COUNT;
    RAISE NOTICE 'Fixed /avatars/ paths: %', v_updated_count;

    -- 2. Fix paths starting with 'avatars/' (no leading slash)
    UPDATE avatars
    SET src = v_full_base || substring(src from 9)
    WHERE src LIKE 'avatars/%';

    GET DIAGNOSTICS v_updated_count = ROW_COUNT;
    RAISE NOTICE 'Fixed avatars/ paths: %', v_updated_count;

    -- 3. Fix paths that are just filenames (e.g. 'rookie.png')
    -- Logic: Ends in .png and has NO slashes
    UPDATE avatars
    SET src = v_full_base || src
    WHERE src LIKE '%.png' AND src NOT LIKE '%/%';

    GET DIAGNOSTICS v_updated_count = ROW_COUNT;
    RAISE NOTICE 'Fixed filename-only paths: %', v_updated_count;

    -- 4. Verify Final URLs (Show first 5)
    RAISE NOTICE 'Sample of current URLs:';
    FOR v_full_base IN SELECT src FROM avatars LIMIT 5 LOOP
        RAISE NOTICE '%', v_full_base;
    END LOOP;

END $$;
