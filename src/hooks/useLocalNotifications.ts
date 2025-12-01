import { useState, useEffect } from 'react';
import { LocalNotifications } from '@capacitor/local-notifications';
import { Capacitor } from '@capacitor/core';
import { useSystemUI } from '@/context/SystemUIContext';

const NOTIFICATIONS_ENABLED_KEY = 'deepsafe_notifications_enabled';

export function useLocalNotifications() {
    const [isEnabled, setIsEnabled] = useState(false);
    const { openModal } = useSystemUI();

    useEffect(() => {
        // Load preference
        const saved = localStorage.getItem(NOTIFICATIONS_ENABLED_KEY);
        if (saved === 'true') setIsEnabled(true);

        // Check actual permission status on mount
        if (Capacitor.isNativePlatform()) {
            LocalNotifications.checkPermissions().then(res => {
                if (res.display === 'granted') {
                    setIsEnabled(true);
                    localStorage.setItem(NOTIFICATIONS_ENABLED_KEY, 'true');
                }
            });
        }
    }, []);

    const scheduleDailyReminder = async () => {
        if (!Capacitor.isNativePlatform()) return;

        // Schedule for 18:00 (6 PM) every day
        const now = new Date();
        const scheduleTime = new Date();
        scheduleTime.setHours(18, 0, 0, 0);

        // If it's already past 18:00, schedule for tomorrow
        if (now > scheduleTime) {
            scheduleTime.setDate(scheduleTime.getDate() + 1);
        }

        try {
            await LocalNotifications.schedule({
                notifications: [
                    {
                        title: "⚠️ Streak a Rischio!",
                        body: "Agente, non hai ancora completato la missione di oggi. Accedi subito per mantenere il tuo grado.",
                        id: 1,
                        schedule: {
                            at: scheduleTime,
                            repeats: true,
                            every: 'day'
                        },
                        sound: 'beep.wav',
                        smallIcon: 'ic_stat_icon_config_sample',
                        actionTypeId: '',
                        extra: null
                    }
                ]
            });
            console.log('Daily reminder scheduled for:', scheduleTime);
        } catch (error) {
            console.error('Error scheduling notification:', error);
        }
    };

    const scheduleGiftNotification = async () => {
        if (!Capacitor.isNativePlatform()) return;

        // Schedule for tomorrow at 10:00 AM
        const scheduleTime = new Date();
        scheduleTime.setDate(scheduleTime.getDate() + 1);
        scheduleTime.setHours(10, 0, 0, 0);

        try {
            await LocalNotifications.schedule({
                notifications: [
                    {
                        title: "🎁 Regalo Giornaliero Pronto!",
                        body: "Un nuovo rifornimento ti attende al Quartier Generale. Riscatta il tuo regalo ora!",
                        id: 2, // Different ID from daily reminder
                        schedule: {
                            at: scheduleTime,
                            allowWhileIdle: true
                        },
                        sound: 'beep.wav',
                        smallIcon: 'ic_stat_icon_config_sample',
                        actionTypeId: '',
                        extra: null
                    }
                ]
            });
            console.log('Gift notification scheduled for:', scheduleTime);
        } catch (error) {
            console.error('Error scheduling gift notification:', error);
        }
    };

    const cancelReminders = async () => {
        if (!Capacitor.isNativePlatform()) return;
        try {
            await LocalNotifications.cancel({ notifications: [{ id: 1 }] });
            // Also clear pending
            const pending = await LocalNotifications.getPending();
            if (pending.notifications.length > 0) {
                await LocalNotifications.cancel(pending);
            }
        } catch (error) {
            console.error('Error canceling notifications:', error);
        }
    };

    const toggleNotifications = async (enabled: boolean) => {
        if (!Capacitor.isNativePlatform()) {
            openModal({
                title: "FUNZIONE MOBILE",
                message: "Le notifiche push sono disponibili solo sull'app mobile ufficiale.",
                type: 'info'
            });
            return false;
        }

        if (enabled) {
            try {
                const result = await LocalNotifications.requestPermissions();
                if (result.display === 'granted') {
                    setIsEnabled(true);
                    localStorage.setItem(NOTIFICATIONS_ENABLED_KEY, 'true');
                    await scheduleDailyReminder();
                    return true;
                } else {
                    openModal({
                        title: "PERMESSO NEGATO",
                        message: "Devi abilitare le notifiche dalle impostazioni del dispositivo per ricevere i promemoria.",
                        type: 'alert'
                    });
                    return false;
                }
            } catch (error) {
                console.error('Error requesting permissions:', error);
                return false;
            }
        } else {
            setIsEnabled(false);
            localStorage.setItem(NOTIFICATIONS_ENABLED_KEY, 'false');
            await cancelReminders();
            return true;
        }
    };

    return {
        isEnabled,
        toggleNotifications,
        scheduleGiftNotification
    };
}
