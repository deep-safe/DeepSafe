import { useState, useEffect, useRef } from 'react';
import { useUserStore } from '@/store/useUserStore';
import { getToday, isYesterday } from '@/utils/dateUtils';
import { supabase } from '@/lib/supabase/client';

export const useDailyStreak = (enabled: boolean = true) => {
    const { streak, lastStreakDate, incrementStreak, resetStreak } = useUserStore();
    const [showModal, setShowModal] = useState(false);
    const [isFrozen, setIsFrozen] = useState(false);
    const hasChecked = useRef(false); // Prevent double-check on strict mode/remounts

    useEffect(() => {
        if (!enabled || hasChecked.current) return;

        const checkStreak = async () => {
            // AUTH CHECK
            // Client is already initialized
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) return;

            const today = getToday();
            const STREAK_MODAL_KEY = 'deepsafe_streak_modal_pending';
            const STREAK_PREV_KEY = 'deepsafe_streak_prev';

            // Case 1: Same Day (Already logged in today)
            if (lastStreakDate === today) {
                // Check if we have a pending modal from a previous mount/reload
                const modalState = sessionStorage.getItem(STREAK_MODAL_KEY);
                if (modalState) {
                    if (modalState === 'frozen') setIsFrozen(true);
                    setShowModal(true);
                    hasChecked.current = true;
                }
                return;
            }

            // Case 2: Consecutive Day (Last login was yesterday)
            if (lastStreakDate && isYesterday(lastStreakDate)) {
                sessionStorage.setItem(STREAK_PREV_KEY, String(streak));
                incrementStreak();
                sessionStorage.setItem(STREAK_MODAL_KEY, 'true');
                setShowModal(true);
                hasChecked.current = true;
                return;
            }

            // Case 3: Missed Day Logic (Gap > 1 day)
            // Calculate gap
            let daysMissed = 0;
            if (lastStreakDate) {
                const last = new Date(lastStreakDate);
                const current = new Date(today);
                const diffTime = Math.abs(current.getTime() - last.getTime());
                daysMissed = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) - 1; // -1 because 1 day diff is consecutive
            }

            // If missed exactly 1 day (Gap = 2 days total diff) and has freeze
            const { streakFreezes, useStreakFreeze } = useUserStore.getState();

            if (daysMissed === 1 && streakFreezes > 0) {
                // FROZEN!
                // Use freeze
                const success = await useStreakFreeze();
                if (success) {
                    sessionStorage.setItem(STREAK_PREV_KEY, String(streak));
                    await incrementStreak(); // Continue streak!

                    // Mark as frozen for the modal to potentially show a different message
                    sessionStorage.setItem(STREAK_MODAL_KEY, 'frozen');
                    setIsFrozen(true);
                    setShowModal(true);
                    hasChecked.current = true;
                    return;
                }
            }

            // Case 4: Broken Streak or First Time (or no freezes available)
            // Reset to 1 (since user logged in today)
            sessionStorage.setItem(STREAK_PREV_KEY, String(streak));
            resetStreak();
            sessionStorage.setItem(STREAK_MODAL_KEY, 'true');
            setShowModal(true);
            hasChecked.current = true;
        };

        checkStreak();
    }, [lastStreakDate, incrementStreak, resetStreak, enabled]);

    const closeModal = () => {
        sessionStorage.removeItem('deepsafe_streak_modal_pending');
        setShowModal(false);
        setIsFrozen(false);
    };

    const previousStreak = typeof window !== 'undefined'
        ? parseInt(sessionStorage.getItem('deepsafe_streak_prev') || '0')
        : 0;

    return {
        streak,
        showModal,
        closeModal,
        previousStreak,
        isFrozen
    };
};
