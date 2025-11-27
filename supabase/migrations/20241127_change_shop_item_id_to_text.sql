-- Fix schema mismatch (box_item_id vs box_id) and change ID types to text

BEGIN;

-- 1. Rename column box_item_id to box_id if it exists (to match codebase)
DO $$
BEGIN
  IF EXISTS(SELECT * FROM information_schema.columns WHERE table_name='mystery_box_loot' AND column_name='box_item_id') THEN
      ALTER TABLE mystery_box_loot RENAME COLUMN box_item_id TO box_id;
  END IF;
END $$;

-- 2. Drop potential foreign key constraints (handle both naming conventions)
ALTER TABLE mystery_box_loot DROP CONSTRAINT IF EXISTS mystery_box_loot_box_id_fkey;
ALTER TABLE mystery_box_loot DROP CONSTRAINT IF EXISTS mystery_box_loot_box_item_id_fkey;

-- 3. Change column types to text to support custom IDs
ALTER TABLE shop_items ALTER COLUMN id TYPE text;
ALTER TABLE mystery_box_loot ALTER COLUMN box_id TYPE text;

-- 4. Re-add foreign key constraint
ALTER TABLE mystery_box_loot 
    ADD CONSTRAINT mystery_box_loot_box_id_fkey 
    FOREIGN KEY (box_id) 
    REFERENCES shop_items(id) 
    ON DELETE CASCADE;

COMMIT;
