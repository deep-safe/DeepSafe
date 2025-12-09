-- Drop functions first to allow return type changes
DROP FUNCTION IF EXISTS get_leaderboard_ranks();

-- Create function to get user rank based on new metrics
CREATE OR REPLACE FUNCTION get_user_rank()
RETURNS INTEGER AS $$
DECLARE
    v_user_id UUID;
    v_rank INTEGER;
    v_my_rubies INTEGER;
    v_my_emeralds INTEGER;
    v_my_credits INTEGER;
BEGIN
    v_user_id := auth.uid();
    
    -- Get current user stats
    SELECT 
        COALESCE(rubies, 0), 
        COALESCE(emeralds, 0), 
        COALESCE(credits, 0)
    INTO v_my_rubies, v_my_emeralds, v_my_credits
    FROM profiles 
    WHERE id = v_user_id;

    -- Count users with strictly better stats
    -- Sort Order: Rubies DESC, Emeralds DESC, Credits DESC
    SELECT COUNT(*) + 1
    INTO v_rank
    FROM profiles p
    WHERE 
        (COALESCE(p.rubies, 0), COALESCE(p.emeralds, 0), COALESCE(p.credits, 0)) > 
        (v_my_rubies, v_my_emeralds, v_my_credits);
        
    RETURN v_rank;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update get_leaderboard_ranks to also include credits in sorting
CREATE OR REPLACE FUNCTION get_leaderboard_ranks()
RETURNS TABLE (
    id UUID,
    username TEXT,
    avatar_url TEXT,
    rubies INTEGER,
    emeralds INTEGER,
    credits INTEGER,
    rank BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.username,
        p.avatar_url,
        COALESCE(p.rubies, 0) as rubies,
        COALESCE(p.emeralds, 0) as emeralds,
        COALESCE(p.credits, 0) as credits,
        RANK() OVER (ORDER BY COALESCE(p.rubies, 0) DESC, COALESCE(p.emeralds, 0) DESC, COALESCE(p.credits, 0) DESC) as rank
    FROM profiles p
    ORDER BY rubies DESC, emeralds DESC, credits DESC
    LIMIT 100;
END;
$$ LANGUAGE plpgsql;
