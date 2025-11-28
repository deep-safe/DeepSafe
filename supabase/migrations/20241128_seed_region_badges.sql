-- Seed Region Master Badges for all 20 Italian Regions
-- Fixed: Added 'category' column and translated to Italian

INSERT INTO badges (id, name, description, icon, condition_type, condition_value, xp_reward, category)
VALUES
    ('badge_region_abruzzo', 'Conquistatore dell''Abruzzo', 'Assegnato per aver completato tutte le missioni in Abruzzo.', '🏔️', 'region_master', 'Abruzzo', 500, 'exploration'),
    ('badge_region_basilicata', 'Conquistatore della Basilicata', 'Assegnato per aver completato tutte le missioni in Basilicata.', '🏛️', 'region_master', 'Basilicata', 500, 'exploration'),
    ('badge_region_calabria', 'Conquistatore della Calabria', 'Assegnato per aver completato tutte le missioni in Calabria.', '🌶️', 'region_master', 'Calabria', 500, 'exploration'),
    ('badge_region_campania', 'Conquistatore della Campania', 'Assegnato per aver completato tutte le missioni in Campania.', '🍕', 'region_master', 'Campania', 500, 'exploration'),
    ('badge_region_emilia_romagna', 'Conquistatore dell''Emilia-Romagna', 'Assegnato per aver completato tutte le missioni in Emilia-Romagna.', '🏎️', 'region_master', 'Emilia-Romagna', 500, 'exploration'),
    ('badge_region_friuli_venezia_giulia', 'Conquistatore del Friuli-Venezia Giulia', 'Assegnato per aver completato tutte le missioni in Friuli-Venezia Giulia.', '🦅', 'region_master', 'Friuli-Venezia Giulia', 500, 'exploration'),
    ('badge_region_lazio', 'Conquistatore del Lazio', 'Assegnato per aver completato tutte le missioni nel Lazio.', '🏛️', 'region_master', 'Lazio', 500, 'exploration'),
    ('badge_region_liguria', 'Conquistatore della Liguria', 'Assegnato per aver completato tutte le missioni in Liguria.', '⛵', 'region_master', 'Liguria', 500, 'exploration'),
    ('badge_region_lombardia', 'Conquistatore della Lombardia', 'Assegnato per aver completato tutte le missioni in Lombardia.', '🏭', 'region_master', 'Lombardia', 500, 'exploration'),
    ('badge_region_marche', 'Conquistatore delle Marche', 'Assegnato per aver completato tutte le missioni nelle Marche.', '🎨', 'region_master', 'Marche', 500, 'exploration'),
    ('badge_region_molise', 'Conquistatore del Molise', 'Assegnato per aver completato tutte le missioni in Molise.', '🏞️', 'region_master', 'Molise', 500, 'exploration'),
    ('badge_region_piemonte', 'Conquistatore del Piemonte', 'Assegnato per aver completato tutte le missioni in Piemonte.', '🏔️', 'region_master', 'Piemonte', 500, 'exploration'),
    ('badge_region_puglia', 'Conquistatore della Puglia', 'Assegnato per aver completato tutte le missioni in Puglia.', '🫒', 'region_master', 'Puglia', 500, 'exploration'),
    ('badge_region_sardegna', 'Conquistatore della Sardegna', 'Assegnato per aver completato tutte le missioni in Sardegna.', '🐑', 'region_master', 'Sardegna', 500, 'exploration'),
    ('badge_region_sicilia', 'Conquistatore della Sicilia', 'Assegnato per aver completato tutte le missioni in Sicilia.', '🍋', 'region_master', 'Sicilia', 500, 'exploration'),
    ('badge_region_toscana', 'Conquistatore della Toscana', 'Assegnato per aver completato tutte le missioni in Toscana.', '🍷', 'region_master', 'Toscana', 500, 'exploration'),
    ('badge_region_trentino_alto_adige', 'Conquistatore del Trentino-Alto Adige', 'Assegnato per aver completato tutte le missioni in Trentino-Alto Adige.', '⛷️', 'region_master', 'Trentino-Alto Adige', 500, 'exploration'),
    ('badge_region_umbria', 'Conquistatore dell''Umbria', 'Assegnato per aver completato tutte le missioni in Umbria.', '🌳', 'region_master', 'Umbria', 500, 'exploration'),
    ('badge_region_valle_daosta', 'Conquistatore della Valle d''Aosta', 'Assegnato per aver completato tutte le missioni in Valle d''Aosta.', '🏰', 'region_master', 'Valle d''Aosta', 500, 'exploration'),
    ('badge_region_veneto', 'Conquistatore del Veneto', 'Assegnato per aver completato tutte le missioni in Veneto.', '🎭', 'region_master', 'Veneto', 500, 'exploration')
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    category = EXCLUDED.category;
