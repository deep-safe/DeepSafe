DO $$
BEGIN
    -- 1. Delete old specific region badges
    -- This removes them from the 'badges' definition table.
    -- Note: This does NOT automatically clean up 'profiles.earned_badges' JSONB array unless you run a sophisticated update script.
    -- Since the frontend filters earned badges against BADGES_DATA, they will effectively disappear from UI anyway.
    DELETE FROM badges WHERE condition_type = 'region_master';

    -- 2. Insert the new single Generic Region Badge
    INSERT INTO badges (id, name, description, icon, category, xp_reward, rarity, condition_type, condition_value)
    VALUES (
        'master_region_generic',
        'Conquistatore Regionale',
        'Completa tutte le province di una regione.',
        '🗺️',
        'Region',
        500,
        'legendary',
        'region_master',
        NULL -- No value needed, generic check
    );

    RAISE NOTICE 'Refactored Region Badges: Deleted old specifics, inserted generic master.';
END $$;
