DO $$
BEGIN
    -- Insert 10 New Avatars
    -- Rarity distribution: 1 Common, 3 Rare, 3 Epic, 3 Legendary

    INSERT INTO avatars (id, name, description, src, rarity, is_default) VALUES
    -- Common (1)
    ('avatar_corsair', 'Corsair', 'Space Pirate Captain', '/avatars/corsair.png', 'common', false),

    -- Rare (3)
    ('avatar_cipher', 'Cipher', 'Master Cryptographer', '/avatars/cipher.png', 'rare', false),
    ('avatar_operator', 'Operator', 'Drone Swarm Controller', '/avatars/operator.png', 'rare', false),
    ('avatar_technomancer', 'Technomancer', 'Hardware Specialist', '/avatars/technomancer.png', 'rare', false),

    -- Epic (3)
    ('avatar_neon', 'Neon', 'Street Samurai', '/avatars/neon.png', 'epic', false),
    ('avatar_sentinel', 'Sentinel', 'Heavy Riot Control', '/avatars/sentinel.png', 'epic', false),
    ('avatar_vanguard', 'Vanguard', 'Orbital Shock Trooper', '/avatars/vanguard.png', 'epic', false),

    -- Legendary (3)
    ('avatar_ghost', 'Ghost', 'Invisible Operative', '/avatars/ghost.png', 'legendary', false),
    ('avatar_oracle', 'Oracle', 'AI Interface Entity', '/avatars/oracle.png', 'legendary', false),
    ('avatar_spectre', 'Spectre', 'Shadow Assassin', '/avatars/spectre.png', 'legendary', false);

    RAISE NOTICE 'Inserted 10 new avatars';
END $$;
