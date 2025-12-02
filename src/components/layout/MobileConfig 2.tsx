'use client';

import { useEffect } from 'react';
import { StatusBar, Style } from '@capacitor/status-bar';
import { Capacitor } from '@capacitor/core';

import { useDeepLinking } from '@/hooks/useDeepLinking';

export function MobileConfig() {
    useDeepLinking();

    useEffect(() => {
        if (Capacitor.isNativePlatform()) {
            const configureStatusBar = async () => {
                try {
                    await StatusBar.setStyle({ style: Style.Dark });
                    await StatusBar.setBackgroundColor({ color: '#0B0C10' });
                    await StatusBar.setOverlaysWebView({ overlay: false });
                } catch (error) {
                    console.error('Status Bar configuration failed:', error);
                }
            };

            configureStatusBar();
        }
    }, []);

    return null;
}
