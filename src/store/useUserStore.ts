import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface UserState {
    xp: number;
    streak: number;
    lives: number;
    maxLives: number;
    hasInfiniteLives: boolean;
    lastRefillTime: number | null;

    // Actions
    addXp: (amount: number) => void;
    incrementStreak: () => void;
    resetStreak: () => void;
    decrementLives: () => void;
    refillLives: () => void;
    setInfiniteLives: (active: boolean) => void;
}

export const useUserStore = create<UserState>()(
    persist(
        (set) => ({
            xp: 0,
            streak: 0,
            lives: 5,
            maxLives: 5,
            hasInfiniteLives: false,
            lastRefillTime: null,

            addXp: (amount) => set((state) => ({ xp: state.xp + amount })),
            incrementStreak: () => set((state) => ({ streak: state.streak + 1 })),
            resetStreak: () => set({ streak: 0 }),
            decrementLives: () => set((state) => ({
                lives: Math.max(0, state.lives - 1),
                lastRefillTime: state.lives === state.maxLives ? Date.now() : state.lastRefillTime
            })),
            refillLives: () => set((state) => ({ lives: state.maxLives, lastRefillTime: null })),
            setInfiniteLives: (active) => set({ hasInfiniteLives: active }),
        }),
        {
            name: 'deepsafe-user-storage',
        }
    )
);
