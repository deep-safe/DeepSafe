import React from 'react';
import { Target, RotateCcw, ShieldAlert, Award } from 'lucide-react';
import { CyberModal } from '@/components/ui/CyberModal';
import { motion } from 'framer-motion';

interface PerfectScoreModalProps {
    score: number;
    totalQuestions: number;
    onRetry: () => void;
    onExit: () => void;
}

export function PerfectScoreModal({ score, totalQuestions, onRetry, onExit }: PerfectScoreModalProps) {
    const percentage = Math.round((score / totalQuestions) * 100);

    return (
        <CyberModal
            isOpen={true}
            onClose={onExit}
            showCloseButton={true}
            color="yellow"
            className="max-w-md border-yellow-500/50 shadow-[0_0_50px_rgba(234,179,8,0.2)]"
        >
            <div className="space-y-6 text-center">

                {/* Header */}
                <div className="space-y-4">
                    <div className="relative inline-block">
                        <Target className="w-16 h-16 text-yellow-500 mx-auto animate-pulse" />
                        <div className="absolute inset-0 bg-yellow-500/20 blur-xl rounded-full" />
                    </div>

                    <h1 className="text-2xl font-bold font-orbitron text-yellow-500 tracking-wider text-glow-warning">
                        MISSIONE INCOMPLETA
                    </h1>

                    <p className="text-zinc-400 font-mono text-sm leading-relaxed">
                        Precisione raggiunta: <span className="text-yellow-500 font-bold">{percentage}%</span>.
                        <br />
                        I protocolli di sicurezza richiedono una precisione del <span className="text-green-400 font-bold">100%</span> per la certificazione.
                    </p>
                </div>

                {/* Stat Grid */}
                <div className="grid grid-cols-2 gap-3">
                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-3 flex flex-col items-center">
                        <span className="text-xs text-zinc-500 uppercase font-bold tracking-wider">Risposte Corrette</span>
                        <span className="text-xl font-mono text-white mt-1">
                            {score}<span className="text-zinc-600">/{totalQuestions}</span>
                        </span>
                    </div>
                    <div className="bg-slate-900/50 border border-slate-800 rounded-xl p-3 flex flex-col items-center">
                        <span className="text-xs text-zinc-500 uppercase font-bold tracking-wider">Errori</span>
                        <span className="text-xl font-mono text-red-400 mt-1">
                            {totalQuestions - score}
                        </span>
                    </div>
                </div>

                {/* Warning Alert */}
                <div className="bg-yellow-950/20 border border-yellow-900/50 rounded-lg p-3 flex items-start args-2 text-left gap-3">
                    <ShieldAlert className="w-5 h-5 text-yellow-500 shrink-0 mt-0.5" />
                    <p className="text-xs text-yellow-500/80 font-mono">
                        Nessuna ricompensa assegnata. I dati sensibili sono ancora vulnerabili. Riprova per ottenere la certificazione.
                    </p>
                </div>

                {/* Actions */}
                <div className="space-y-3 pt-2">
                    <motion.button
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                        onClick={onRetry}
                        className="w-full py-4 bg-yellow-500 text-black font-bold font-orbitron rounded-xl hover:bg-yellow-400 transition-colors shadow-[0_0_20px_rgba(234,179,8,0.4)] flex items-center justify-center gap-2"
                    >
                        <RotateCcw className="w-5 h-5" />
                        RIPETI SIMULAZIONE
                    </motion.button>

                    <button
                        onClick={onExit}
                        className="w-full py-3 text-zinc-500 font-mono text-xs hover:text-white transition-colors uppercase tracking-widest"
                    >
                        [ Ritorna alla Base ]
                    </button>
                </div>
            </div>
        </CyberModal>
    );
}
