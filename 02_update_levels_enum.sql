-- Migration to update mission levels to: semplice, medio, difficile, speciale
-- Addresses error: type "public.mission_level" does not exist (Provider uses CHECK constraint, not Enum)

-- 1. Migrate existing data to matches new lowercase values
-- We prioritize safe mappings.
UPDATE public.missions SET level = 'semplice' WHERE level = 'SEMPLICE';
UPDATE public.missions SET level = 'difficile' WHERE level = 'DIFFICILE';
UPDATE public.missions SET level = 'semplice' WHERE level = 'TUTORIAL'; -- Map Tutorial to Semplice
UPDATE public.missions SET level = 'speciale' WHERE level = 'BOSS'; -- Map Boss to Speciale

-- 2. Drop the old constraint (likely named missions_level_check)
ALTER TABLE public.missions DROP CONSTRAINT IF EXISTS missions_level_check;

-- 3. Add the new constraint with the requested values
ALTER TABLE public.missions
ADD CONSTRAINT missions_level_check
CHECK (level IN ('semplice', 'medio', 'difficile', 'speciale'));
