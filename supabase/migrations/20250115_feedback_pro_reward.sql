-- =====================================================
-- FEEDBACK PRO MONTH REWARD
-- =====================================================
-- Add automatic Pro month reward when user submits feedback
-- Integrates with existing invite code Pro system
-- =====================================================

-- Step 1: Add column to track if Pro reward has been given for feedback
-- =====================================================
ALTER TABLE feedback 
    ADD COLUMN IF NOT EXISTS pro_reward_given BOOLEAN DEFAULT FALSE;

-- Add index for quick lookups
CREATE INDEX IF NOT EXISTS idx_feedback_pro_reward ON feedback(user_id, pro_reward_given);

-- Step 2: Add column to profiles to track feedback submissions
-- =====================================================
ALTER TABLE profiles 
    ADD COLUMN IF NOT EXISTS has_submitted_feedback BOOLEAN DEFAULT FALSE;

-- Step 3: Create function to reward Pro month for first feedback
-- =====================================================
CREATE OR REPLACE FUNCTION reward_pro_for_feedback()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if this is the user's first feedback submission
    IF NOT EXISTS (
        SELECT 1 
        FROM profiles 
        WHERE id = NEW.user_id 
        AND has_submitted_feedback = TRUE
    ) THEN
        -- Check if user hasn't already maxed out Pro months (12 max)
        UPDATE profiles
        SET 
            pro_months_earned = LEAST(12, COALESCE(pro_months_earned, 0) + 1),
            has_submitted_feedback = TRUE
        WHERE id = NEW.user_id
        AND COALESCE(pro_months_earned, 0) < 12;

        -- Mark this feedback as rewarded
        NEW.pro_reward_given := TRUE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Step 4: Create trigger on feedback table
-- =====================================================
DROP TRIGGER IF EXISTS trigger_reward_pro_for_feedback ON feedback;

CREATE TRIGGER trigger_reward_pro_for_feedback
    BEFORE INSERT ON feedback
    FOR EACH ROW
    EXECUTE FUNCTION reward_pro_for_feedback();

-- Step 5: Add comment documentation
-- =====================================================
COMMENT ON COLUMN feedback.pro_reward_given IS 'Indicates if this feedback submission awarded a Pro month';
COMMENT ON COLUMN profiles.has_submitted_feedback IS 'Tracks if user has submitted at least one feedback (for Pro reward)';
COMMENT ON FUNCTION reward_pro_for_feedback IS 'Automatically awards 1 Pro month for first feedback submission (max 12 months total)';

-- Step 6: Backfill existing users who already submitted feedback
-- =====================================================
-- Mark users who already have feedback as having submitted
UPDATE profiles
SET has_submitted_feedback = TRUE
WHERE id IN (
    SELECT DISTINCT user_id 
    FROM feedback
);

-- Note: We don't retroactively award Pro months for old feedback
-- Only new feedback submissions from this point forward will be rewarded
