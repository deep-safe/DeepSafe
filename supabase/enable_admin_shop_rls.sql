-- Enable RLS on shop tables if not already enabled
ALTER TABLE shop_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE mystery_box_loot ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Everyone can view shop items" ON shop_items;
DROP POLICY IF EXISTS "Admins can manage shop items" ON shop_items;
DROP POLICY IF EXISTS "Admins can manage loot" ON mystery_box_loot;
DROP POLICY IF EXISTS "Everyone can view loot" ON mystery_box_loot;

-- Policy: Everyone can view shop items
CREATE POLICY "Everyone can view shop items" ON shop_items
    FOR SELECT USING (true);

-- Policy: Admins can do everything on shop items
CREATE POLICY "Admins can manage shop items" ON shop_items
    FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.is_admin = true
        )
    );

-- Policy: Everyone can view loot (or maybe just admins? Let's say everyone for transparency if needed, but usually hidden)
-- Actually, client only needs to know loot if we show it. Admin needs to manage it.
CREATE POLICY "Admins can manage loot" ON mystery_box_loot
    FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE profiles.id = auth.uid()
            AND profiles.is_admin = true
        )
    );

CREATE POLICY "Everyone can view loot" ON mystery_box_loot
    FOR SELECT USING (true);
