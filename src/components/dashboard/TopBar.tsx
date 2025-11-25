import React from 'react';
import { Flame, Heart, Trophy } from 'lucide-react';
import { motion } from 'framer-motion';

interface TopBarProps {
    // No props needed for now
}

const TopBar: React.FC<TopBarProps> = () => {
    return (
        <div className="absolute top-0 left-0 w-full p-4 z-10 flex flex-col gap-3 pointer-events-none">

            {/* ROW 1: Rank, Streak & Hearts */}
            <div className="flex justify-between items-start w-full">
                <motion.div
                    initial={{ y: -20, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: 0.2 }}
                    className="flex items-center gap-3 pointer-events-auto"
                >
                    {/* Rank Widget */}
                    <div className="bg-black/40 backdrop-blur-md border border-cyber-gray/30 rounded-2xl p-2 pr-4 flex items-center gap-3 shadow-lg group hover:border-amber-500/50 transition-all duration-300">
                        <div className="bg-gradient-to-br from-amber-500/20 to-amber-700/20 p-2 rounded-xl border border-amber-500/30">
                            <Trophy className="w-5 h-5 text-amber-500 drop-shadow-[0_0_8px_rgba(245,158,11,0.5)]" />
                        </div>
                        <div>
                            <div className="text-[9px] text-zinc-400 uppercase font-bold tracking-widest font-mono">Classifica</div>
                            <div className="text-sm font-bold font-orbitron text-white group-hover:text-amber-400 transition-colors">#4</div>
                        </div>
                    </div>

                    {/* Streak Widget */}
                    <div className="bg-black/40 backdrop-blur-md border border-cyber-gray/30 rounded-2xl p-2 pr-4 flex items-center gap-3 shadow-lg group hover:border-orange-500/50 transition-all duration-300">
                        <div className="bg-gradient-to-br from-orange-500/20 to-red-600/20 p-2 rounded-xl border border-orange-500/30">
                            <Flame className="w-5 h-5 text-orange-500 fill-orange-500/20 animate-pulse drop-shadow-[0_0_8px_rgba(249,115,22,0.5)]" />
                        </div>
                        <div>
                            <div className="text-[9px] text-zinc-400 uppercase font-bold tracking-widest font-mono">Serie</div>
                            <div className="text-sm font-bold font-orbitron text-white group-hover:text-orange-400 transition-colors">4</div>
                        </div>
                    </div>

                    {/* Hearts Widget */}
                    <div className="bg-black/40 backdrop-blur-md border border-cyber-gray/30 rounded-2xl p-2 pr-4 flex items-center gap-3 shadow-lg group hover:border-red-500/50 transition-all duration-300">
                        <div className="bg-gradient-to-br from-red-500/20 to-pink-600/20 p-2 rounded-xl border border-red-500/30">
                            <Heart className="w-5 h-5 text-red-500 fill-red-500/20 animate-pulse drop-shadow-[0_0_8px_rgba(239,68,68,0.5)]" />
                        </div>
                        <div>
                            <div className="text-[9px] text-zinc-400 uppercase font-bold tracking-widest font-mono">Cuori</div>
                            <div className="text-sm font-bold font-orbitron text-white group-hover:text-red-400 transition-colors">5</div>
                        </div>
                    </div>
                </motion.div>
            </div>

            {/* ROW 2: Progress */}
            <div className="flex justify-between items-center w-full">
                <motion.div
                    initial={{ y: -20, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: 0.4 }}
                    className="flex items-center gap-3 pointer-events-auto w-full"
                >
                    {/* Progress Widget */}
                    <div className="bg-black/40 backdrop-blur-md border border-cyber-gray/30 rounded-2xl p-3 flex-1 max-w-[200px] shadow-lg">
                        <div className="flex justify-between items-center mb-1.5">
                            <span className="text-[9px] text-zinc-400 uppercase font-bold tracking-widest font-mono">Progress</span>
                            <span className="text-[10px] text-cyber-blue font-mono font-bold">3%</span>
                        </div>
                        <div className="h-1.5 bg-black/60 rounded-full overflow-hidden border border-white/5">
                            <motion.div
                                className="h-full bg-gradient-to-r from-cyber-blue to-cyan-400 shadow-[0_0_10px_rgba(69,162,158,0.5)]"
                                initial={{ width: 0 }}
                                animate={{ width: '3%' }}
                                transition={{ duration: 1, delay: 0.5 }}
                            />
                        </div>
                    </div>
                </motion.div>
            </div>
        </div>
    );
};

export default TopBar;
