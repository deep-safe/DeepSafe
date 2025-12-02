'use client';

import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useUserStore } from '@/store/useUserStore';
import { Map, Target, Trophy, ChevronRight, X, ShieldCheck } from 'lucide-react';
import { cn } from '@/lib/utils';
import { createBrowserClient } from '@supabase/ssr';

const TUTORIAL_STEPS = [
    {
        id: 'welcome',
        title: 'BENVENUTO AGENTE',
        icon: <ShieldCheck className="w-16 h-16 text-cyber-green" />,
        content: "Sei stato reclutato per l'iniziativa DeepSafe. La tua missione è proteggere l'infrastruttura digitale italiana dalle minacce cyber.",
        color: 'text-cyber-green',
        borderColor: 'border-cyber-green'
    },
    {
        id: 'map',
        title: 'MAPPA TATTICA',
        icon: <Map className="w-16 h-16 text-cyber-blue" />,
        content: "Questa è la tua dashboard operativa. Le regioni scure sono 'Lockate' e inaccessibili. Completa le missioni nelle province adiacenti per sbloccare nuovi territori.",
        color: 'text-cyber-blue',
        borderColor: 'border-cyber-blue'
    },
    {
        id: 'missions',
        title: 'MISSIONI & XP',
        icon: <Target className="w-16 h-16 text-cyber-purple" />,
        content: "Clicca su una provincia per accedere alle Missioni di Addestramento. Guadagna XP per salire di grado e Crediti per potenziare il tuo equipaggiamento.",
        color: 'text-cyber-purple',
        borderColor: 'border-cyber-purple'
    },
    {
        id: 'rank',
        title: 'PROGRESSIONE',
        icon: <Trophy className="w-16 h-16 text-amber-500" />,
        content: "Scala la classifica globale. Mantieni la tua 'Serie Giornaliera' attiva per ottenere bonus esclusivi. Buona fortuna, Agente.",
        color: 'text-amber-500',
        borderColor: 'border-amber-500'
    }
];

export function TutorialOverlay() {
    const { hasSeenTutorial, completeTutorial } = useUserStore();
    const [currentStep, setCurrentStep] = useState(0);
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        // Delay slightly to allow map to load first
        if (!hasSeenTutorial) {
            const checkAuth = async () => {
                const supabase = createBrowserClient(
                    process.env.NEXT_PUBLIC_SUPABASE_URL!,
                    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
                );
                const { data: { user } } = await supabase.auth.getUser();
                if (user) {
                    const timer = setTimeout(() => setIsVisible(true), 1000);
                    return () => clearTimeout(timer);
                }
            };
            checkAuth();
        }
    }, [hasSeenTutorial]);

    const handleNext = () => {
        if (currentStep < TUTORIAL_STEPS.length - 1) {
            setCurrentStep(prev => prev + 1);
        } else {
            handleComplete();
        }
    };

    const handleComplete = () => {
        setIsVisible(false);
        setTimeout(() => completeTutorial(), 500); // Wait for exit animation
    };

    if (!isVisible && hasSeenTutorial) return null;

    const step = TUTORIAL_STEPS[currentStep];

    return (
        <AnimatePresence>
            {isVisible && (
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="fixed inset-0 z-[100] flex items-center justify-center bg-black/80 backdrop-blur-sm p-4"
                >
                    <motion.div
                        key={step.id}
                        initial={{ scale: 0.9, opacity: 0, y: 20 }}
                        animate={{ scale: 1, opacity: 1, y: 0 }}
                        exit={{ scale: 0.9, opacity: 0, y: -20 }}
                        transition={{ type: "spring", duration: 0.5 }}
                        className={cn(
                            "relative w-full max-w-md bg-cyber-dark border-2 rounded-2xl p-1 overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.8)]",
                            step.borderColor
                        )}
                    >
                        {/* Background Grid */}
                        <div className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.03)_1px,transparent_1px)] bg-[size:20px_20px] pointer-events-none" />

                        {/* Scanline */}
                        <div className="absolute top-0 left-0 w-full h-1 bg-white/20 animate-scan pointer-events-none" />

                        <div className="relative z-10 bg-black/40 backdrop-blur-xl p-8 flex flex-col items-center text-center space-y-6 rounded-xl h-full min-h-[400px]">

                            {/* Step Indicator */}
                            <div className="flex gap-2 mb-4">
                                {TUTORIAL_STEPS.map((_, idx) => (
                                    <div
                                        key={idx}
                                        className={cn(
                                            "w-2 h-2 rounded-full transition-all duration-300",
                                            idx === currentStep ? "bg-white w-6" : "bg-white/20"
                                        )}
                                    />
                                ))}
                            </div>

                            {/* Icon with Glow */}
                            <div className="relative">
                                <div className={cn("absolute inset-0 blur-2xl opacity-50", step.color.replace('text-', 'bg-'))} />
                                <motion.div
                                    initial={{ rotateY: 90 }}
                                    animate={{ rotateY: 0 }}
                                    transition={{ delay: 0.2 }}
                                >
                                    {step.icon}
                                </motion.div>
                            </div>

                            {/* Title */}
                            <h2 className={cn("text-2xl font-bold font-orbitron tracking-widest uppercase", step.color)}>
                                {step.title}
                            </h2>

                            {/* Content */}
                            <p className="text-zinc-300 font-mono leading-relaxed text-sm min-h-[80px]">
                                {step.content}
                            </p>

                            {/* Actions */}
                            <div className="mt-auto pt-8 w-full">
                                <button
                                    onClick={handleNext}
                                    className={cn(
                                        "w-full py-4 rounded-lg font-bold font-orbitron tracking-widest uppercase transition-all flex items-center justify-center gap-2 group",
                                        "bg-white text-black hover:bg-zinc-200 shadow-[0_0_20px_rgba(255,255,255,0.3)]"
                                    )}
                                >
                                    {currentStep === TUTORIAL_STEPS.length - 1 ? 'INIZIA MISSIONE' : 'PROCEDI'}
                                    <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />
                                </button>

                                <button
                                    onClick={handleComplete}
                                    className="mt-4 text-xs text-zinc-500 hover:text-white uppercase tracking-widest transition-colors"
                                >
                                    Salta Briefing
                                </button>
                            </div>
                        </div>
                    </motion.div>
                </motion.div>
            )}
        </AnimatePresence>
    );
}
