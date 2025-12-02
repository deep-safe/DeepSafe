'use client';

import { BadgeDefinition } from '@/data/badgesData';
import { Trophy } from 'lucide-react';
import { useEffect, useState } from 'react';
import confetti from 'canvas-confetti';
import { CyberModal } from '@/components/ui/CyberModal';

interface BadgeUnlockModalProps {
    isOpen: boolean;
    onClose: () => void;
    badgeId: string | null;
}

export function BadgeUnlockModal({ isOpen, onClose, badgeId }: BadgeUnlockModalProps) {
    const [badge, setBadge] = useState<BadgeDefinition | null>(null);

    useEffect(() => {
        if (isOpen && badgeId) {
            import('@/data/badgesData').then(({ BADGES_DATA }) => {
                const found = BADGES_DATA.find(b => b.id === badgeId);
                if (found) {
                    setBadge(found);
                    triggerConfetti();
                }
            });
        }
    }, [isOpen, badgeId]);

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

    if (!isOpen || !badge) return null;

    return (
        <CyberModal
            isOpen={isOpen}
            onClose={onClose}
            color="cyan"
            icon={<Trophy className="w-full h-full p-2" />}
            title="Nuovo Badge Sbloccato!"
        >
            <div className="flex flex-col items-center text-center space-y-6">
                {/* 3D Floating Badge */}
                <div className="w-40 h-40 relative animate-float">
                    <div className="absolute inset-0 bg-cyan-500/20 blur-3xl rounded-full animate-pulse" />
                    <div className="text-8xl relative z-10 drop-shadow-[0_0_30px_rgba(6,182,212,0.8)] filter contrast-125">
                        {badge.icon}
                    </div>
                </div>

                <div className="space-y-2">
                    <h3 className="text-3xl font-bold font-orbitron text-white text-glow">
                        {badge.name}
                    </h3>
                    <div className="inline-block px-4 py-1 rounded-full text-xs font-bold uppercase tracking-widest border border-cyan-500 text-cyan-400 bg-cyan-950/30">
                        +{badge.xpReward} XP
                    </div>
                </div>

                <p className="text-zinc-300 italic font-mono text-sm">
                    "{badge.description}"
                </p>

                <button
                    onClick={onClose}
                    className="w-full py-3 bg-cyan-600 text-white font-bold rounded-lg hover:bg-cyan-500 transition-all font-orbitron tracking-widest shadow-[0_0_20px_rgba(8,145,178,0.4)] hover:shadow-[0_0_30px_rgba(8,145,178,0.6)] hover:scale-[1.02] active:scale-[0.98]"
                >
                    RISCATTA
                </button>
            </div>
        </CyberModal>
    );
}
