'use client';

import React from 'react';
import { usePathname, useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase/client';
import { BottomNav } from "@/components/layout/BottomNav";
import { Header } from "@/components/layout/Header";
import { CyberToast } from "@/components/ui/CyberToast";
import { SystemModal } from "@/components/ui/SystemModal";
import { GiftOverlay } from '@/components/gamification/GiftOverlay';
import { BiometricGuard } from '@/components/auth/BiometricGuard';
import { CookieConsent } from '@/components/ui/CookieConsent';
import { useHeartRefill } from '@/hooks/useHeartRefill';
import { useUserStore } from '@/store/useUserStore';

export const LayoutWrapper = ({ children }: { children: React.ReactNode }) => {
    const pathname = usePathname();
    const isAdmin = pathname?.startsWith('/admin');

    // Global Heart Refill Logic
    useHeartRefill();

    // Sync Last Login Date
    const { setLastLoginDate } = useUserStore();
    const router = useRouter();

    const isLandingPage = pathname === '/' || pathname === '/a' || pathname === '/s' || pathname === '/privacy-policy' || pathname === '/terms' || pathname === '/cookie-policy';

    React.useEffect(() => {
        if (isLandingPage) return;

        const updateLogin = async () => {
            try {
                // Check if we have a session first to avoid "Refresh Token Not Found" error on public pages
                const { data: { session } } = await supabase.auth.getSession();
                if (session) {
                    await setLastLoginDate(new Date().toISOString());
                }
            } catch (error) {
                console.error('Failed to update last login:', error);
            }
        };

        updateLogin();
    }, [isLandingPage, setLastLoginDate]);

    React.useEffect(() => {
        // Handle Auth State Changes (including Token Refresh Errors)
        const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
            if (event === 'SIGNED_OUT') {
                // Clear any local state if needed
                if (!isLandingPage) {
                    router.push('/login');
                }
            } else if (event === 'TOKEN_REFRESHED') {

            }
        });

        if ('serviceWorker' in navigator) {
            const basePath = process.env.NEXT_PUBLIC_BASE_PATH || '';
            navigator.serviceWorker.register(`${basePath}/custom-sw.js`).then(
                (registration) => { },
                (error) => console.error('Service Worker registration failed:', error)
            );
        }

        return () => {
            subscription.unsubscribe();
        };
    }, [isLandingPage, router]);

    if (isLandingPage) {
        return (
            <main className="min-h-screen">
                {children}
                <CookieConsent />
            </main>
        );
    }

    return (
        <BiometricGuard>
            <div className={`min-h-screen flex flex-col relative overflow-hidden ${isAdmin ? 'w-full' : 'w-full md:max-w-md mx-auto pt-24 pb-24'}`}>
                {!isAdmin && <Header />}
                <main className={`flex-1 z-10 ${isAdmin ? 'p-0' : 'p-4'}`}>
                    {children}
                </main>
                {!isAdmin && <BottomNav />}
                <CyberToast />
                <SystemModal />
                <GiftOverlay />
                <CookieConsent />
            </div>
        </BiometricGuard>
    );
};
