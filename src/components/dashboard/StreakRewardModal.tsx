'use client';

import React from 'react';
import { motion, AnimatePresence, useSpring, useTransform } from 'framer-motion';
import { Flame, CheckCircle } from 'lucide-react';

function StreakCounter({ value, startValue }: { value: number; startValue: number }) {
    const spring = useSpring(startValue, { mass: 0.8, stiffness: 75, damping: 15 });
    const display = useTransform(spring, (current) => Math.round(current));

    React.useEffect(() => {
        spring.set(startValue);
        const timer = setTimeout(() => {
            spring.set(value);
        }, 800);
        return () => clearTimeout(timer);
    }, [spring, value, startValue]);

    return (
        <motion.span className="text-6xl font-black text-transparent bg-clip-text bg-gradient-to-b from-orange-400 to-red-600 font-orbitron drop-shadow-lg">
            {display}
        </motion.span>
    );
}

interface StreakRewardModalProps {
    isOpen: boolean;
    streak: number;
    previousStreak?: number;
    onClose: () => void;
}

export default function StreakRewardModal({ isOpen, streak, previousStreak, onClose }: StreakRewardModalProps) {
    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            <AnimatePresence>
                {isOpen && (
                    <>
                        {/* Backdrop */}
                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/80 backdrop-blur-xl"
                            onClick={onClose}
                        />

                        {/* Modal Card */}
                        <motion.div
                            initial={{ scale: 0.5, opacity: 0, y: 50 }}
                            animate={{
                                scale: 1,
                                opacity: 1,
                                y: 0,
                                transition: { type: "spring", stiffness: 300, damping: 20 }
                            }}
                            exit={{ scale: 0.8, opacity: 0, y: 50 }}
                            className="relative w-full max-w-sm bg-slate-900/90 border border-orange-500/50 rounded-2xl p-8 overflow-hidden shadow-[0_0_50px_rgba(249,115,22,0.3)]"
                        >
                            {/* Background Effects */}
                            <div className="absolute inset-0 bg-gradient-to-b from-orange-500/10 to-transparent pointer-events-none" />
                            <div className="absolute top-0 left-1/2 -translate-x-1/2 w-32 h-32 bg-orange-500/20 blur-[50px] rounded-full pointer-events-none" />

                            <div className="relative z-10 flex flex-col items-center text-center space-y-6">
                                {/* Animated Fire Icon */}
                                <div className="relative">
                                    <motion.div
                                        animate={{
                                            scale: [1, 1.1, 1],
                                            filter: [
                                                "drop-shadow(0 0 10px rgba(249,115,22,0.5))",
                                                "drop-shadow(0 0 25px rgba(249,115,22,0.8))",
                                                "drop-shadow(0 0 10px rgba(249,115,22,0.5))"
                                            ]
                                        }}
                                        transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                                        className="w-24 h-24 rounded-full bg-slate-800 border-2 border-orange-500 flex items-center justify-center"
                                    >
                                        <Flame className="w-12 h-12 text-orange-500 fill-orange-500" />
                                    </motion.div>
                                    {/* Particles/Sparks could go here */}
                                </div>

                                {/* Text Content */}
                                <div className="space-y-2">
                                    <h2 className="text-2xl font-orbitron font-bold text-white tracking-wider uppercase">
                                        Sistema Sincronizzato
                                    </h2>
                                    <div className="flex flex-col items-center justify-center py-2">
                                        <StreakCounter value={streak} startValue={previousStreak ?? Math.max(0, streak - 1)} />
                                        <span className="text-sm text-orange-400 font-bold tracking-[0.2em] uppercase mt-1">
                                            Giorni consecutivi
                                        </span>
                                    </div>
                                    <p className="text-slate-400 text-sm">
                                        Torna domani per mantenere attiva la serie e guadagnare bonus XP.
                                    </p>
                                </div>

                                {/* Action Button */}
                                <motion.button
                                    whileHover={{ scale: 1.05 }}
                                    whileTap={{ scale: 0.95 }}
                                    onClick={onClose}
                                    className="w-full py-4 rounded-xl bg-gradient-to-r from-orange-600 to-red-600 text-white font-orbitron font-bold tracking-wider shadow-lg hover:shadow-orange-500/40 transition-all flex items-center justify-center gap-2 group"
                                >
                                    <span>CONTINUA</span>
                                    <CheckCircle className="w-5 h-5 group-hover:scale-110 transition-transform" />
                                </motion.button>
                            </div>
                        </motion.div>
                    </>
                )}
            </AnimatePresence>
        </div>
    );
}
