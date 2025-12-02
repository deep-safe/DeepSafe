import React from 'react';
import { Trophy, ArrowUpCircle, CheckCircle2 } from 'lucide-react';
import { CyberModal } from '@/components/ui/CyberModal';

interface TierAscensionModalProps {
    isOpen: boolean;
    currentTier: 'level_1' | 'level_2' | 'level_3';
    onAscend: () => void;
    onClose: () => void;
}

export const TierAscensionModal: React.FC<TierAscensionModalProps> = ({
    isOpen,
    currentTier,
    onAscend,
    onClose
}) => {
    const nextTier = currentTier === 'level_1' ? 'level_2' : 'level_3';

    const tierDisplayNames = {
        level_1: 'GREEN',
        level_2: 'ORANGE',
        level_3: 'GOLD'
    };

    const tierColors: Record<string, 'cyan' | 'orange' | 'yellow'> = {
        level_1: 'cyan', // "Green" tier uses Cyan styling in this app
        level_2: 'orange',
        level_3: 'yellow'
    };

    const nextColor = tierColors[nextTier];
    const currentDisplayName = tierDisplayNames[currentTier];
    const nextDisplayName = tierDisplayNames[nextTier];

    return (
        <CyberModal
            isOpen={isOpen}
            onClose={onClose}
            color={nextColor}
            icon={<Trophy className="w-full h-full p-2" />}
            title="TIER COMPLETED!"
            description={`You have mastered all sectors in the ${currentDisplayName} Tier.`}
        >
            <div className="flex flex-col items-center text-center space-y-6">
                <p className="text-slate-300 font-mono text-sm">
                    Protocol <span className={`font-bold text-${nextColor}-400`}>{nextDisplayName}</span> is now available.
                </p>

                <div className="w-full bg-black/40 p-4 rounded-lg border border-white/10 text-left">
                    <h4 className="text-xs font-bold text-slate-500 mb-3 uppercase tracking-wider">Ascension Rewards</h4>
                    <ul className="space-y-2 text-sm">
                        <li className="flex items-center gap-2 text-white">
                            <CheckCircle2 className={`w-4 h-4 text-${nextColor}-400`} />
                            <span>Unlock {nextDisplayName} Map Theme</span>
                        </li>
                        <li className="flex items-center gap-2 text-white">
                            <CheckCircle2 className={`w-4 h-4 text-${nextColor}-400`} />
                            <span>New {nextDisplayName} Tier Missions</span>
                        </li>
                        <li className="flex items-center gap-2 text-white">
                            <CheckCircle2 className={`w-4 h-4 text-${nextColor}-400`} />
                            <span>Reset Map Progress (Prestige)</span>
                        </li>
                    </ul>
                </div>

                <div className="w-full space-y-3">
                    <button
                        onClick={onAscend}
                        className={`w-full py-4 rounded-xl font-bold text-lg flex items-center justify-center gap-2 transition-all hover:scale-[1.02] active:scale-[0.98] shadow-lg font-orbitron tracking-wider ${nextTier === 'level_2'
                                ? 'bg-gradient-to-r from-orange-600 to-red-600 text-white shadow-orange-900/50'
                                : 'bg-gradient-to-r from-yellow-500 to-amber-600 text-black shadow-yellow-900/50'
                            }`}
                    >
                        <ArrowUpCircle className="w-6 h-6" />
                        ASCEND TO {nextDisplayName}
                    </button>

                    <button
                        onClick={onClose}
                        className="text-slate-500 text-xs hover:text-white transition-colors font-mono"
                    >
                        STAY IN CURRENT TIER
                    </button>
                </div>
            </div>
        </CyberModal>
    );
};
