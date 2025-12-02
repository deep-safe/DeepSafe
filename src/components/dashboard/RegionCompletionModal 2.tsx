import React, { useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, MapPin, Award, Share2 } from 'lucide-react';
import confetti from 'canvas-confetti';

interface RegionCompletionModalProps {
    isOpen: boolean;
    onClose: () => void;
    regionName: string;
    badge: {
        name: string;
        description: string;
        icon: string;
        xp_reward: number;
    } | null;
}

export const RegionCompletionModal: React.FC<RegionCompletionModalProps> = ({ isOpen, onClose, regionName, badge }) => {
    useEffect(() => {
        if (isOpen) {
            // Trigger confetti
            const duration = 3000;
            const end = Date.now() + duration;

            const frame = () => {
                confetti({
                    particleCount: 2,
                    angle: 60,
                    spread: 55,
                    origin: { x: 0 },
                    colors: ['#06b6d4', '#ec4899', '#fbbf24']
                });
                confetti({
                    particleCount: 2,
                    angle: 120,
                    spread: 55,
                    origin: { x: 1 },
                    colors: ['#06b6d4', '#ec4899', '#fbbf24']
                });

                if (Date.now() < end) {
                    requestAnimationFrame(frame);
                }
            };
            frame();
        }
    }, [isOpen]);

    if (!isOpen) return null;

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-md p-4"
            >
                {/* Background Effects */}
                <div className="absolute inset-0 overflow-hidden pointer-events-none">
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-cyan-500/20 rounded-full blur-[100px] animate-pulse" />
                    <div className="absolute top-0 left-0 w-full h-full bg-[url('/grid.svg')] opacity-10" />
                </div>

                <motion.div
                    initial={{ scale: 0.8, y: 50, opacity: 0 }}
                    animate={{ scale: 1, y: 0, opacity: 1 }}
                    transition={{ type: "spring", damping: 15 }}
                    className="relative w-full max-w-md bg-slate-900 border border-cyan-500/50 rounded-2xl overflow-hidden shadow-[0_0_50px_rgba(6,182,212,0.3)]"
                >
                    {/* Header Banner */}
                    <div className="bg-gradient-to-r from-cyan-900 to-blue-900 p-6 text-center relative overflow-hidden">
                        <motion.div
                            initial={{ x: '-100%' }}
                            animate={{ x: '100%' }}
                            transition={{ repeat: Infinity, duration: 2, ease: "linear" }}
                            className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent skew-x-12"
                        />
                        <motion.div
                            initial={{ scale: 0 }}
                            animate={{ scale: 1 }}
                            transition={{ delay: 0.2, type: "spring" }}
                            className="w-24 h-24 mx-auto bg-slate-900 rounded-full flex items-center justify-center border-4 border-cyan-400 shadow-xl mb-4 relative z-10"
                        >
                            <span className="text-6xl filter drop-shadow-[0_0_10px_rgba(255,255,255,0.5)]">
                                {badge?.icon || '🏆'}
                            </span>
                        </motion.div>
                        <h2 className="text-3xl font-bold text-white font-orbitron tracking-wider mb-1">
                            REGION CONQUERED
                        </h2>
                        <div className="flex items-center justify-center gap-2 text-cyan-300 font-mono text-sm">
                            <MapPin className="w-4 h-4" />
                            {regionName.toUpperCase()} SECURED
                        </div>
                    </div>

                    {/* Content */}
                    <div className="p-8 text-center space-y-6">
                        <div className="space-y-2">
                            <h3 className="text-xl font-bold text-white">
                                {badge?.name || 'Master of the Region'}
                            </h3>
                            <p className="text-slate-400 text-sm leading-relaxed">
                                {badge?.description || 'You have successfully completed all missions in this region. The territory is now under your protection.'}
                            </p>
                        </div>

                        {/* Rewards */}
                        <div className="grid grid-cols-2 gap-4">
                            <div className="bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                                <div className="text-xs text-slate-500 font-mono mb-1">XP EARNED</div>
                                <div className="text-2xl font-bold text-yellow-400">+{badge?.xp_reward || 0}</div>
                            </div>
                            <div className="bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                                <div className="text-xs text-slate-500 font-mono mb-1">STATUS</div>
                                <div className="text-xl font-bold text-cyan-400">LEGEND</div>
                            </div>
                        </div>

                        <button
                            onClick={onClose}
                            className="w-full py-4 bg-cyan-600 hover:bg-cyan-500 text-white font-bold rounded-xl transition-all shadow-[0_0_20px_rgba(6,182,212,0.4)] hover:shadow-[0_0_30px_rgba(6,182,212,0.6)] flex items-center justify-center gap-2 group"
                        >
                            <Award className="w-5 h-5 group-hover:scale-110 transition-transform" />
                            CLAIM BADGE & CONTINUE
                        </button>
                    </div>
                </motion.div>
            </motion.div>
        </AnimatePresence>
    );
};
