-- Create shop_items table
DROP TABLE IF EXISTS public.shop_items CASCADE;
CREATE TABLE public.shop_items (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    icon TEXT NOT NULL, -- Emoji or Lucide icon name
    cost INTEGER NOT NULL DEFAULT 0,
    type TEXT NOT NULL DEFAULT 'consumable', -- 'consumable', 'permanent', 'cosmetic'
    rarity TEXT NOT NULL DEFAULT 'common', -- 'common', 'rare', 'epic', 'legendary'
    stock INTEGER, -- NULL for infinite
    is_limited BOOLEAN DEFAULT false,
    effect_type TEXT NOT NULL DEFAULT 'none', -- 'streak_freeze', 'restore_lives', 'double_xp', 'mystery_box', 'none'
    effect_value INTEGER, -- e.g., duration in minutes, or amount
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.shop_items ENABLE ROW LEVEL SECURITY;

-- Policies
-- Everyone can read shop items
CREATE POLICY "Everyone can read shop items" ON public.shop_items
    FOR SELECT
    USING (true);

-- Only admins can insert/update/delete shop items
CREATE POLICY "Admins can manage shop items" ON public.shop_items
    FOR ALL
    USING (public.is_admin());

-- Seed Data from ShopPage.tsx
INSERT INTO public.shop_items (id, name, description, icon, cost, type, rarity, stock, is_limited, effect_type, effect_value)
VALUES
    ('streak_freeze', 'Streak Freeze', 'Proteggi la tua serie per 24 ore. Si attiva automaticamente se perdi un giorno.', '⏰', 200, 'consumable', 'common', NULL, false, 'streak_freeze', 1),
    ('system_reboot', 'System Reboot', 'Ripristina immediatamente tutte le tue vite al massimo.', '⚡', 350, 'consumable', 'rare', NULL, false, 'restore_lives', 5),
    ('double_xp', 'Double XP (1h)', 'Raddoppia i punti esperienza guadagnati per la prossima ora.', '🛡️', 500, 'consumable', 'epic', 3, true, 'double_xp', 60),
    ('mystery_box', 'Cassa Crittografata', 'Tenta la fortuna! Contiene premi casuali.', '🎁', 50, 'consumable', 'common', NULL, false, 'mystery_box', NULL)
ON CONFLICT (id) DO NOTHING;
