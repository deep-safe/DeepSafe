import { useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Trophy, X, Sparkles, Check } from 'lucide-react';
import confetti from 'canvas-confetti';
import { RewardNotification } from '@/hooks/useRewardNotifications';

interface RewardNotificationModalProps {
    notification: RewardNotification | null;
    onClose: (id: string) => void;
}

export function RewardNotificationModal({ notification, onClose }: RewardNotificationModalProps) {
    useEffect(() => {
        if (notification) {
            // Trigger confetti
            const duration = 3000;
            const end = Date.now() + duration;

            const frame = () => {
                confetti({
                    particleCount: 2,
                    angle: 60,
                    spread: 55,
                    origin: { x: 0 },
                    colors: ['#66FCF1', '#EAB308', '#FFFFFF']
                });
                confetti({
                    particleCount: 2,
                    angle: 120,
                    spread: 55,
                    origin: { x: 1 },
                    colors: ['#66FCF1', '#EAB308', '#FFFFFF']
                });

                if (Date.now() < end) {
                    requestAnimationFrame(frame);
                }
            };
            frame();
        }
    }, [notification]);

    if (!notification) return null;

    return (
        <AnimatePresence>
            <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                {/* Backdrop */}
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="absolute inset-0 bg-black/80 backdrop-blur-sm"
                    onClick={() => onClose(notification.id)}
                />

                {/* Modal Content */}
                <motion.div
                    initial={{ opacity: 0, scale: 0.9, y: 20 }}
                    animate={{ opacity: 1, scale: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.9, y: 20 }}
                    className="relative w-full max-w-sm bg-black/90 border border-yellow-500/30 rounded-2xl p-6 shadow-[0_0_50px_rgba(234,179,8,0.2)] overflow-hidden"
                >
                    {/* Background Effects */}
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(234,179,8,0.1)_0%,transparent_70%)]" />

                    {/* Header Icon */}
                    <div className="relative z-10 flex flex-col items-center text-center space-y-4">
                        <div className="w-20 h-20 rounded-full bg-yellow-500/10 border border-yellow-500/30 flex items-center justify-center shadow-[0_0_30px_rgba(234,179,8,0.3)] mb-2">
                            <Trophy className="w-10 h-10 text-yellow-400 drop-shadow-[0_0_10px_rgba(234,179,8,0.8)]" />
                        </div>

                        <div className="space-y-1">
                            <motion.h2
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.2 }}
                                className="text-2xl font-bold font-orbitron text-white tracking-wider"
                            >
                                {notification.title}
                            </motion.h2>
                            <motion.p
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                transition={{ delay: 0.3 }}
                                className="text-sm text-zinc-400"
                            >
                                {notification.message}
                            </motion.p>
                        </div>

                        {/* Reward Amount */}
                        <motion.div
                            initial={{ scale: 0.8, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ delay: 0.4, type: "spring" }}
                            className="bg-zinc-900/80 border border-zinc-800 rounded-xl p-4 w-full flex flex-col items-center gap-2 mt-4"
                        >
                            <span className="text-xs uppercase tracking-widest text-zinc-500 font-bold">Ricompensa</span>
                            <div className="flex items-center gap-3">
                                <span className="text-4xl font-bold font-orbitron text-cyber-blue text-glow">
                                    {notification.data.amount}
                                </span>
                                <span className="text-xl font-bold text-cyber-blue/80">NC</span>
                            </div>
                        </motion.div>

                        {/* Action Button */}
                        <motion.button
                            initial={{ opacity: 0, y: 10 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.6 }}
                            onClick={() => onClose(notification.id)}
                            className="w-full bg-yellow-500 hover:bg-yellow-400 text-black font-bold py-3 rounded-xl transition-all shadow-[0_0_20px_rgba(234,179,8,0.3)] hover:shadow-[0_0_30px_rgba(234,179,8,0.5)] flex items-center justify-center gap-2 mt-2"
                        >
                            <Sparkles className="w-5 h-5" />
                            RISCATTA
                        </motion.button>
                    </div>

                    {/* Close Button */}
                    <button
                        onClick={() => onClose(notification.id)}
                        className="absolute top-4 right-4 text-zinc-500 hover:text-white transition-colors"
                    >
                        <X className="w-5 h-5" />
                    </button>
                </motion.div>
            </div>
        </AnimatePresence>
    );
}
