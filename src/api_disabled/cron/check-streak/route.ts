import { NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';
import { sendNotification } from '@/lib/pushService';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!; // Use Service Role Key in real prod for full access
const supabase = createClient<Database>(supabaseUrl, supabaseKey);

export async function GET(req: Request) {
    // Verify Cron Secret (optional but recommended)
    // const authHeader = req.headers.get('authorization');
    // if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    //     return new Response('Unauthorized', { status: 401 });
    // }

    try {
        // 1. Get users who haven't logged in today but have a streak > 0
        const today = new Date().toISOString().split('T')[0];

        // Note: This query is simplified. In a real app, you'd need a more complex query 
        // or a dedicated 'last_streak_update' column to avoid spamming.
        // For MVP, we'll just fetch all subscriptions and filter in memory (not scalable but works for demo)

        const { data: subscriptions, error } = await supabase
            .from('push_subscriptions')
            .select('user_id, subscription, profiles(highest_streak, last_login)');

        if (error) throw error;

        let sentCount = 0;

        for (const sub of subscriptions) {
            const profile = sub.profiles as any; // Type assertion due to join
            if (!profile) continue;

            const lastLogin = profile.last_login;
            const streak = profile.highest_streak;

            if (streak > 0 && lastLogin !== today) {
                // User hasn't logged in today!
                const success = await sendNotification(sub.subscription, {
                    title: '⚠️ Rischio Streak!',
                    body: `Non hai ancora completato la tua missione oggi! La tua serie di ${streak} giorni è a rischio.`,
                    url: '/dashboard'
                });
                if (success) sentCount++;
            }
        }

        return NextResponse.json({ success: true, sent: sentCount });
    } catch (error) {
        console.error('Cron error:', error);
        return NextResponse.json({ error: 'Internal Server Error' }, { status: 500 });
    }
}
