'use client';

import { motion, AnimatePresence } from 'framer-motion';
import { X, AlertTriangle, Check, Coins } from 'lucide-react';

interface PurchaseConfirmationModalProps {
    isOpen: boolean;
    onClose: () => void;
    onConfirm: () => void;
    item: {
        name: string;
        cost: number;
        description: string | null;
        icon: string;
    } | null;
    isProcessing: boolean;
}

export function PurchaseConfirmationModal({ isOpen, onClose, onConfirm, item, isProcessing }: PurchaseConfirmationModalProps) {
    if (!isOpen || !item) return null;

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4"
                onClick={onClose}
            >
                <motion.div
                    initial={{ scale: 0.9, y: 20 }}
                    animate={{ scale: 1, y: 0 }}
                    exit={{ scale: 0.9, y: 20 }}
                    className="bg-slate-900 border border-slate-700 rounded-2xl w-full max-w-md overflow-hidden shadow-2xl relative"
                    onClick={e => e.stopPropagation()}
                >
                    {/* Header */}
                    <div className="p-4 border-b border-slate-800 flex justify-between items-center bg-slate-800/50">
                        <h3 className="font-orbitron font-bold text-white tracking-wide flex items-center gap-2">
                            <AlertTriangle className="w-5 h-5 text-yellow-500" />
                            CONFERMA ACQUISTO
                        </h3>
                        <button onClick={onClose} disabled={isProcessing} className="text-slate-400 hover:text-white transition-colors">
                            <X className="w-5 h-5" />
                        </button>
                    </div>

                    {/* Content */}
                    <div className="p-6 text-center">
                        <div className="w-20 h-20 mx-auto bg-slate-800 rounded-full flex items-center justify-center text-4xl mb-4 border border-slate-700 shadow-lg">
                            {item.icon}
                        </div>

                        <h2 className="text-xl font-bold text-white mb-2">{item.name}</h2>
                        <p className="text-slate-400 text-sm mb-6 leading-relaxed">
                            {item.description || "Nessuna descrizione disponibile."}
                        </p>

                        <div className="bg-slate-950/50 rounded-xl p-4 border border-slate-800 mb-6">
                            <div className="text-xs text-slate-500 uppercase tracking-widest mb-1">Costo totale</div>
                            <div className="text-2xl font-bold text-yellow-400 font-mono flex items-center justify-center gap-2">
                                <Coins className="w-6 h-6" />
                                {item.cost} NC
                            </div>
                        </div>

                        <div className="flex gap-3">
                            <button
                                onClick={onClose}
                                disabled={isProcessing}
                                className="flex-1 py-3 rounded-xl font-bold text-sm bg-slate-800 text-slate-300 hover:bg-slate-700 transition-colors border border-slate-700"
                            >
                                ANNULLA
                            </button>
                            <button
                                onClick={onConfirm}
                                disabled={isProcessing}
                                className="flex-1 py-3 rounded-xl font-bold text-sm bg-yellow-500 text-black hover:bg-yellow-400 transition-colors shadow-[0_0_20px_rgba(234,179,8,0.2)] flex items-center justify-center gap-2"
                            >
                                {isProcessing ? (
                                    <span className="animate-pulse">ELABORAZIONE...</span>
                                ) : (
                                    <>
                                        CONFERMA
                                        <Check className="w-4 h-4" />
                                    </>
                                )}
                            </button>
                        </div>
                    </div>
                </motion.div>
            </motion.div>
        </AnimatePresence>
    );
}
