'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { useConsentStore } from '@/store/useConsentStore';
import { Shield, X } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

export const CookieConsent = () => {
    const { consent, setConsent, hasHydrated } = useConsentStore();
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        if (hasHydrated && consent === 'undecided') {
            // Small delay to prevent flashing or immediate obstruction
            const timer = setTimeout(() => setIsVisible(true), 1000);
            return () => clearTimeout(timer);
        } else {
            setIsVisible(false);
        }
    }, [hasHydrated, consent]);

    const handleAccept = () => {
        setConsent('accepted');
        setIsVisible(false);
    };

    const handleReject = () => {
        setConsent('rejected');
        setIsVisible(false);
    };

    if (!isVisible) return null;

    return (
        <AnimatePresence>
            <motion.div
                initial={{ y: 100, opacity: 0 }}
                animate={{ y: 0, opacity: 1 }}
                exit={{ y: 100, opacity: 0 }}
                transition={{ duration: 0.5, ease: "easeOut" }}
                className="fixed bottom-0 left-0 right-0 z-[100] p-4 md:p-6"
            >
                <div className="max-w-5xl mx-auto bg-[#0a0a12]/95 backdrop-blur-md border border-[#00f3ff]/30 rounded-2xl shadow-[0_0_30px_rgba(0,243,255,0.15)] overflow-hidden">
                    <div className="flex flex-col md:flex-row items-center gap-6 p-6">
                        {/* Icon & Text */}
                        <div className="flex-1 flex flex-col md:flex-row gap-4 items-center md:items-start text-center md:text-left">
                            <div className="w-12 h-12 rounded-full bg-[#00f3ff]/10 flex items-center justify-center flex-shrink-0">
                                <Shield className="w-6 h-6 text-[#00f3ff]" />
                            </div>
                            <div className="space-y-2">
                                <h3 className="text-lg font-bold text-white font-['Orbitron']">
                                    La tua Privacy è la nostra Missione
                                </h3>
                                <p className="text-sm text-gray-300 leading-relaxed max-w-2xl">
                                    Utilizziamo i cookie per migliorare la tua esperienza di navigazione e analizzare il traffico.
                                    Rispettiamo la tua privacy e i tuoi dati sono al sicuro con noi.
                                    Per maggiori informazioni, consulta la nostra <Link href="/cookie-policy" className="text-[#00f3ff] hover:underline">Cookie Policy</Link>.
                                </p>
                            </div>
                        </div>

                        {/* Actions */}
                        <div className="flex flex-col sm:flex-row gap-3 w-full md:w-auto min-w-[300px]">
                            <button
                                onClick={handleReject}
                                className="px-6 py-3 rounded-xl border border-white/10 text-gray-300 hover:bg-white/5 hover:text-white transition-all font-medium text-sm"
                            >
                                Solo Necessari
                            </button>
                            <button
                                onClick={handleAccept}
                                className="px-6 py-3 rounded-xl bg-gradient-to-r from-[#00f3ff] to-[#bc13fe] text-black font-bold hover:opacity-90 transition-opacity shadow-[0_0_15px_rgba(0,243,255,0.3)] text-sm"
                            >
                                Accetta Tutto
                            </button>
                        </div>
                    </div>

                    {/* Progress Bar / Decoration */}
                    <div className="h-1 w-full bg-gradient-to-r from-[#00f3ff] via-[#bc13fe] to-[#00f3ff] opacity-50" />
                </div>
            </motion.div>
        </AnimatePresence>
    );
};
