'use client';

import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Lock, LogIn, ShieldAlert } from 'lucide-react';
import { useRouter } from 'next/navigation';

interface AuthGuardModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export const AuthGuardModal: React.FC<AuthGuardModalProps> = ({ isOpen, onClose }) => {
    const router = useRouter();

    if (!isOpen) return null;

    return (
        <AnimatePresence>
            {isOpen && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                    {/* Backdrop */}
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        onClick={onClose}
                        className="absolute inset-0 bg-black/80 backdrop-blur-sm"
                    />

                    {/* Modal */}
                    <motion.div
                        initial={{ scale: 0.9, opacity: 0, y: 20 }}
                        animate={{ scale: 1, opacity: 1, y: 0 }}
                        exit={{ scale: 0.9, opacity: 0, y: -20 }}
                        className="relative w-full max-w-sm bg-slate-900 border border-cyan-500/30 rounded-2xl p-6 shadow-[0_0_50px_rgba(8,145,178,0.2)] overflow-hidden"
                    >
                        {/* Decorative Elements */}
                        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-cyan-500 to-transparent opacity-50" />
                        <div className="absolute -top-10 -right-10 w-32 h-32 bg-cyan-500/10 rounded-full blur-3xl pointer-events-none" />

                        <div className="flex flex-col items-center text-center space-y-4">
                            <div className="p-4 rounded-full bg-cyan-950/50 border border-cyan-500/30 text-cyan-400 mb-2">
                                <ShieldAlert className="w-8 h-8" />
                            </div>

                            <h2 className="text-xl font-bold font-orbitron text-white tracking-wide">
                                ACCESSO NEGATO
                            </h2>

                            <p className="text-sm text-slate-400 leading-relaxed">
                                Questa funzione è riservata agli agenti autorizzati. Effettua l'accesso per procedere con l'operazione.
                            </p>

                            <div className="flex flex-col w-full gap-3 pt-4">
                                <button
                                    onClick={() => router.push('/login')}
                                    className="w-full py-3 bg-cyan-600 hover:bg-cyan-500 text-white font-bold rounded-lg transition-all shadow-[0_0_20px_rgba(8,145,178,0.3)] flex items-center justify-center gap-2 group"
                                >
                                    <LogIn className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                                    ACCEDI ORA
                                </button>

                                <button
                                    onClick={onClose}
                                    className="w-full py-3 bg-slate-800 hover:bg-slate-700 text-slate-300 font-bold rounded-lg transition-colors"
                                >
                                    ANNULLA
                                </button>
                            </div>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    );
};
