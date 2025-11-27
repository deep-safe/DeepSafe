-- Add settings columns to profiles table
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS settings_notifications BOOLEAN DEFAULT TRUE,
ADD COLUMN IF NOT EXISTS settings_sound BOOLEAN DEFAULT TRUE,
ADD COLUMN IF NOT EXISTS settings_haptics BOOLEAN DEFAULT TRUE;

-- Refresh schema cache
NOTIFY pgrst, 'reload schema';
