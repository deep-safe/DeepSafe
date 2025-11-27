import { headers } from 'next/headers';
import { NextResponse } from 'next/server';
import Stripe from 'stripe';
import { createClient } from '@supabase/supabase-js';
import { Database } from '@/types/supabase';

// Initialize Stripe safely
const stripe = process.env.STRIPE_SECRET_KEY
    ? new Stripe(process.env.STRIPE_SECRET_KEY, {
        // apiVersion: '2025-01-27.acacia',
    })
    : null;

const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

export async function POST(req: Request) {
    if (!stripe || !webhookSecret || !supabaseUrl || !supabaseServiceKey) {
        console.error('Missing environment variables for Stripe Webhook');
        return NextResponse.json({ error: 'Server configuration error' }, { status: 500 });
    }

    // Initialize Supabase Admin Client (Bypasses RLS)
    const supabaseAdmin = createClient<Database>(supabaseUrl, supabaseServiceKey);

    const body = await req.text();
    const headersList = await headers();
    const signature = headersList.get('stripe-signature')!;

    let event: Stripe.Event;

    try {
        event = stripe.webhooks.constructEvent(body, signature, webhookSecret);
    } catch (err: any) {
        console.error(`Webhook signature verification failed: ${err.message}`);
        return NextResponse.json({ error: `Webhook Error: ${err.message}` }, { status: 400 });
    }

    if (event.type === 'checkout.session.completed') {
        const session = event.data.object as Stripe.Checkout.Session;
        const userId = session.metadata?.userId;
        const actionType = session.metadata?.actionType;

        if (!userId || !actionType) {
            console.error('Missing metadata in Stripe session');
            return NextResponse.json({ error: 'Missing metadata' }, { status: 400 });
        }

        console.log(`Processing ${actionType} for user ${userId}`);

        try {
            switch (actionType) {
                case 'ACTIVATE_PREMIUM':
                    await supabaseAdmin
                        .from('profiles')
                        .update({ is_premium: true })
                        .eq('id', userId);
                    break;

                case 'REFILL_HEARTS':
                    await supabaseAdmin
                        .from('profiles')
                        .update({ current_hearts: 5 })
                        .eq('id', userId);
                    break;

                case 'STREAK_FREEZE':
                    // Ensure the column exists via migration first!
                    await supabaseAdmin
                        .from('profiles')
                        .update({ streak_freezes: (await getCurrentStreakFreezes(supabaseAdmin, userId)) + 1 })
                        .eq('id', userId);
                    break;

                case 'BUY_CREDITS':
                    const amount = parseInt(session.metadata?.amount || '0');
                    if (amount > 0) {
                        await supabaseAdmin.rpc('increment_credits', { p_user_id: userId, p_amount: amount });
                        // Fallback if RPC doesn't exist (though RPC is safer for concurrency)
                        // const current = await getCurrentCredits(supabaseAdmin, userId);
                        // await supabaseAdmin.from('profiles').update({ credits: current + amount }).eq('id', userId);
                    }
                    break;

                default:
                    console.warn(`Unknown action type: ${actionType}`);
            }
        } catch (dbError) {
            console.error('Supabase update failed:', dbError);
            return NextResponse.json({ error: 'Database update failed' }, { status: 500 });
        }
    }

    return NextResponse.json({ received: true });
}

async function getCurrentStreakFreezes(supabase: any, userId: string): Promise<number> {
    const { data } = await supabase.from('profiles').select('streak_freezes').eq('id', userId).single();
    return data?.streak_freezes || 0;
}
