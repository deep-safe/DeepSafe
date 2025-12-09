DO $$
BEGIN
    -- Insert 10 New Avatars
    -- Rarity distribution: 1 Common, 3 Rare, 3 Epic, 3 Legendary

    INSERT INTO avatars (name, description, src, rarity, is_default) VALUES
    -- Common (1)
    ('Corsair', 'Space Pirate Captain', '/avatars/corsair.png', 'common', false),

    -- Rare (3)
    ('Cipher', 'Master Cryptographer', '/avatars/cipher.png', 'rare', false),
    ('Operator', 'Drone Swarm Controller', '/avatars/operator.png', 'rare', false),
    ('Technomancer', 'Hardware Specialist', '/avatars/technomancer.png', 'rare', false),

    -- Epic (3)
    ('Neon', 'Street Samurai', '/avatars/neon.png', 'epic', false),
    ('Sentinel', 'Heavy Riot Control', '/avatars/sentinel.png', 'epic', false),
    ('Vanguard', 'Orbital Shock Trooper', '/avatars/vanguard.png', 'epic', false),

    -- Legendary (3)
    ('Ghost', 'Invisible Operative', '/avatars/ghost.png', 'legendary', false),
    ('Oracle', 'AI Interface Entity', '/avatars/oracle.png', 'legendary', false),
    ('Spectre', 'Shadow Assassin', '/avatars/spectre.png', 'legendary', false);

    RAISE NOTICE 'Inserted 10 new avatars';
END $$;
