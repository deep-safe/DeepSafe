'use client';

import React from 'react';
import { motion, useSpring, useTransform } from 'framer-motion';
import { Flame, CheckCircle, Snowflake } from 'lucide-react';
import { CyberModal } from '@/components/ui/CyberModal';

function StreakCounter({ value, startValue }: { value: number; startValue: number }) {
    const spring = useSpring(startValue, { mass: 0.8, stiffness: 75, damping: 15 });
    const display = useTransform(spring, (current) => Math.round(current));

    React.useEffect(() => {
        spring.set(startValue);
        const timer = setTimeout(() => {
            spring.set(value);
        }, 800);
        return () => clearTimeout(timer);
    }, [spring, value, startValue]);

    return (
        <motion.span className="text-6xl font-black text-transparent bg-clip-text bg-gradient-to-b from-orange-400 to-red-600 font-orbitron drop-shadow-lg">
            {display}
        </motion.span>
    );
}

// ... props ...
interface StreakRewardModalProps {
    isOpen: boolean;
    streak: number;
    previousStreak?: number;
    onClose: () => void;
    isFrozen?: boolean;
}

export default function StreakRewardModal({ isOpen, streak, previousStreak, onClose, isFrozen = false }: StreakRewardModalProps) {
    const title = isFrozen ? "SERIE CONGELATA" : "SISTEMA SINCRONIZZATO";
    const description = isFrozen
        ? "Hai usato un Congelamento Serie per salvare i tuoi progressi!"
        : "Torna domani per mantenere attiva la serie e guadagnare bonus esclusivi.";
    const color = isFrozen ? "cyan" : "orange";
    const icon = isFrozen ? <Snowflake className="w-full h-full p-2" /> : <Flame className="w-full h-full p-2" />;
    const btnColor = isFrozen ? "from-cyan-600 to-blue-600" : "from-orange-600 to-red-600";
    const textColor = isFrozen ? "text-cyan-400" : "text-orange-400";

    return (
        <CyberModal
            isOpen={isOpen}
            onClose={onClose}
            color={color}
            icon={icon}
            title={title}
            description={description}
        >
            <div className="flex flex-col items-center text-center space-y-6">
                <div className="flex flex-col items-center justify-center py-4">
                    <StreakCounter value={streak} startValue={previousStreak ?? Math.max(0, streak - 1)} />
                    <span className={`text-sm ${textColor} font-bold tracking-[0.2em] uppercase mt-2`}>
                        Giorni consecutivi
                    </span>
                </div>

                <button
                    onClick={onClose}
                    className={`w-full py-4 rounded-xl bg-gradient-to-r ${btnColor} text-white font-orbitron font-bold tracking-wider shadow-lg transition-all flex items-center justify-center gap-2 group hover:scale-[1.02] active:scale-[0.98]`}
                >
                    <span>CONTINUA</span>
                    <CheckCircle className="w-5 h-5 group-hover:scale-110 transition-transform" />
                </button>
            </div>
        </CyberModal>
    );
}
