import { createClient } from '@supabase/supabase-js';

// Note: This client should only be used in server-side contexts (API routes, Server Actions)
// never on the client side, as it uses the Service Role Key.
export const supabaseAdmin = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!,
    {
        auth: {
            autoRefreshToken: false,
            persistSession: false
        }
    }
);
