-- Fix handle_new_user to use default avatar instead of Google profile picture
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, username, avatar_url, xp, current_hearts, highest_streak, is_premium, referral_code)
  VALUES (
    new.id,
    new.raw_user_meta_data->>'full_name',
    'avatar_rookie', -- Force default avatar ID
    0,
    5,
    0,
    false,
    upper(substring(md5(random()::text) from 1 for 6))
  );
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update existing users who have a URL as their avatar (Google/Auth provider URL)
-- We reset them to the default 'avatar_rookie'
UPDATE public.profiles
SET avatar_url = 'avatar_rookie'
WHERE avatar_url LIKE 'http%';
