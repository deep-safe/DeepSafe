import { Haptics, ImpactStyle, NotificationType } from '@capacitor/haptics';
import { Capacitor } from '@capacitor/core';

export const useHaptics = () => {
    const isNative = Capacitor.isNativePlatform();

    const impact = async (style: ImpactStyle = ImpactStyle.Medium) => {
        if (!isNative) return;
        try {
            await Haptics.impact({ style });
        } catch (error) {
            console.error('Haptics impact failed:', error);
        }
    };

    const notification = async (type: NotificationType = NotificationType.Success) => {
        if (!isNative) return;
        try {
            await Haptics.notification({ type });
        } catch (error) {
            console.error('Haptics notification failed:', error);
        }
    };

    const vibrate = async (duration: number = 200) => {
        if (!isNative) return;
        try {
            await Haptics.vibrate({ duration });
        } catch (error) {
            console.error('Haptics vibrate failed:', error);
        }
    };

    const selection = async () => {
        if (!isNative) return;
        try {
            await Haptics.selectionStart();
            await Haptics.selectionChanged();
            await Haptics.selectionEnd();
        } catch (error) {
            console.error('Haptics selection failed:', error);
        }
    };

    return {
        impact,
        notification,
        vibrate,
        selection
    };
};
