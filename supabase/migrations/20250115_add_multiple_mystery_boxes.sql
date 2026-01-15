-- Migration: Add Multiple Mystery Box Rarities
-- Creates 3 mystery boxes (Basic, Rare, Legendary) with different costs and probabilities

-- 1. Hide the old mystery_box (keep for history, but make invisible)
UPDATE shop_items 
SET is_visible = false 
WHERE id = 'mystery_box';

-- 2. Add 3 new mystery boxes with different rarities
INSERT INTO shop_items (id, name, description, cost, icon, type, effect_type, is_limited, is_visible)
VALUES
('mystery_box_basic', 'Base', ' ', 300, '🎁', 'box', 'mystery_box', false, true),
('mystery_box_rare', 'Rara', ' ', 800, '💎', 'box', 'mystery_box', false, true),
('mystery_box_legendary', 'WOW', ' ', 2000, '⭐', 'box', 'mystery_box', false, true)
ON CONFLICT (id) DO NOTHING;

-- 3. Add loot tables for each box with different probability weights
-- The same rewards are available in all boxes, but with different probabilities

-- BASIC BOX: High probability for common rewards
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, reward_text, weight, description)
VALUES
-- Common rewards (high weight)
('mystery_box_basic', 'avatar', 0, 'avatar_rookie', 50, 'Avatar: Recluta (Common)'),
('mystery_box_basic', 'credits', 100, NULL, 60, '100 NeuroCredits'),
-- Uncommon rewards (medium weight)
('mystery_box_basic', 'avatar', 0, 'avatar_ninja', 15, 'Avatar: Cyber Ninja (Rare)'),
-- Rare rewards (low weight)
('mystery_box_basic', 'avatar', 0, 'avatar_hacker', 5, 'Avatar: Elite Hacker (Epic)'),
('mystery_box_basic', 'credits', 500, NULL, 5, '500 NeuroCredits'),
-- Legendary rewards (very low weight)
('mystery_box_basic', 'avatar', 0, 'avatar_architect', 1, 'Avatar: Architetto (Legendary)')
ON CONFLICT DO NOTHING;

-- RARE BOX: Balanced probabilities
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, reward_text, weight, description)
VALUES
-- Common rewards (reduced weight)
('mystery_box_rare', 'avatar', 0, 'avatar_rookie', 30, 'Avatar: Recluta (Common)'),
('mystery_box_rare', 'credits', 100, NULL, 30, '100 NeuroCredits'),
-- Uncommon rewards (higher weight)
('mystery_box_rare', 'avatar', 0, 'avatar_ninja', 40, 'Avatar: Cyber Ninja (Rare)'),
-- Rare rewards (medium weight)
('mystery_box_rare', 'avatar', 0, 'avatar_hacker', 20, 'Avatar: Elite Hacker (Epic)'),
('mystery_box_rare', 'credits', 500, NULL, 15, '500 NeuroCredits'),
-- Legendary rewards (low weight, but better than basic)
('mystery_box_rare', 'avatar', 0, 'avatar_architect', 5, 'Avatar: Architetto (Legendary)')
ON CONFLICT DO NOTHING;

-- LEGENDARY BOX: High probability for rare/epic rewards
INSERT INTO mystery_box_loot (box_id, reward_type, reward_value, reward_text, weight, description)
VALUES
-- Common rewards (very low weight)
('mystery_box_legendary', 'avatar', 0, 'avatar_rookie', 10, 'Avatar: Recluta (Common)'),
('mystery_box_legendary', 'credits', 100, NULL, 10, '100 NeuroCredits'),
-- Uncommon rewards (medium weight)
('mystery_box_legendary', 'avatar', 0, 'avatar_ninja', 30, 'Avatar: Cyber Ninja (Rare)'),
-- Rare rewards (high weight)
('mystery_box_legendary', 'avatar', 0, 'avatar_hacker', 40, 'Avatar: Elite Hacker (Epic)'),
('mystery_box_legendary', 'credits', 500, NULL, 30, '500 NeuroCredits'),
-- Legendary rewards (significantly higher weight)
('mystery_box_legendary', 'avatar', 0, 'avatar_architect', 20, 'Avatar: Architetto (Legendary)')
ON CONFLICT DO NOTHING;

-- Note: The purchase_item function already handles any box_id dynamically,
-- so no changes to the function are needed. It will work automatically with the new boxes.
