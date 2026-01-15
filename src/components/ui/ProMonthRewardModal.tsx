'use client';

import { motion, AnimatePresence } from 'framer-motion';
import { Crown, Sparkles, X } from 'lucide-react';

interface ProMonthRewardModalProps {
    isOpen: boolean;
    onClose: () => void;
    source: 'feedback' | 'referral';
    monthsEarned?: number;
}

export function ProMonthRewardModal({ isOpen, onClose, source, monthsEarned = 1 }: ProMonthRewardModalProps) {
    const getMessage = () => {
        if (source === 'feedback') {
            return {
                title: '🎉 FEEDBACK PREMIATO!',
                subtitle: 'Hai guadagnato 1 mese PRO gratis!',
                description: 'Grazie per il tuo contributo prezioso a DeepSafe. Il tuo feedback ci aiuta a migliorare!'
            };
        } else {
            return {
                title: '🎊 NUOVO REFERRAL!',
                subtitle: `Hai guadagnato ${monthsEarned} mese PRO!`,
                description: 'Un amico si è iscritto usando il tuo codice invito. Ottimo lavoro!'
            };
        }
    };

    const message = getMessage();

    return (
        <AnimatePresence>
            {isOpen && (
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="fixed inset-0 z-[200] flex items-center justify-center bg-black/80 backdrop-blur-sm p-4"
                    onClick={onClose}
                >
                    <motion.div
                        initial={{ scale: 0.5, opacity: 0, y: 50 }}
                        animate={{ scale: 1, opacity: 1, y: 0 }}
                        exit={{ scale: 0.8, opacity: 0, y: 20 }}
                        transition={{ type: "spring", damping: 15, stiffness: 300 }}
                        className="relative bg-gradient-to-br from-amber-950 via-black to-purple-950 border-2 border-amber-500/50 rounded-2xl w-full max-w-md overflow-hidden shadow-[0_0_80px_rgba(251,191,36,0.4)]"
                        onClick={e => e.stopPropagation()}
                    >
                        {/* Animated Background Effects */}
                        <div className="absolute inset-0 overflow-hidden pointer-events-none">
                            <motion.div
                                animate={{
                                    scale: [1, 1.2, 1],
                                    opacity: [0.3, 0.5, 0.3],
                                }}
                                transition={{
                                    duration: 3,
                                    repeat: Infinity,
                                    ease: "easeInOut"
                                }}
                                className="absolute top-0 right-0 w-64 h-64 bg-amber-500/20 blur-[80px] rounded-full"
                            />
                            <motion.div
                                animate={{
                                    scale: [1, 1.3, 1],
                                    opacity: [0.2, 0.4, 0.2],
                                }}
                                transition={{
                                    duration: 4,
                                    repeat: Infinity,
                                    ease: "easeInOut",
                                    delay: 0.5
                                }}
                                className="absolute bottom-0 left-0 w-64 h-64 bg-purple-500/20 blur-[80px] rounded-full"
                            />
                        </div>

                        {/* Sparkles Animation */}
                        <div className="absolute inset-0 pointer-events-none">
                            {[...Array(12)].map((_, i) => (
                                <motion.div
                                    key={i}
                                    initial={{
                                        x: '50%',
                                        y: '50%',
                                        scale: 0,
                                        opacity: 0
                                    }}
                                    animate={{
                                        x: `${Math.cos(i * 30 * Math.PI / 180) * 150 + 50}%`,
                                        y: `${Math.sin(i * 30 * Math.PI / 180) * 150 + 50}%`,
                                        scale: [0, 1, 0],
                                        opacity: [0, 1, 0]
                                    }}
                                    transition={{
                                        duration: 2,
                                        repeat: Infinity,
                                        delay: i * 0.1,
                                        ease: "easeOut"
                                    }}
                                >
                                    <Sparkles className="w-4 h-4 text-amber-400" />
                                </motion.div>
                            ))}
                        </div>

                        {/* Close Button */}
                        <button
                            onClick={onClose}
                            className="absolute top-4 right-4 z-10 p-2 rounded-full bg-black/40 hover:bg-black/60 border border-white/10 transition-colors"
                        >
                            <X className="w-4 h-4 text-white" />
                        </button>

                        {/* Content */}
                        <div className="relative z-10 p-8 text-center space-y-6">
                            {/* Crown Icon with Animation */}
                            <motion.div
                                animate={{
                                    rotate: [0, -10, 10, -10, 0],
                                    scale: [1, 1.1, 1]
                                }}
                                transition={{
                                    duration: 1.5,
                                    repeat: Infinity,
                                    repeatDelay: 2
                                }}
                                className="inline-block"
                            >
                                <div className="relative">
                                    <div className="absolute inset-0 bg-amber-500/30 blur-xl rounded-full" />
                                    <div className="relative w-24 h-24 mx-auto bg-gradient-to-br from-amber-500 to-orange-600 rounded-full flex items-center justify-center border-4 border-amber-400 shadow-[0_0_40px_rgba(251,191,36,0.6)]">
                                        <Crown className="w-12 h-12 text-white" />
                                    </div>
                                </div>
                            </motion.div>

                            {/* Title */}
                            <div className="space-y-2">
                                <motion.h2
                                    initial={{ opacity: 0, y: 20 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.2 }}
                                    className="text-3xl font-bold font-orbitron text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-amber-500 to-orange-500"
                                >
                                    {message.title}
                                </motion.h2>
                                <motion.p
                                    initial={{ opacity: 0, y: 20 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.3 }}
                                    className="text-xl font-bold text-white"
                                >
                                    {message.subtitle}
                                </motion.p>
                            </div>

                            {/* Description */}
                            <motion.p
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.4 }}
                                className="text-sm text-zinc-300 leading-relaxed max-w-sm mx-auto"
                            >
                                {message.description}
                            </motion.p>

                            {/* Pro Badge */}
                            <motion.div
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ delay: 0.5, type: "spring" }}
                                className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-amber-600 to-orange-600 rounded-full border-2 border-amber-400 shadow-[0_0_30px_rgba(251,191,36,0.4)]"
                            >
                                <Crown className="w-5 h-5 text-white" />
                                <span className="text-lg font-bold font-orbitron text-white tracking-wider">
                                    +1 MESE PRO
                                </span>
                            </motion.div>

                            {/* CTA Button */}
                            <motion.button
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.6 }}
                                whileHover={{ scale: 1.05 }}
                                whileTap={{ scale: 0.95 }}
                                onClick={onClose}
                                className="w-full py-4 bg-white text-black font-bold font-orbitron rounded-xl hover:bg-zinc-100 transition-all shadow-lg"
                            >
                                CONTINUA
                            </motion.button>

                            {/* Footer Text */}
                            <motion.p
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                transition={{ delay: 0.7 }}
                                className="text-xs text-zinc-500 font-mono"
                            >
                                Vai su Profilo per attivare i tuoi mesi PRO
                            </motion.p>
                        </div>
                    </motion.div>
                </motion.div>
            )}
        </AnimatePresence>
    );
}
