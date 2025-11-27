'use client';

import { useCallback } from 'react';
import { useUserStore } from '@/store/useUserStore';

type HapticType = 'light' | 'medium' | 'heavy' | 'success' | 'warning' | 'error';

export function useHaptic() {
    const { settings } = useUserStore();

    const triggerHaptic = useCallback((type: HapticType) => {
        if (typeof window === 'undefined' || !navigator.vibrate || !settings.haptics) return;

        switch (type) {
            case 'light':
                navigator.vibrate(10);
                break;
            case 'medium':
                navigator.vibrate(40);
                break;
            case 'heavy':
                navigator.vibrate(80);
                break;
            case 'success':
                navigator.vibrate([50, 30, 50]);
                break;
            case 'warning':
                navigator.vibrate([30, 50, 30]);
                break;
            case 'error':
                navigator.vibrate([50, 50, 50, 50, 100]);
                break;
        }
    }, [settings.haptics]);

    return { triggerHaptic };
}
