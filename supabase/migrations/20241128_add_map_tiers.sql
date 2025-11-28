-- Add map_tier and completed_tiers to profiles
ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS map_tier text DEFAULT 'level_1',
ADD COLUMN IF NOT EXISTS completed_tiers jsonb DEFAULT '[]'::jsonb;

-- Add tier to missions
ALTER TABLE public.missions
ADD COLUMN IF NOT EXISTS tier text DEFAULT 'level_1';

-- Add check constraint for map_tier
ALTER TABLE public.profiles
ADD CONSTRAINT check_map_tier CHECK (map_tier IN ('level_1', 'level_2', 'level_3'));

-- Add check constraint for mission tier
ALTER TABLE public.missions
ADD CONSTRAINT check_mission_tier CHECK (tier IN ('level_1', 'level_2', 'level_3'));
