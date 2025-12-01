import { useState, useEffect } from 'react';
import { NativeBiometric } from '@capgo/capacitor-native-biometric';
import { Capacitor } from '@capacitor/core';
import { useSystemUI } from '@/context/SystemUIContext';

const BIOMETRIC_ENABLED_KEY = 'deepsafe_biometric_enabled';

export function useBiometrics() {
    const [isAvailable, setIsAvailable] = useState(false);
    const [isEnabled, setIsEnabled] = useState(false);
    const [biometryType, setBiometryType] = useState<string | null>(null);
    const { openModal } = useSystemUI();

    useEffect(() => {
        checkAvailability();
        // Load preference
        const saved = localStorage.getItem(BIOMETRIC_ENABLED_KEY);
        if (saved === 'true') setIsEnabled(true);
    }, []);

    const checkAvailability = async () => {
        if (!Capacitor.isNativePlatform()) return;

        try {
            const result = await NativeBiometric.isAvailable();
            if (result.isAvailable) {
                setIsAvailable(true);
                // biometryType is not always available in the result interface for this plugin version
                // setBiometryType(result.biometryType); 
            }
        } catch (error) {
            console.log('Biometrics not available:', error);
        }
    };

    const toggleBiometrics = async (enabled: boolean) => {
        if (!Capacitor.isNativePlatform()) {
            openModal({
                title: "ACCESSO NEGATO",
                message: "Questa funzionalità di sicurezza richiede hardware biometrico dedicato (FaceID/TouchID). Disponibile solo sull'app mobile ufficiale.",
                type: 'alert'
            });
            return false;
        }

        if (enabled) {
            // Verify identity before enabling
            try {
                await NativeBiometric.verifyIdentity({
                    reason: "Verifica identità per abilitare FaceID/TouchID",
                    title: "Autenticazione DeepSafe",
                    subtitle: "Conferma la tua identità",
                    description: "Usa la biometria per proteggere il tuo account"
                });
                setIsEnabled(true);
                localStorage.setItem(BIOMETRIC_ENABLED_KEY, 'true');
                return true;
            } catch (error) {
                console.error('Verification failed:', error);
                return false;
            }
        } else {
            setIsEnabled(false);
            localStorage.setItem(BIOMETRIC_ENABLED_KEY, 'false');
            return true;
        }
    };

    const authenticate = async () => {
        if (!isAvailable) return true; // Skip if not available

        try {
            await NativeBiometric.verifyIdentity({
                reason: "Accedi al tuo account DeepSafe",
                title: "Autenticazione Richiesta",
                subtitle: "Bentornato Agente",
                description: "Verifica la tua identità per accedere"
            });
            return true;
        } catch (error) {
            console.error('Authentication failed:', error);
            return false;
        }
    };

    return {
        isAvailable,
        isEnabled,
        biometryType,
        toggleBiometrics,
        authenticate
    };
}
