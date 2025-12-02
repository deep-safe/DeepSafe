'use client';

import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { useUserStore } from '@/store/useUserStore';
import { Howl } from 'howler';

type SoundType = 'click' | 'success' | 'error' | 'levelup' | 'hover';

interface SoundContextType {
    playSound: (type: SoundType) => void;
    isMuted: boolean;
    toggleMute: () => void;
}

const SoundContext = createContext<SoundContextType | undefined>(undefined);

// Define sound paths - these should be in public/sounds/
const SOUND_PATHS: Record<SoundType, string> = {
    click: '/sounds/click.mp3',
    success: '/sounds/success.mp3',
    error: '/sounds/error.mp3',
    levelup: '/sounds/levelup.mp3',
    hover: '/sounds/hover.mp3',
};

export function SoundProvider({ children }: { children: React.ReactNode }) {
    const { settings, updateSettings } = useUserStore();
    const [sounds, setSounds] = useState<Record<SoundType, Howl | null>>({
        click: null,
        success: null,
        error: null,
        levelup: null,
        hover: null,
    });

    useEffect(() => {
        // Initialize sounds
        const newSounds: any = {};
        Object.entries(SOUND_PATHS).forEach(([key, path]) => {
            newSounds[key] = new Howl({
                src: [path],
                volume: 0.5,
                preload: true,
                onloaderror: () => console.warn(`Failed to load sound: ${path}`),
            });
        });
        setSounds(newSounds);
    }, []);

    const playSound = useCallback((type: SoundType) => {
        if (!settings.sound) return;
        const sound = sounds[type];
        if (sound) {
            sound.play();
        }
    }, [settings.sound, sounds]);

    const toggleMute = () => {
        updateSettings({ sound: !settings.sound });
    };

    return (
        <SoundContext.Provider value={{ playSound, isMuted: !settings.sound, toggleMute }}>
            {children}
        </SoundContext.Provider>
    );
}

export function useSound() {
    const context = useContext(SoundContext);
    if (context === undefined) {
        throw new Error('useSound must be used within a SoundProvider');
    }
    return context;
}
