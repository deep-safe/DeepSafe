import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient<Database>(supabaseUrl, supabaseKey, {
    auth: {
        persistSession: true,
        storageKey: 'deepsafe-auth-token',
        storage: typeof window !== 'undefined' ? window.localStorage : undefined,
        detectSessionInUrl: false,
        flowType: 'pkce',
    },
});
