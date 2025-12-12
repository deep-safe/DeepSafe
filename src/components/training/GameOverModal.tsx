import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Heart, ShoppingCart, XCircle } from 'lucide-react';

interface GameOverModalProps {
    isOpen: boolean;
    onBuyHearts: () => Promise<void>;
    onGiveUp: () => void;
}

export default function GameOverModal({ isOpen, onBuyHearts, onGiveUp }: GameOverModalProps) {
    const [isLoading, setIsLoading] = useState<'BUY' | null>(null);

    const handleAction = async () => {
        setIsLoading('BUY');
        try {
            await onBuyHearts();
        } finally {
            setIsLoading(null);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
            <AnimatePresence>
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="absolute inset-0 bg-black/90 backdrop-blur-md"
                />
            </AnimatePresence>

            <motion.div
                initial={{ scale: 0.9, opacity: 0, y: 20 }}
                animate={{ scale: 1, opacity: 1, y: 0 }}
                exit={{ scale: 0.9, opacity: 0, y: 20 }}
                className="relative w-full max-w-md bg-slate-900 border border-red-500/30 rounded-2xl p-6 shadow-[0_0_50px_rgba(239,68,68,0.2)] overflow-hidden"
            >
                {/* Background Pulse */}
                <div className="absolute inset-0 bg-red-500/5 animate-pulse" />

                <div className="relative z-10 flex flex-col items-center text-center space-y-6">

                    {/* Heart Break Icon */}
                    <div className="w-24 h-24 rounded-full bg-red-950/50 border-2 border-red-500 flex items-center justify-center shadow-[0_0_30px_rgba(239,68,68,0.4)] mb-2">
                        <Heart className="w-12 h-12 text-red-500 fill-red-500 animate-pulse" />
                    </div>

                    <div className="space-y-2">
                        <h2 className="text-3xl font-orbitron font-bold text-white tracking-wide">
                            SISTEMA CRITICO
                        </h2>
                        <p className="text-red-400 font-mono text-sm">
                            ENERGIA VITALE ESAURITA. RIAVVIO SISTEMA IMMINENTE.
                        </p>
                    </div>

                    <div className="w-full space-y-3 pt-4">
                        {/* Buy Hearts Button */}
                        <button
                            onClick={handleAction}
                            disabled={isLoading !== null}
                            className="w-full py-4 rounded-xl bg-slate-800 border border-slate-600 text-white font-orbitron font-bold tracking-wider hover:bg-slate-700 transition-all group"
                        >
                            <div className="flex items-center justify-center gap-3">
                                {isLoading === 'BUY' ? (
                                    <span className="animate-pulse">ELABORAZIONE...</span>
                                ) : (
                                    <>
                                        <ShoppingCart className="w-5 h-5" />
                                        <span>RICARICA TOTALE (0,99€)</span>
                                    </>
                                )}
                            </div>
                        </button>
                    </div>

                    {/* Give Up Link */}
                    <button
                        onClick={onGiveUp}
                        className="text-slate-500 hover:text-red-400 text-sm font-mono tracking-wider transition-colors mt-4 flex items-center gap-2"
                    >
                        <XCircle className="w-4 h-4" />
                        ABBANDONA MISSIONE
                    </button>
                </div>
            </motion.div>
        </div>
    );
}
