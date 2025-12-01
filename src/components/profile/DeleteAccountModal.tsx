import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { AlertTriangle, X, Trash2 } from 'lucide-react';

interface DeleteAccountModalProps {
    isOpen: boolean;
    onClose: () => void;
    onConfirm: () => void;
    isDeleting: boolean;
}

export const DeleteAccountModal: React.FC<DeleteAccountModalProps> = ({ isOpen, onClose, onConfirm, isDeleting }) => {
    return (
        <AnimatePresence>
            {isOpen && (
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-md p-4"
                    onClick={onClose}
                >
                    <motion.div
                        initial={{ scale: 0.9, opacity: 0 }}
                        animate={{ scale: 1, opacity: 1 }}
                        exit={{ scale: 0.9, opacity: 0 }}
                        className="bg-zinc-900 border border-red-500/30 rounded-2xl p-6 max-w-md w-full relative overflow-hidden shadow-[0_0_50px_rgba(239,68,68,0.2)]"
                        onClick={e => e.stopPropagation()}
                    >
                        {/* Background Warning Effect */}
                        <div className="absolute -top-20 -right-20 w-64 h-64 bg-red-500/10 blur-[80px] rounded-full pointer-events-none" />

                        <div className="flex items-start gap-4 mb-6">
                            <div className="p-3 rounded-full bg-red-500/10 border border-red-500/20 text-red-500 shrink-0">
                                <AlertTriangle className="w-8 h-8" />
                            </div>
                            <div>
                                <h3 className="text-xl font-bold font-orbitron text-white mb-2">ELIMINAZIONE ACCOUNT</h3>
                                <p className="text-zinc-400 text-sm leading-relaxed">
                                    Sei sicuro di voler procedere? Questa azione è <span className="text-red-400 font-bold">IRREVERSIBILE</span>.
                                </p>
                            </div>
                        </div>

                        <div className="space-y-4 bg-red-500/5 p-4 rounded-lg border border-red-500/10 mb-6">
                            <ul className="space-y-2 text-xs text-red-300/80 list-disc list-inside font-mono">
                                <li>Tutti i progressi verranno persi</li>
                                <li>I badge e l'inventario saranno rimossi</li>
                                <li>Non potrai recuperare questo account</li>
                            </ul>
                        </div>

                        <div className="flex gap-3">
                            <button
                                onClick={onClose}
                                disabled={isDeleting}
                                className="flex-1 py-3 rounded-lg border border-zinc-700 bg-zinc-800/50 text-zinc-300 font-bold font-orbitron hover:bg-zinc-800 transition-all"
                            >
                                ANNULLA
                            </button>
                            <button
                                onClick={onConfirm}
                                disabled={isDeleting}
                                className="flex-1 py-3 rounded-lg bg-red-600 text-white font-bold font-orbitron hover:bg-red-500 transition-all shadow-[0_0_20px_rgba(220,38,38,0.4)] flex items-center justify-center gap-2"
                            >
                                {isDeleting ? (
                                    <span className="animate-pulse">ELIMINAZIONE...</span>
                                ) : (
                                    <>
                                        <Trash2 className="w-4 h-4" /> ELIMINA
                                    </>
                                )}
                            </button>
                        </div>
                    </motion.div>
                </motion.div>
            )}
        </AnimatePresence>
    );
};
