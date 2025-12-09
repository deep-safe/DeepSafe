'use client';

import { Trophy, Gem } from 'lucide-react';
import { useEffect, useState } from 'react';
import confetti from 'canvas-confetti';
import { CyberModal } from '@/components/ui/CyberModal';

interface MedalUnlockModalProps {
    isOpen: boolean;
    onClose: () => void;
    emeralds: number;
    rubies: number;
}

export function MedalUnlockModal({ isOpen, onClose, emeralds, rubies }: MedalUnlockModalProps) {

    useEffect(() => {
        if (isOpen && (emeralds > 0 || rubies > 0)) {
            triggerConfetti();
        }
    }, [isOpen, emeralds, rubies]);

    const triggerConfetti = () => {
        const duration = 3 * 1000;
        const animationEnd = Date.now() + duration;
        const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 100 };

        const random = (min: number, max: number) => Math.random() * (max - min) + min;

        const interval: any = setInterval(function () {
            const timeLeft = animationEnd - Date.now();

            if (timeLeft <= 0) {
                return clearInterval(interval);
            }

            const particleCount = 50 * (timeLeft / duration);
            confetti({ ...defaults, particleCount, origin: { x: random(0.1, 0.3), y: Math.random() - 0.2 } });
            confetti({ ...defaults, particleCount, origin: { x: random(0.7, 0.9), y: Math.random() - 0.2 } });
        }, 250);
    };

    if (!isOpen || (emeralds === 0 && rubies === 0)) return null;

    const isRuby = rubies > 0;
    const isEmerald = emeralds > 0;

    // Determine content based on highest reward (Ruby > Emerald)
    // If both, show Ruby (Region Completion is bigger)

    const title = isRuby ? 'REGIONE COMPLETATA!' : 'PROVINCIA COMPLETATA!';
    const icon = isRuby ? <Gem className="w-full h-full p-4 text-red-500" /> : <Gem className="w-full h-full p-4 text-emerald-500 text-shadow-glow" />;
    const color = isRuby ? 'red' : 'green';
    const rewardText = isRuby ? '+1 MEDAGLIA RUBINO' : '+1 MEDAGLIA SMERALDO';
    const description = isRuby ? 'Hai dominato l\'intera regione! Continua così, Legend.' : 'Hai conquistato una nuova provincia! Un altro passo verso il dominio.';

    return (
        <CyberModal
            isOpen={isOpen}
            onClose={onClose}
            color={color as any}
            icon={icon}
            title={title}
        >
            <div className="flex flex-col items-center text-center space-y-6">

                {/* 3D Floating Gem */}
                <div className="w-40 h-40 relative animate-float">
                    <div className={`absolute inset-0 blur-3xl rounded-full animate-pulse ${isRuby ? 'bg-red-500/20' : 'bg-emerald-500/20'}`} />
                    <div className={`text-8xl relative z-10 drop-shadow-[0_0_30px_rgba(${isRuby ? '239,68,68' : '16,185,129'},0.8)] filter contrast-125`}>
                        {/* We use SVG or Icon here. Lucide icons are fine but maybe we want specific colors */}
                        {isRuby ? '🔴' : '💎'}
                    </div>
                </div>

                <div className="space-y-2">
                    <h3 className={`text-3xl font-bold font-orbitron text-glow ${isRuby ? 'text-red-400' : 'text-emerald-400'}`}>
                        {rewardText}
                    </h3>
                </div>

                <p className="text-zinc-300 italic font-mono text-sm px-4">
                    "{description}"
                </p>

                <button
                    onClick={onClose}
                    className={`w-full py-3 text-white font-bold rounded-lg transition-all font-orbitron tracking-widest hover:scale-[1.02] active:scale-[0.98] ${isRuby
                            ? 'bg-red-600 hover:bg-red-500 shadow-[0_0_20px_rgba(220,38,38,0.4)]'
                            : 'bg-emerald-600 hover:bg-emerald-500 shadow-[0_0_20px_rgba(5,150,105,0.4)]'
                        }`}
                >
                    CONTINUA
                </button>
            </div>
        </CyberModal>
    );
}
