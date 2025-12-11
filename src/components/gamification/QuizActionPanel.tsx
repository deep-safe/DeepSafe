import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Check, X, ArrowRight, ShieldCheck, AlertTriangle, ChevronRight } from 'lucide-react';
import { cn } from '@/lib/utils';

interface QuizActionPanelProps {
    isCorrect: boolean;
    correctAnswerText: string;
    explanation: string;
    onNext: () => void;
    isLastQuestion: boolean;
}

export function QuizActionPanel({
    isCorrect,
    correctAnswerText,
    explanation,
    onNext,
    isLastQuestion
}: QuizActionPanelProps) {
    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm"
            >
                <motion.div
                    initial={{ scale: 0.9, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    exit={{ scale: 0.9, opacity: 0 }}
                    transition={{ type: "spring", damping: 25, stiffness: 300 }}
                    className={cn(
                        "w-full max-w-md rounded-3xl border backdrop-blur-xl shadow-2xl relative overflow-hidden max-h-[90vh] flex flex-col",
                        isCorrect
                            ? "bg-[#0B0C10] border-emerald-500 shadow-[0_0_50px_rgba(16,185,129,0.3)]"
                            : "bg-[#0B0C10] border-red-500 shadow-[0_0_50px_rgba(239,68,68,0.3)]"
                    )}
                >
                    {/* Top Glow */}
                    <div className={cn(
                        "absolute top-0 left-0 right-0 h-32 opacity-20 bg-gradient-to-b shrink-0",
                        isCorrect ? "from-emerald-500 to-transparent" : "from-red-500 to-transparent"
                    )} />

                    <div className="p-8 space-y-8 relative z-10 overflow-y-auto custom-scrollbar">
                        {/* Header */}
                        <div className="flex flex-col items-center text-center gap-4">
                            <div className={cn(
                                "w-20 h-20 rounded-full flex items-center justify-center border-4 shadow-xl",
                                isCorrect
                                    ? "bg-emerald-500/10 border-emerald-500 text-emerald-500"
                                    : "bg-red-500/10 border-red-500 text-red-500"
                            )}>
                                {isCorrect ? <ShieldCheck className="w-10 h-10" /> : <X className="w-10 h-10" />}
                            </div>

                            <div>
                                <h3 className={cn(
                                    "text-2xl font-black font-orbitron tracking-wider mb-2",
                                    isCorrect ? "text-emerald-400" : "text-red-400"
                                )}>
                                    {isCorrect ? "RISPOSTA CORRETTA" : "RISPOSTA ERRATA"}
                                </h3>
                                <p className={cn(
                                    "text-xs font-bold tracking-[0.2em] uppercase",
                                    isCorrect ? "text-emerald-600" : "text-red-600"
                                )}>
                                    {isCorrect ? "Protocollo Verificato" : "Minaccia Rilevata"}
                                </p>
                            </div>
                        </div>

                        {/* Content */}
                        <div className="space-y-4">
                            {!isCorrect && (
                                <div className="bg-red-500/10 rounded-xl p-4 border border-red-500/30">
                                    <div className="flex items-center gap-2 text-red-400 font-bold text-xs uppercase tracking-wider mb-2">
                                        <AlertTriangle className="w-4 h-4" />
                                        <span>Risposta Corretta</span>
                                    </div>
                                    <p className="text-white font-medium">
                                        {correctAnswerText}
                                    </p>
                                </div>
                            )}

                            <div className="bg-slate-900/50 rounded-xl p-4 border border-slate-800">
                                <p className="text-slate-300 text-sm leading-relaxed">
                                    {explanation}
                                </p>
                            </div>
                        </div>

                        {/* Action Button */}
                        <button
                            onClick={onNext}
                            className={cn(
                                "w-full py-4 rounded-xl font-bold font-orbitron text-lg tracking-widest flex items-center justify-center gap-3 transition-all active:scale-95 shadow-lg group",
                                isCorrect
                                    ? "bg-emerald-600 hover:bg-emerald-500 text-white shadow-emerald-500/25"
                                    : "bg-red-600 hover:bg-red-500 text-white shadow-red-500/25"
                            )}
                        >
                            <span>
                                {isLastQuestion ? "COMPLETA MISSIONE" : "PROSSIMA DOMANDA"}
                            </span>
                            <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
                        </button>
                    </div>
                </motion.div>
            </motion.div>
        </AnimatePresence>
    );
}
