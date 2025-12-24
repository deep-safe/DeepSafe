-- Migration to rebalance game economy (Region Costs and Mission Rewards)
-- User Request: "modify every single price of the app to be coherent and playable"

-- 1. Update Region Costs (Significantly reduced to lower barrier to entry)
-- Previous Max: 10,000 (Lazio) -> New Max: 5,000
UPDATE public.regions SET cost = CASE
    WHEN id = 'Molise' THEN 0 -- Starter Region (Free)
    WHEN id = 'Valle d''Aosta' THEN 500
    WHEN id IN ('Trentino-Alto Adige', 'Umbria', 'Basilicata') THEN 800
    WHEN id IN ('Abruzzo', 'Friuli Venezia Giulia', 'Liguria') THEN 1500
    WHEN id IN ('Campania', 'Sardegna', 'Calabria', 'Marche') THEN 2000
    WHEN id = 'Puglia' THEN 2500
    WHEN id = 'Veneto' THEN 3000
    WHEN id = 'Piemonte' THEN 3500
    WHEN id = 'Sicilia' THEN 3500
    WHEN id = 'Toscana' THEN 4000
    WHEN id = 'Lombardia' THEN 4500
    WHEN id = 'Lazio' THEN 5000 -- Capital City (Premium)
    ELSE cost -- Safety fallback
END;

-- 2. Update Mission Rewards (NC) based on Difficulty Level
-- Previous: ~50-100 (Easy), ~150 (Medium), ~200 (Hard)
-- New: 200 (Easy), 400 (Medium), 600 (Hard)
-- This injects significantly more currency into the economy.

UPDATE public.missions
SET nc_reward = 200
WHERE level IN ('semplice', 'facile', 'easy');

UPDATE public.missions
SET nc_reward = 400
WHERE level IN ('medio', 'medium');

UPDATE public.missions
SET nc_reward = 600
WHERE level IN ('difficile', 'hard');
