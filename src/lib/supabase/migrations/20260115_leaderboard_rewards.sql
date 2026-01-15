-- 20260115_leaderboard_rewards.sql

-- 1. Create Notifications Table (if not exists)
CREATE TABLE IF NOT EXISTS user_notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL, -- 'weekly_reward', 'monthly_reward', etc.
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    data JSONB DEFAULT '{}'::jsonb, -- Store reward amount, rank, etc.
    read BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster queries
CREATE INDEX IF NOT EXISTS idx_user_notifications_user_id ON user_notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_user_notifications_read ON user_notifications(read);

-- 2. Function to Process Rewards
-- Period: 'weekly' or 'monthly'
CREATE OR REPLACE FUNCTION process_leaderboard_rewards(p_period TEXT)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_top_user_id UUID;
    v_reward_amount INTEGER;
    v_title TEXT;
    v_message TEXT;
BEGIN
    -- Determine Reward Amount based on period
    IF p_period = 'weekly' THEN
        v_reward_amount := 1000;
        v_title := '🏆 Campione Settimanale!';
        v_message := 'Complimenti Agente! Sei primo in classifica questa settimana. Ecco la tua ricompensa.';
    ELSIF p_period = 'monthly' THEN
        v_reward_amount := 5000;
        v_title := '👑 Leggenda del Mese!';
        v_message := 'Incredibile! Hai dominato la classifica questo mese. Ecco un premio speciale per te.';
    ELSE
        RAISE EXCEPTION 'Invalid period: %', p_period;
    END IF;

    -- Find the Top User
    -- Criteria: Rubies > Emeralds > Credits
    SELECT id
    INTO v_top_user_id
    FROM profiles
    ORDER BY 
        COALESCE(rubies, 0) DESC, 
        COALESCE(emeralds, 0) DESC, 
        credits DESC
    LIMIT 1;

    -- If we found a user, distribute reward
    IF v_top_user_id IS NOT NULL THEN
        -- 1. Update Credits
        UPDATE profiles
        SET credits = credits + v_reward_amount
        WHERE id = v_top_user_id;

        -- 2. Create Notification
        INSERT INTO user_notifications (user_id, type, title, message, data)
        VALUES (
            v_top_user_id, 
            p_period || '_reward', 
            v_title, 
            v_message, 
            jsonb_build_object(
                'amount', v_reward_amount,
                'period', p_period,
                'awarded_at', NOW()
            )
        );
        
        -- Log (optional, raises notice in Postgres logs)
        RAISE NOTICE 'Awarded % to user % for % leaderboard', v_reward_amount, v_top_user_id, p_period;
    END IF;
END;
$$;

-- 3. Schedule Cron Jobs
-- We use a DO block to safely attempt scheduling, as pg_cron might not be available in all envs
DO $$
BEGIN
    -- Check if pg_cron extension is available (though we can't enable it dynamically inside a transaction easily usually)
    -- Assuming extension is enabled or we try to schedule anyway.
    
    -- Weekly Reward: Every Monday at 00:00 UTC
    -- Cron syntax: min hour day month weekday
    -- 0 0 * * 1 = At 00:00 on Monday
    PERFORM cron.schedule(
        'leaderboard_weekly_reward',
        '0 0 * * 1', 
        'SELECT process_leaderboard_rewards(''weekly'')'
    );

    -- Monthly Reward: 1st of every month at 00:00 UTC
    -- 0 0 1 * * = At 00:00 on day-of-month 1
    PERFORM cron.schedule(
        'leaderboard_monthly_reward',
        '0 0 1 * *',
        'SELECT process_leaderboard_rewards(''monthly'')'
    );

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Could not schedule cron jobs. Ensure pg_cron is enabled. Error: %', SQLERRM;
END $$;
