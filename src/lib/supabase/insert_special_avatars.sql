DO $$
BEGIN
    -- Insert 3 Special Avatars for Early Participants/Legacy
    -- Using 'legendary' rarity to ensure premium color (Yellow/Gold) in UI.

    INSERT INTO avatars (id, name, description, src, rarity, is_default) VALUES
    -- Early Participant
    ('avatar_pioneer', 'The Pioneer', 'EARLY ACCESS EXCLUSIVE. Awarded to the first wave of agents.', '/avatars/pioneer.png', 'legendary', false),

    -- Founder/Leader
    ('avatar_founder', 'The Founder', 'Legacy Edition. For those who established the network.', '/avatars/founder.png', 'legendary', false),

    -- Unique Anomaly
    ('avatar_glitch_zero', 'Glitch Zero', 'SYSTEM ERROR. Anomaly detected in the avatar database.', '/avatars/glitch_zero.png', 'legendary', false);

    RAISE NOTICE 'Inserted 3 SPECIAL avatars';
END $$;
