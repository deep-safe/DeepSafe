-- Fix User Deletion - Final Comprehensive Script
-- This script ensures that ALL tables referencing profiles (or auth.users) do so with ON DELETE CASCADE.
-- This prevents "foreign key violation" errors when deleting a user.

-- 1. Helper function to drop constraints safely by reference
CREATE OR REPLACE FUNCTION drop_constraint_referencing(p_table text, p_ref_table text, p_column text) 
RETURNS void AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN 
        SELECT distinct tc.constraint_name
        FROM information_schema.table_constraints AS tc 
        JOIN information_schema.key_column_usage AS kcu
          ON tc.constraint_name = kcu.constraint_name
          AND tc.table_schema = kcu.table_schema
        JOIN information_schema.constraint_column_usage AS ccu
          ON ccu.constraint_name = tc.constraint_name
          AND ccu.table_schema = tc.table_schema
        WHERE tc.constraint_type = 'FOREIGN KEY' 
          AND tc.table_name = p_table
          AND kcu.column_name = p_column
          AND ccu.table_name = p_ref_table
    LOOP
        EXECUTE 'ALTER TABLE ' || quote_ident(p_table) || ' DROP CONSTRAINT ' || quote_ident(r.constraint_name);
        RAISE NOTICE 'Dropped constraint % on table %', r.constraint_name, p_table;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
    -- =================================================================
    -- 1. PROFILES -> AUTH.USERS
    -- =================================================================
    -- Ensure profiles deletes when auth.users deletes
    PERFORM drop_constraint_referencing('profiles', 'users', 'id'); -- Check against auth.users usually via 'users' in some contexts or explicit schema
    
    -- Direct constraint check for profiles referencing auth.users
    -- Note: auth schema is sometimes tricky to query in information_schema depending on permissions, 
    -- but usually 'users' view is visible or we just try to drop known names.
    -- We'll try to explicitly drop the standard name if it exists.
    IF EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE table_name = 'profiles' AND constraint_name = 'profiles_id_fkey'
    ) THEN
        ALTER TABLE profiles DROP CONSTRAINT profiles_id_fkey;
    END IF;

    -- Re-add profiles -> auth.users
    ALTER TABLE profiles 
    ADD CONSTRAINT profiles_id_fkey 
    FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;

    -- =================================================================
    -- 2. TABLES REFERENCING PROFILES
    -- =================================================================
    
    -- A) user_progress
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_progress') THEN
        PERFORM drop_constraint_referencing('user_progress', 'profiles', 'user_id');
        ALTER TABLE user_progress ADD CONSTRAINT user_progress_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- B) user_badges
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_badges') THEN
        PERFORM drop_constraint_referencing('user_badges', 'profiles', 'user_id');
        ALTER TABLE user_badges ADD CONSTRAINT user_badges_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- C) user_missions
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'user_missions') THEN
        PERFORM drop_constraint_referencing('user_missions', 'profiles', 'user_id');
        ALTER TABLE user_missions ADD CONSTRAINT user_missions_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- D) push_subscriptions
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'push_subscriptions') THEN
        PERFORM drop_constraint_referencing('push_subscriptions', 'profiles', 'user_id');
        ALTER TABLE push_subscriptions ADD CONSTRAINT push_subscriptions_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- E) friendships
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'friendships') THEN
        PERFORM drop_constraint_referencing('friendships', 'profiles', 'user_id');
        PERFORM drop_constraint_referencing('friendships', 'profiles', 'friend_id');
        
        ALTER TABLE friendships ADD CONSTRAINT friendships_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
        
        ALTER TABLE friendships ADD CONSTRAINT friendships_friend_id_fkey 
        FOREIGN KEY (friend_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- F) challenges
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'challenges') THEN
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'challenger_id');
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'opponent_id');
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'winner_id');

        ALTER TABLE challenges ADD CONSTRAINT challenges_challenger_id_fkey 
        FOREIGN KEY (challenger_id) REFERENCES profiles(id) ON DELETE CASCADE;
        
        ALTER TABLE challenges ADD CONSTRAINT challenges_opponent_id_fkey 
        FOREIGN KEY (opponent_id) REFERENCES profiles(id) ON DELETE CASCADE;
        
        ALTER TABLE challenges ADD CONSTRAINT challenges_winner_id_fkey 
        FOREIGN KEY (winner_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- G) friends (legacy/alias check)
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'friends') THEN
        PERFORM drop_constraint_referencing('friends', 'profiles', 'user_id');
        PERFORM drop_constraint_referencing('friends', 'profiles', 'friend_id');
        
        ALTER TABLE friends ADD CONSTRAINT friends_user_id_fkey 
        FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
        
        ALTER TABLE friends ADD CONSTRAINT friends_friend_id_fkey 
        FOREIGN KEY (friend_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    RAISE NOTICE 'Refreshed all cascade constraints successfully.';
    
END $$;
