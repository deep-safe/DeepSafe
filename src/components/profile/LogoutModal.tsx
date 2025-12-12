import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { LogOut, X } from 'lucide-react';

interface LogoutModalProps {
    isOpen: boolean;
    onClose: () => void;
    onConfirm: () => void;
}

export const LogoutModal: React.FC<LogoutModalProps> = ({ isOpen, onClose, onConfirm }) => {
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
                        className="bg-zinc-900 border border-cyber-blue/30 rounded-2xl p-6 max-w-md w-full relative overflow-hidden shadow-[0_0_50px_rgba(34,211,238,0.2)]"
                        onClick={e => e.stopPropagation()}
                    >
                        {/* Background Effect */}
                        <div className="absolute -top-20 -right-20 w-64 h-64 bg-cyber-blue/10 blur-[80px] rounded-full pointer-events-none" />

                        <div className="flex items-start gap-4 mb-6">
                            <div className="p-3 rounded-full bg-cyber-blue/10 border border-cyber-blue/20 text-cyber-blue shrink-0">
                                <LogOut className="w-8 h-8" />
                            </div>
                            <div>
                                <h3 className="text-xl font-bold font-orbitron text-white mb-2">DISCONNESSIONE SISTEMA</h3>
                                <p className="text-zinc-400 text-sm leading-relaxed">
                                    Sei sicuro di voler uscire dal sistema?
                                </p>
                            </div>
                        </div>

                        <div className="flex gap-3">
                            <button
                                onClick={onClose}
                                className="flex-1 py-3 rounded-lg border border-zinc-700 bg-zinc-800/50 text-zinc-300 font-bold font-orbitron hover:bg-zinc-800 transition-all"
                            >
                                ANNULLA
                            </button>
                            <button
                                onClick={onConfirm}
                                className="flex-1 py-3 rounded-lg bg-red-600 text-white font-bold font-orbitron hover:bg-red-500 transition-all shadow-[0_0_20px_rgba(220,38,38,0.4)] flex items-center justify-center gap-2"
                            >
                                <LogOut className="w-4 h-4" /> DISCONNETTI
                            </button>
                        </div>

                        <button
                            onClick={onClose}
                            className="absolute top-4 right-4 text-zinc-500 hover:text-white transition-colors"
                        >
                            <X className="w-5 h-5" />
                        </button>
                    </motion.div>
                </motion.div>
            )}
        </AnimatePresence>
    );
};
