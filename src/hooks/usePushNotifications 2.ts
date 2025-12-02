import { useState, useEffect } from 'react';
import { createBrowserClient } from '@supabase/ssr';
import { Database } from '@/types/supabase';

const supabase = createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// Helper to convert VAPID key
function urlBase64ToUint8Array(base64String: string) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
        .replace(/\-/g, '+')
        .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
        outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
}

export function usePushNotifications() {
    const [isSupported, setIsSupported] = useState(false);
    const [subscription, setSubscription] = useState<PushSubscription | null>(null);
    const [permission, setPermission] = useState<NotificationPermission>('default');
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        if ('serviceWorker' in navigator && 'PushManager' in window) {
            setIsSupported(true);
            setPermission(Notification.permission);
            checkSubscription();
        } else {
            setLoading(false);
        }
    }, []);

    const checkSubscription = async () => {
        try {
            const registration = await navigator.serviceWorker.ready;
            const sub = await registration.pushManager.getSubscription();
            setSubscription(sub);
        } catch (error) {
            console.error('Error checking subscription:', error);
        } finally {
            setLoading(false);
        }
    };

    const subscribe = async () => {
        try {
            setLoading(true);
            const registration = await navigator.serviceWorker.ready;

            // Request permission first
            const perm = await Notification.requestPermission();
            setPermission(perm);

            if (perm !== 'granted') {
                throw new Error('Permission not granted');
            }

            const vapidKey = process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY;
            if (!vapidKey) {
                throw new Error('VAPID Public Key not found');
            }

            const sub = await registration.pushManager.subscribe({
                userVisibleOnly: true,
                applicationServerKey: urlBase64ToUint8Array(vapidKey)
            });

            setSubscription(sub);

            // Sync with Backend
            const { data: { user } } = await supabase.auth.getUser();
            if (user) {
                await fetch('/api/push/subscribe', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        subscription: sub,
                        userId: user.id
                    })
                });
            }

            return true;
        } catch (error) {
            console.error('Error subscribing:', error);
            return false;
        } finally {
            setLoading(false);
        }
    };

    const unsubscribe = async () => {
        try {
            setLoading(true);
            if (subscription) {
                await subscription.unsubscribe();
                setSubscription(null);
                // Ideally we should also remove from backend, but for MVP we can just let it fail/expire
            }
        } catch (error) {
            console.error('Error unsubscribing:', error);
        } finally {
            setLoading(false);
        }
    };

    return {
        isSupported,
        permission,
        subscription,
        subscribe,
        unsubscribe,
        loading
    };
}
