-- Fix Delete Cascade for Profiles
-- This ensures that when a user is deleted from auth.users, their profile is also deleted automatically.

DO $$
BEGIN
    -- Check if the constraint exists and drop it if necessary to recreate with CASCADE
    IF EXISTS (
        SELECT 1 
        FROM information_schema.table_constraints 
        WHERE constraint_name = 'profiles_id_fkey' 
        AND table_name = 'profiles'
    ) THEN
        ALTER TABLE profiles DROP CONSTRAINT profiles_id_fkey;
    END IF;
    
    -- Re-add the constraint with ON DELETE CASCADE
    ALTER TABLE profiles
    ADD CONSTRAINT profiles_id_fkey
    FOREIGN KEY (id)
    REFERENCES auth.users(id)
    ON DELETE CASCADE;
    
END $$;
