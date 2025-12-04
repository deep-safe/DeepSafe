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
                initial={{ y: '100%' }}
                animate={{ y: 0 }}
                exit={{ y: '100%' }}
                transition={{ duration: 0.5, ease: "easeOut" }}
                className="fixed bottom-0 left-0 right-0 z-[100] w-full bg-[#0a0a12]/95 backdrop-blur-md border-t border-[#00f3ff]/30 shadow-[0_-5px_30px_rgba(0,243,255,0.15)]"
            >
                <div className="container mx-auto px-4 py-6 md:py-8">
                    <div className="flex flex-col md:flex-row items-center gap-6">
                        {/* Icon & Text */}
                        <div className="flex-1 flex flex-col md:flex-row gap-6 items-center md:items-start text-center md:text-left">
                            <div className="w-14 h-14 rounded-full bg-[#00f3ff]/10 flex items-center justify-center flex-shrink-0 border border-[#00f3ff]/20">
                                <Shield className="w-7 h-7 text-[#00f3ff]" />
                            </div>
                            <div className="space-y-2 max-w-3xl">
                                <h3 className="text-xl font-bold text-white font-['Orbitron'] tracking-wide">
                                    La tua Privacy è la nostra Missione
                                </h3>
                                <p className="text-base text-gray-300 leading-relaxed">
                                    Utilizziamo i cookie per migliorare la tua esperienza di navigazione e analizzare il traffico.
                                    Rispettiamo la tua privacy e i tuoi dati sono al sicuro con noi.
                                    Per maggiori informazioni, consulta la nostra <Link href="/cookie-policy" className="text-[#00f3ff] hover:underline font-medium">Cookie Policy</Link>.
                                </p>
                            </div>
                        </div>

                        {/* Actions */}
                        <div className="flex flex-col sm:flex-row gap-4 w-full md:w-auto min-w-[320px]">
                            <button
                                onClick={handleReject}
                                className="flex-1 px-12 py-5 rounded-xl border border-white/10 text-gray-300 hover:bg-white/5 hover:text-white transition-all font-medium text-base uppercase tracking-wider whitespace-nowrap"
                            >
                                Solo Necessari
                            </button>
                            <button
                                onClick={handleAccept}
                                className="flex-1 px-12 py-5 rounded-xl bg-gradient-to-r from-[#00f3ff] to-[#bc13fe] text-black font-bold hover:opacity-90 transition-opacity shadow-[0_0_20px_rgba(0,243,255,0.3)] text-base uppercase tracking-wider whitespace-nowrap"
                            >
                                Accetta Tutto
                            </button>
                        </div>
                    </div>
                </div>

                {/* Top Progress Line */}
                <div className="absolute top-0 left-0 w-full h-[1px] bg-gradient-to-r from-transparent via-[#00f3ff] to-transparent opacity-50" />
            </motion.div>
        </AnimatePresence>
    );
};
