import React from 'react';
import { Flame, Heart, Trophy } from 'lucide-react';
import { motion } from 'framer-motion';
import { useUserStore } from '@/store/useUserStore';

interface TopBarProps {
    progress: number;
    total: number;
    className?: string;
}

const TopBar: React.FC<TopBarProps> = ({ progress, total, className = "" }) => {
    const xp = useUserStore(state => state.xp);
    const streak = useUserStore(state => state.streak);
    const lives = useUserStore(state => state.lives);
    const credits = useUserStore(state => state.credits);
    const globalRank = useUserStore(state => state.globalRank);

    const percentage = Math.round((progress / total) * 100) || 0;

    return (
        <div className={`absolute top-0 left-0 w-full p-4 z-30 flex flex-col gap-3 pointer-events-none ${className}`}>

            {/* Main Stats Bar */}
            <div className="flex justify-center w-full">
                <motion.div
                    initial={{ y: -20, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: 0.2 }}
                    className="relative flex items-center gap-2 pointer-events-auto backdrop-blur-xl rounded-2xl p-1.5 pr-6 shadow-2xl"
                >
                    {/* Unified Background & Border Layer */}
                    <div className="absolute inset-0 rounded-2xl overflow-hidden pointer-events-none z-0">
                        <svg className="w-full h-full">
                            <defs>
                                <linearGradient id="progressGradient" x1="0%" y1="0%" x2="100%" y2="0%">
                                    <stop offset="0%" stopColor="#06b6d4" />
                                    <stop offset="50%" stopColor="#22d3ee" />
                                    <stop offset="100%" stopColor="#67e8f9" />
                                </linearGradient>
                            </defs>

                            {/* Main Background Fill */}
                            <rect
                                x="0"
                                y="0"
                                width="100%"
                                height="100%"
                                rx="16"
                                fill="rgba(15, 23, 42, 0.9)"
                            />

                            {/* Background Track Border */}
                            <rect
                                x="2"
                                y="2"
                                width="calc(100% - 4px)"
                                height="calc(100% - 4px)"
                                rx="14"
                                fill="none"
                                stroke="#1e293b"
                                strokeWidth="4"
                                strokeOpacity="0.5"
                            />

                            {/* Progress Border */}
                            <motion.rect
                                x="2"
                                y="2"
                                width="calc(100% - 4px)"
                                height="calc(100% - 4px)"
                                rx="14"
                                fill="none"
                                stroke="url(#progressGradient)"
                                strokeWidth="4"
                                strokeLinecap="round"
                                initial={{ pathLength: 0 }}
                                animate={{ pathLength: percentage / 100 }}
                                transition={{ duration: 1.5, ease: "circOut" }}
                                style={{
                                    filter: "drop-shadow(0 0 3px rgba(34, 211, 238, 0.8))"
                                }}
                            />
                        </svg>
                    </div>

                    {/* Content Wrapper (z-10 to sit on top) */}
                    <div className="relative z-10 flex items-center gap-2">
                        {/* Rank Widget */}
                        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-800/50 border border-slate-700/50">
                            <Trophy className="w-3.5 h-3.5 text-amber-500" />
                            <span className="text-xs font-bold font-orbitron text-slate-200">
                                {globalRank ? `#${globalRank}` : '-'}
                            </span>
                        </div>

                        {/* Streak Widget */}
                        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-800/50 border border-slate-700/50">
                            <Flame className="w-3.5 h-3.5 text-orange-500" />
                            <span className="text-xs font-bold font-orbitron text-slate-200">{streak}</span>
                        </div>

                        {/* Hearts Widget */}
                        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-800/50 border border-slate-700/50">
                            <Heart className={`w-3.5 h-3.5 ${lives > 0 ? 'text-red-500 fill-red-500' : 'text-slate-600'}`} />
                            <span className="text-xs font-bold font-orbitron text-slate-200">{lives}</span>
                        </div>

                        {/* Credits Widget */}
                        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-slate-800/50 border border-slate-700/50">
                            <span className="text-xs font-bold font-orbitron text-yellow-400">NC</span>
                            <span className="text-xs font-bold font-orbitron text-slate-200">{credits}</span>
                        </div>

                        {/* Divider */}
                        <div className="w-px h-4 bg-slate-700 mx-1" />

                        {/* Progress Text (Subtle) */}
                        <div className="flex flex-col items-end leading-none">
                            <span className="text-[10px] font-bold font-orbitron text-cyan-400">{percentage}%</span>
                            <span className="text-[8px] text-slate-500 font-mono">{progress}/{total}</span>
                        </div>
                    </div>
                </motion.div>
            </div>
        </div>
    );
};

export default TopBar;
