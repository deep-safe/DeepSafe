import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { Infinity, BatteryFull, ShieldAlert } from 'lucide-react';
import Link from 'next/link';
import { CyberModal } from '@/components/ui/CyberModal';

interface SystemFailureModalProps {
    onRefill: () => void;
    onPremium: () => void;
}

export function SystemFailureModal({ onRefill, onPremium }: SystemFailureModalProps) {
    const [countdown, setCountdown] = useState(900); // 15 minutes in seconds

    useEffect(() => {
        const timer = setInterval(() => {
            setCountdown((prev) => (prev > 0 ? prev - 1 : 900));
        }, 1000);
        return () => clearInterval(timer);
    }, []);

    const formatTime = (seconds: number) => {
        const mins = Math.floor(seconds / 60);
        const secs = seconds % 60;
        return `${mins}:${secs.toString().padStart(2, '0')}`;
    };

    return (
        <CyberModal
            isOpen={true}
            onClose={() => { }} // Prevent closing by clicking outside
            showCloseButton={false}
            color="red"
            className="max-w-md border-red-500/50 shadow-[0_0_50px_rgba(239,68,68,0.3)]"
        >
            <div className="space-y-6 text-center">

                {/* Header Section */}
                <div className="space-y-4">
                    <div className="relative inline-block">
                        <ShieldAlert className="w-16 h-16 text-red-500 mx-auto animate-pulse" />
                        <div className="absolute inset-0 bg-red-500/20 blur-xl rounded-full animate-pulse" />
                    </div>

                    <h1 className="text-3xl font-bold font-orbitron text-red-500 tracking-widest animate-glitch text-glow-danger">
                        ERRORE DI SISTEMA
                    </h1>

                    <p className="text-zinc-400 font-mono text-sm">
                        Protocolli di difesa offline. <span className="text-red-500 font-bold">0/5 Vite rimanenti.</span>
                    </p>

                    <div className="inline-block px-4 py-1 bg-red-500/10 border border-red-500/30 rounded-full">
                        <p className="text-xs font-mono text-red-500 animate-pulse">
                            Prossima ricarica in {formatTime(countdown)}
                        </p>
                    </div>
                </div>

                {/* Monetization Grid */}
                <div className="grid gap-4 mt-8">

                    {/* Option A: Hero (Subscription) */}
                    <motion.button
                        whileHover={{ scale: 1.02, y: -2 }}
                        whileTap={{ scale: 0.98 }}
                        onClick={onPremium}
                        className="relative overflow-visible p-1 rounded-2xl bg-gradient-to-br from-slate-900 to-purple-900 border border-yellow-500/50 shadow-[0_0_20px_rgba(234,179,8,0.2)] group mt-4"
                    >
                        <div className="absolute -top-3 right-4 bg-yellow-500 text-black text-[10px] font-bold px-3 py-1 rounded-full font-orbitron shadow-lg z-10">
                            CONSIGLIATO
                        </div>

                        <div className="bg-black/40 p-4 rounded-xl flex items-center gap-4 h-full">
                            <div className="w-12 h-12 rounded-full bg-yellow-500/20 flex items-center justify-center border border-yellow-500/50 text-yellow-500 shrink-0">
                                <Infinity className="w-6 h-6" />
                            </div>
                            <div className="text-left flex-1">
                                <h3 className="font-bold text-white font-orbitron tracking-wide">POTERE ILLIMITATO</h3>
                                <p className="text-xs text-zinc-300">Vite Infinite + No Pubblicità</p>
                            </div>
                            <div className="px-4 py-2 bg-yellow-500 text-black font-bold rounded-lg text-sm whitespace-nowrap shadow-[0_0_10px_rgba(234,179,8,0.4)] animate-pulse">
                                POTENZIA
                            </div>
                        </div>
                    </motion.button>

                    {/* Option B: Refill (Microtransaction) */}
                    <motion.button
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                        onClick={onRefill}
                        className="p-4 rounded-2xl bg-slate-800/50 border border-cyan-500/30 hover:border-cyan-500 hover:bg-cyan-500/5 transition-all flex items-center justify-between gap-4 group"
                    >
                        <div className="flex items-center gap-4">
                            <div className="w-12 h-12 rounded-full bg-cyan-500/20 flex items-center justify-center border border-cyan-500/50 text-cyan-500 shrink-0">
                                <BatteryFull className="w-6 h-6" />
                            </div>
                            <div className="text-left">
                                <h3 className="font-bold text-white font-orbitron tracking-wide">RICARICA EMERGENZA</h3>
                                <p className="text-xs text-zinc-400">Ricarica istantanea 5 Vite</p>
                            </div>
                        </div>
                        <div className="px-4 py-2 border border-cyan-500 text-cyan-500 bg-transparent hover:bg-cyan-500 hover:text-black hover:shadow-[0_0_15px_rgba(102,252,241,0.5)] font-bold rounded-lg transition-all duration-300 whitespace-nowrap">
                            RICARICA €0.99
                        </div>
                    </motion.button>
                </div>

                {/* Option C: Bailout */}
                <Link
                    href="/"
                    className="block text-zinc-600 text-xs hover:text-white transition-colors mt-4 font-mono uppercase tracking-widest"
                >
                    [ Ritorna alla Base ]
                </Link>

            </div>
        </CyberModal>
    );
}
