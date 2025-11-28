import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Trophy, ArrowUpCircle, CheckCircle2 } from 'lucide-react';

interface TierAscensionModalProps {
    isOpen: boolean;
    currentTier: 'level_1' | 'level_2' | 'level_3';
    onAscend: () => void;
    onClose: () => void;
}

export const TierAscensionModal: React.FC<TierAscensionModalProps> = ({
    isOpen,
    currentTier,
    onAscend,
    onClose
}) => {
    if (!isOpen) return null;

    const nextTier = currentTier === 'level_1' ? 'level_2' : 'level_3';

    const tierDisplayNames = {
        level_1: 'GREEN',
        level_2: 'ORANGE',
        level_3: 'GOLD'
    };

    const tierColors = {
        level_1: { text: 'text-cyan-400', bg: 'bg-cyan-950', border: 'border-cyan-500' },
        level_2: { text: 'text-orange-400', bg: 'bg-orange-950', border: 'border-orange-500' },
        level_3: { text: 'text-yellow-400', bg: 'bg-yellow-950', border: 'border-yellow-500' }
    };

    const nextColors = tierColors[nextTier];
    const currentDisplayName = tierDisplayNames[currentTier];
    const nextDisplayName = tierDisplayNames[nextTier];

    return (
        <AnimatePresence>
            <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm">
                <motion.div
                    initial={{ opacity: 0, scale: 0.9, y: 20 }}
                    animate={{ opacity: 1, scale: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.9, y: 20 }}
                    className={`relative w-full max-w-md p-8 rounded-2xl border-2 ${nextColors.border} ${nextColors.bg} shadow-[0_0_50px_rgba(0,0,0,0.5)] overflow-hidden`}
                >
                    {/* Background Effects */}
                    <div className="absolute inset-0 bg-[url('/grid.svg')] opacity-20" />
                    <div className={`absolute -top-20 -right-20 w-60 h-60 rounded-full blur-3xl opacity-20 ${nextColors.bg.replace('950', '500')}`} />

                    <div className="relative z-10 flex flex-col items-center text-center">
                        <motion.div
                            initial={{ scale: 0, rotate: -180 }}
                            animate={{ scale: 1, rotate: 0 }}
                            transition={{ type: "spring", duration: 1.5 }}
                            className="mb-6 relative"
                        >
                            <div className={`absolute inset-0 blur-xl opacity-50 ${nextColors.bg.replace('950', '500')}`} />
                            <Trophy className={`w-24 h-24 ${nextColors.text}`} />
                        </motion.div>

                        <h2 className="text-3xl font-bold font-orbitron text-white mb-2">
                            TIER COMPLETED!
                        </h2>
                        <p className="text-slate-300 mb-8 font-mono text-sm">
                            You have mastered all sectors in the {currentDisplayName} Tier.
                            <br />
                            Protocol {nextDisplayName} is now available.
                        </p>

                        <div className="space-y-4 w-full">
                            <div className="bg-black/40 p-4 rounded-lg border border-white/10 text-left">
                                <h4 className="text-xs font-bold text-slate-500 mb-2 uppercase tracking-wider">Ascension Rewards</h4>
                                <ul className="space-y-2 text-sm">
                                    <li className="flex items-center gap-2 text-white">
                                        <CheckCircle2 className="w-4 h-4 text-green-400" />
                                        <span>Unlock {nextDisplayName} Map Theme</span>
                                    </li>
                                    <li className="flex items-center gap-2 text-white">
                                        <CheckCircle2 className="w-4 h-4 text-green-400" />
                                        <span>New {nextDisplayName} Tier Missions</span>
                                    </li>
                                    <li className="flex items-center gap-2 text-white">
                                        <CheckCircle2 className="w-4 h-4 text-green-400" />
                                        <span>Reset Map Progress (Prestige)</span>
                                    </li>
                                </ul>
                            </div>

                            <button
                                onClick={onAscend}
                                className={`w-full py-4 rounded-xl font-bold text-lg flex items-center justify-center gap-2 transition-all hover:scale-105 active:scale-95 shadow-lg ${nextTier === 'level_2'
                                    ? 'bg-gradient-to-r from-orange-600 to-red-600 text-white shadow-orange-900/50'
                                    : 'bg-gradient-to-r from-yellow-500 to-amber-600 text-black shadow-yellow-900/50'
                                    }`}
                            >
                                <ArrowUpCircle className="w-6 h-6" />
                                ASCEND TO {nextDisplayName}
                            </button>

                            <button
                                onClick={onClose}
                                className="text-slate-500 text-xs hover:text-white transition-colors"
                            >
                                STAY IN CURRENT TIER
                            </button>
                        </div>
                    </div>
                </motion.div>
            </div>
        </AnimatePresence>
    );
};
