'use client';

import { useEffect, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createBrowserClient } from '@supabase/ssr';
import { Database } from '@/types/supabase';

function AuthCallbackContent() {
    const router = useRouter();
    const searchParams = useSearchParams();
    const code = searchParams.get('code');
    const next = searchParams.get('next') || '/dashboard';

    useEffect(() => {
        const handleCallback = async () => {
            if (code) {
                const supabase = createBrowserClient<Database>(
                    process.env.NEXT_PUBLIC_SUPABASE_URL!,
                    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
                );

                const { error } = await supabase.auth.exchangeCodeForSession(code);

                if (!error) {
                    router.push(next);
                } else {
                    console.error('Auth error:', error);
                    router.push('/login?error=auth_code_error');
                }
            } else {
                router.push('/login');
            }
        };

        handleCallback();
    }, [code, next, router]);

    return (
        <div className="animate-pulse">Autenticazione in corso...</div>
    );
}

export default function AuthCallbackPage() {
    return (
        <div className="flex items-center justify-center min-h-screen bg-cyber-dark text-cyber-blue">
            <Suspense fallback={<div>Caricamento...</div>}>
                <AuthCallbackContent />
            </Suspense>
        </div>
    );
}
