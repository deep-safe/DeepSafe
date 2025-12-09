import React from 'react';
import { Medal } from 'lucide-react';
import { cn } from '@/lib/utils'; // Assuming this exists, based on other files

interface MedagliereSectionProps {
    rubies: number;
    emeralds: number;
}

export const MedagliereSection: React.FC<MedagliereSectionProps> = ({ rubies, emeralds }) => {
    return (
        <div className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 space-y-6 relative overflow-hidden">
            {/* Background Effect */}
            <div className="absolute top-0 left-0 w-32 h-32 bg-cyber-green/5 blur-[40px] rounded-full pointer-events-none" />

            {/* Header */}
            <h3 className="text-lg font-bold font-orbitron text-white flex items-center gap-2 relative z-10">
                <Medal className="w-5 h-5 text-cyber-blue" />
                MEDAGLIERE
            </h3>

            {/* Content Grid */}
            <div className="grid grid-cols-2 gap-4 relative z-10">

                {/* Rubies (Region) */}
                <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-4 flex flex-col items-center justify-center space-y-2 group hover:bg-red-500/20 transition-all">
                    <div className="text-3xl filter drop-shadow-[0_0_10px_rgba(239,68,68,0.5)] transform list-none">
                        🔴
                    </div>
                    <div className="text-center">
                        <div className="text-2xl font-bold font-orbitron text-white">{rubies}</div>
                        <div className="text-[10px] font-mono uppercase text-red-400 tracking-wider">Rubini</div>
                    </div>
                </div>

                {/* Emeralds (Province) */}
                <div className="bg-emerald-500/10 border border-emerald-500/30 rounded-xl p-4 flex flex-col items-center justify-center space-y-2 group hover:bg-emerald-500/20 transition-all">
                    <div className="text-3xl filter drop-shadow-[0_0_10px_rgba(16,185,129,0.5)]">
                        🟢
                    </div>
                    <div className="text-center">
                        <div className="text-2xl font-bold font-orbitron text-white">{emeralds}</div>
                        <div className="text-[10px] font-mono uppercase text-emerald-400 tracking-wider">Smeraldi</div>
                    </div>
                </div>

            </div>

            <div className="text-xs text-center text-zinc-500 font-mono pt-2">
                Completa le Regioni per i Rubini, le Province per gli Smeraldi.
            </div>
        </div>
    );
};
