-- Quick Fix: Update existing mystery box names
-- Esegui questa query DOPO la migration principale se i nomi sono ancora vecchi

-- Update names for the 3 new mystery boxes
UPDATE shop_items SET name = 'Base' WHERE id = 'mystery_box_basic';

UPDATE shop_items SET name = 'Rara' WHERE id = 'mystery_box_rare';

UPDATE shop_items SET name = 'WOW' WHERE id = 'mystery_box_legendary';

-- Hide the old mystery box
UPDATE shop_items SET is_visible = false WHERE id = 'mystery_box';

-- Verify changes
SELECT id, name, description, cost, is_visible 
FROM shop_items 
WHERE effect_type = 'mystery_box' 
ORDER BY cost;
