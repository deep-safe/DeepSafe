-- Add created_at to profiles if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'created_at') THEN
        ALTER TABLE public.profiles ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
    END IF;
END $$;

-- Analytics RPC Functions

-- 1. Overview Metrics
CREATE OR REPLACE FUNCTION get_analytics_overview()
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_total_users INT;
  v_dau INT;
  v_total_xp BIGINT;
  v_total_credits BIGINT;
  v_total_spent BIGINT;
BEGIN
  -- Total Users
  SELECT COUNT(*) INTO v_total_users FROM public.profiles;

  -- Daily Active Users (users who logged in today)
  -- last_login is stored as 'YYYY-MM-DD' string via getToday() utility.
  -- We compare it with the current date in the database's timezone (UTC usually).
  -- To be safe, we cast to date.
  SELECT COUNT(*) INTO v_dau 
  FROM public.profiles 
  WHERE last_login = to_char(NOW(), 'YYYY-MM-DD');

  -- Total XP
  SELECT SUM(xp) INTO v_total_xp FROM public.profiles;

  -- Total Credits (Circulating Supply)
  SELECT SUM(credits) INTO v_total_credits FROM public.profiles;

  -- Total Credits Spent (Estimated from Inventory Value)
  -- We sum the cost of all items currently in user inventories.
  -- This assumes items in inventory were purchased.
  SELECT COALESCE(SUM(si.cost), 0) INTO v_total_spent
  FROM public.profiles p,
       jsonb_array_elements_text(p.inventory) as item_id
  JOIN public.shop_items si ON si.id = item_id;

  RETURN json_build_object(
    'total_users', v_total_users,
    'dau', v_dau,
    'total_xp', COALESCE(v_total_xp, 0),
    'total_credits', COALESCE(v_total_credits, 0),
    'total_spent', COALESCE(v_total_spent, 0)
  );
END;
$$;

-- 2. User Growth (Last 30 Days)
-- Note: This requires a 'created_at' column in profiles or auth.users.
-- Since we can't easily access auth.users from here without extra permissions, 
-- we'll assume profiles has created_at or we'll use a fallback.
-- If profiles doesn't have created_at, we might need to add it or rely on something else.
-- Let's check if profiles has created_at. If not, we'll add it to the query assuming it exists or will be added.
-- Actually, let's check if we can use a recursive query to generate dates and join.

CREATE OR REPLACE FUNCTION get_user_growth()
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_result JSON;
BEGIN
  -- We'll just group by date for now. If created_at is missing, this will fail or return empty.
  -- Assuming profiles has created_at (it usually does in Supabase templates).
  -- If not, we might need to rely on another table or add it.
  -- Let's try to use auth.users if possible, but RLS might block it.
  -- Safer to use profiles.created_at if it exists.
  
  -- If profiles doesn't have created_at, we can't do this accurately without it.
  -- Let's assume for now profiles has it or we will add it.
  
  SELECT json_agg(t) INTO v_result
  FROM (
    SELECT 
      to_char(created_at, 'YYYY-MM-DD') as date,
      COUNT(*) as count
    FROM public.profiles
    WHERE created_at > NOW() - INTERVAL '30 days'
    GROUP BY 1
    ORDER BY 1
  ) t;

  RETURN COALESCE(v_result, '[]'::json);
END;
$$;

-- 3. Mission Stats
CREATE OR REPLACE FUNCTION get_mission_stats()
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_result JSON;
BEGIN
  SELECT json_agg(t) INTO v_result
  FROM (
    SELECT 
      m.title,
      COUNT(up.id) as completions,
      ROUND(AVG(up.score)) as avg_score
    FROM public.missions m
    LEFT JOIN public.user_progress up ON m.id::text = up.quiz_id::text
    WHERE up.status = 'completed'
    GROUP BY m.id, m.title
    ORDER BY completions DESC
    LIMIT 10
  ) t;

  RETURN COALESCE(v_result, '[]'::json);
END;
$$;
