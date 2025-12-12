-- Fix Blocking Constraints - FINAL VERSION
-- Handles: user_badges, user_missions, challenges, friendships, friends, push_subscriptions
-- Uses a helper function to identify and drop constraints dynamically.

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
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN

    -- 1. Fix user_badges
    -- user_id -> profiles.id
    PERFORM drop_constraint_referencing('user_badges', 'profiles', 'user_id');
    ALTER TABLE user_badges ADD CONSTRAINT user_badges_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

    -- 2. Fix user_missions
    -- user_id -> profiles.id
    PERFORM drop_constraint_referencing('user_missions', 'profiles', 'user_id');
    ALTER TABLE user_missions ADD CONSTRAINT user_missions_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;

    -- 3. Fix challenges
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'challenges') THEN
        -- challenger_id
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'challenger_id');
        ALTER TABLE challenges ADD CONSTRAINT challenges_challenger_id_fkey FOREIGN KEY (challenger_id) REFERENCES profiles(id) ON DELETE CASCADE;
        
        -- opponent_id
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'opponent_id');
        ALTER TABLE challenges ADD CONSTRAINT challenges_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES profiles(id) ON DELETE CASCADE;

        -- winner_id
        PERFORM drop_constraint_referencing('challenges', 'profiles', 'winner_id');
        ALTER TABLE challenges ADD CONSTRAINT challenges_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- 4. Fix friendships / friends
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'friendships') THEN
        PERFORM drop_constraint_referencing('friendships', 'profiles', 'user_id');
        PERFORM drop_constraint_referencing('friendships', 'profiles', 'friend_id');
        ALTER TABLE friendships ADD CONSTRAINT friendships_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
        ALTER TABLE friendships ADD CONSTRAINT friendships_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'friends') THEN
        PERFORM drop_constraint_referencing('friends', 'profiles', 'user_id');
        PERFORM drop_constraint_referencing('friends', 'profiles', 'friend_id');
        ALTER TABLE friends ADD CONSTRAINT friends_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
        ALTER TABLE friends ADD CONSTRAINT friends_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

    -- 5. Fix push_subscriptions
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'push_subscriptions') THEN
        PERFORM drop_constraint_referencing('push_subscriptions', 'profiles', 'user_id');
        ALTER TABLE push_subscriptions ADD CONSTRAINT push_subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
    END IF;

END $$;
