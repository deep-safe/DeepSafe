
import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const envPath = path.resolve(process.cwd(), '.env.local');
const envConfig = fs.readFileSync(envPath, 'utf8');
const envVars: Record<string, string> = {};

envConfig.split('\n').forEach(line => {
    const [key, value] = line.split('=');
    if (key && value) {
        envVars[key.trim()] = value.trim();
    }
});

const supabaseUrl = envVars['NEXT_PUBLIC_SUPABASE_URL'];
const supabaseKey = envVars['NEXT_PUBLIC_SUPABASE_ANON_KEY'];

if (!supabaseUrl || !supabaseKey) {
    console.error('Missing Supabase URL or Key');
    process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function inspectScores() {
    // Get the first user (or specific one if we knew the ID, but we'll list all for now or just the first one)
    const { data: profiles, error } = await supabase
        .from('profiles')
        .select('id, username, province_scores')
        .limit(1);

    if (error) {
        console.error('Error fetching profiles:', error);
        return;
    }

    if (profiles && profiles.length > 0) {
        const profile = profiles[0];
        console.log(`User: ${profile.username} (${profile.id})`);
        console.log('Province Scores:', JSON.stringify(profile.province_scores, null, 2));
    } else {
        console.log('No profiles found.');
    }
}

inspectScores();
