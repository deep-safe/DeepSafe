-- Function to safely increment credits
CREATE OR REPLACE FUNCTION increment_credits(p_user_id UUID, p_amount INT)
RETURNS VOID AS $$
BEGIN
  UPDATE profiles
  SET credits = credits + p_amount
  WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Refresh schema cache
NOTIFY pgrst, 'reload schema';
