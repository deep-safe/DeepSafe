-- Update Mystery Box Price to 500 NC
-- Execute this in Supabase SQL Editor to update the existing record

UPDATE shop_items 
SET cost = 500 
WHERE id = 'mystery_box';
