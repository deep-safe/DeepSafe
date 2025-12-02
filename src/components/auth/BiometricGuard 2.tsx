'use client';

import { useState, useEffect } from 'react';
import { useBiometrics } from '@/hooks/useBiometrics';
import { Shield, Lock, Fingerprint } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

export function BiometricGuard({ children }: { children: React.ReactNode }) {
    const { isEnabled, authenticate } = useBiometrics();
    const [isAuthenticated, setIsAuthenticated] = useState(false);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const checkAuth = async () => {
            if (isEnabled) {
                const success = await authenticate();
                setIsAuthenticated(success);
            } else {
                setIsAuthenticated(true);
            }
            setLoading(false);
        };

        // Small delay to ensure hook has loaded preference
        setTimeout(checkAuth, 100);
    }, [isEnabled]);

    const handleRetry = async () => {
        const success = await authenticate();
        setIsAuthenticated(success);
    };

    if (loading) {
        return (
            <div className="fixed inset-0 bg-black flex items-center justify-center z-50">
                <div className="animate-pulse text-cyber-blue">
                    <Shield className="w-12 h-12 mx-auto mb-4" />
                    <div className="font-orbitron tracking-widest">SECURE BOOT...</div>
                </div>
            </div>
        );
    }

    if (!isAuthenticated) {
        return (
            <div className="fixed inset-0 bg-black flex flex-col items-center justify-center z-50 p-6 space-y-8">
                <motion.div
                    initial={{ scale: 0.8, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    className="w-32 h-32 rounded-full border-4 border-red-500/30 flex items-center justify-center relative"
                >
                    <div className="absolute inset-0 border-4 border-red-500 rounded-full border-t-transparent animate-spin-slow" />
                    <Lock className="w-12 h-12 text-red-500" />
                </motion.div>

                <div className="text-center space-y-2">
                    <h1 className="text-2xl font-bold font-orbitron text-red-500 tracking-widest">ACCESSO NEGATO</h1>
                    <p className="text-zinc-500">Autenticazione biometrica richiesta</p>
                </div>

                <button
                    onClick={handleRetry}
                    className="flex items-center gap-2 px-8 py-4 bg-cyber-blue text-black font-bold rounded-xl hover:bg-cyber-green transition-all transform active:scale-95 shadow-[0_0_20px_rgba(6,182,212,0.4)]"
                >
                    <Fingerprint className="w-6 h-6" />
                    SBLOCCA SISTEMA
                </button>
            </div>
        );
    }

    return <>{children}</>;
}
