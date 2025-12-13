import { createClient } from '@supabase/supabase-js';

// Note: This client should only be used in server-side contexts (API routes, Server Actions)
// never on the client side, as it uses the Service Role Key.
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

// Note: This client should only be used in server-side contexts (API routes, Server Actions)
// never on the client side, as it uses the Service Role Key.
export const supabaseAdmin = (supabaseUrl && supabaseServiceRoleKey)
    ? createClient(
        supabaseUrl,
        supabaseServiceRoleKey,
        {
            auth: {
                autoRefreshToken: false,
                persistSession: false
            }
        }
    )
    : (() => {
        // Return a proxy or dummy object that throws a helpful error when accessed vs just crashing at module load
        console.warn('Supabase Admin client not initialized: Missing env vars');
        return {} as ReturnType<typeof createClient>;
    })();
