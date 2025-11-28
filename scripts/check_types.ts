import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabase = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

async function checkTypes() {
    const { data, error } = await supabase.rpc('debug_profile_types' as any);
    if (error) {
        console.error('Error:', error);
    } else {
        console.log('Column Types:', data);
    }
}

checkTypes();
