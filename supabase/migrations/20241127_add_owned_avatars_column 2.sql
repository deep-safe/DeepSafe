-- Add owned_avatars column to profiles table
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS owned_avatars text[] DEFAULT '{avatar_rookie}';

-- Update existing rows to have the default avatar if they don't have any
UPDATE profiles 
SET owned_avatars = '{avatar_rookie}' 
WHERE owned_avatars IS NULL;
