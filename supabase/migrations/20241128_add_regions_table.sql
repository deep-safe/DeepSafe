-- Create regions table
CREATE TABLE IF NOT EXISTS public.regions (
    id TEXT PRIMARY KEY,
    cost INTEGER NOT NULL DEFAULT 1000,
    tier TEXT DEFAULT 'level_1',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.regions ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Enable read access for all users" ON public.regions
    FOR SELECT USING (true);

CREATE POLICY "Enable write access for admins only" ON public.regions
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.profiles
            WHERE profiles.id = auth.uid() AND profiles.is_admin = true
        )
    );

-- Seed initial regions (from provincesData.ts)
INSERT INTO public.regions (id, cost, tier) VALUES
    ('Piemonte', 4000, 'level_1'), -- 8 provinces
    ('Lombardia', 6000, 'level_1'), -- 12 provinces
    ('Veneto', 3500, 'level_1'), -- 7 provinces
    ('Emilia-Romagna', 4500, 'level_1'), -- 9 provinces
    ('Toscana', 5000, 'level_1'), -- 10 provinces
    ('Lazio', 10000, 'level_1'), -- 5 provinces (Special: Rome)
    ('Campania', 2500, 'level_1'), -- 5 provinces
    ('Sicilia', 4500, 'level_1'), -- 9 provinces
    ('Sardegna', 2500, 'level_1'), -- 5 provinces
    ('Puglia', 3000, 'level_1'), -- 6 provinces
    ('Calabria', 2500, 'level_1'), -- 5 provinces
    ('Liguria', 2000, 'level_1'), -- 4 provinces
    ('Marche', 2500, 'level_1'), -- 5 provinces
    ('Abruzzo', 2000, 'level_1'), -- 4 provinces
    ('Friuli Venezia Giulia', 2000, 'level_1'), -- 4 provinces
    ('Trentino-Alto Adige', 1000, 'level_1'), -- 2 provinces
    ('Umbria', 1000, 'level_1'), -- 2 provinces
    ('Basilicata', 1000, 'level_1'), -- 2 provinces
    ('Molise', 1000, 'level_1'), -- 2 provinces
    ('Valle d''Aosta', 500, 'level_1') -- 1 province
ON CONFLICT (id) DO UPDATE SET cost = EXCLUDED.cost;
