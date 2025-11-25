'use client';

import { useState, useEffect } from 'react';
import { createBrowserClient } from '@supabase/ssr';
import { Database } from '@/types/supabase';
import { motion } from 'framer-motion';
import { Activity, Globe, Users, Medal, Cpu } from 'lucide-react';
import { cn } from '@/lib/utils';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder';
const supabase = createBrowserClient<Database>(supabaseUrl, supabaseKey);

interface LeaderboardEntry {
    id: string;
    username: string;
    avatar_url: string | null;
    xp: number;
    rank: number;
}

export default function LeaderboardPage() {
    const [user, setUser] = useState<any>(null);
    const [leaderboardTab, setLeaderboardTab] = useState<'global' | 'friends'>('global');
    const [leaderboardData, setLeaderboardData] = useState<LeaderboardEntry[]>([]);
    const [userRank, setUserRank] = useState<number>(0);

    useEffect(() => {
        const getUser = async () => {
            const { data: { user } } = await supabase.auth.getUser();
            setUser(user);
        };
        getUser();
    }, []);

    useEffect(() => {
        fetchLeaderboard();
    }, [user, leaderboardTab]);

    const fetchLeaderboard = async () => {
        // Mock data
        const mockData: LeaderboardEntry[] = Array.from({ length: 10 }).map((_, i) => ({
            id: `user-${i}`,
            username: i === 0 ? 'CyberMaster' : `Agente_${100 + i}`,
            avatar_url: null,
            xp: 5000 - (i * 200),
            rank: i + 1
        }));

        if (user) {
            setUserRank(42);
        }

        setLeaderboardData(mockData);
    };

    return (
        <div className="space-y-8 pb-32 relative p-4 pt-8">
            {/* Background Grid */}
            <div className="absolute inset-0 bg-[linear-gradient(rgba(69,162,158,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(69,162,158,0.03)_1px,transparent_1px)] bg-[size:20px_20px] pointer-events-none -z-10" />

            <div className="space-y-4">
                <div className="flex items-center justify-center gap-2 mb-6">
                    <Activity className="w-6 h-6 text-cyber-blue" />
                    <h1 className="text-2xl font-bold font-orbitron text-white tracking-wider text-glow">STATO RETE</h1>
                </div>

                <div className="flex p-1 bg-black/40 rounded-xl border border-cyber-gray/20 max-w-md mx-auto">
                    <button
                        onClick={() => setLeaderboardTab('global')}
                        className={cn(
                            "flex-1 flex items-center justify-center gap-2 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all",
                            leaderboardTab === 'global'
                                ? "bg-cyber-blue/10 text-cyber-blue border border-cyber-blue/30 shadow-[0_0_10px_rgba(69,162,158,0.1)]"
                                : "text-zinc-600 hover:text-zinc-400"
                        )}
                    >
                        <Globe className="w-4 h-4" /> Globale
                    </button>
                    <button
                        onClick={() => setLeaderboardTab('friends')}
                        className={cn(
                            "flex-1 flex items-center justify-center gap-2 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all",
                            leaderboardTab === 'friends'
                                ? "bg-cyber-blue/10 text-cyber-blue border border-cyber-blue/30 shadow-[0_0_10px_rgba(69,162,158,0.1)]"
                                : "text-zinc-600 hover:text-zinc-400"
                        )}
                    >
                        <Users className="w-4 h-4" /> Squadra
                    </button>
                </div>

                <div className="space-y-2 max-w-md mx-auto">
                    {leaderboardData.map((entry, index) => (
                        <motion.div
                            key={entry.id}
                            initial={{ opacity: 0, x: -10 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ delay: index * 0.05 }}
                            className={cn(
                                "flex items-center p-3 rounded-xl border transition-all relative overflow-hidden",
                                entry.id === user?.id
                                    ? "border-cyber-blue bg-cyber-blue/5"
                                    : "border-white/5 bg-black/20 hover:bg-white/5"
                            )}
                        >
                            {entry.id === user?.id && (
                                <div className="absolute left-0 top-0 bottom-0 w-1 bg-cyber-blue shadow-[0_0_10px_#66FCF1]" />
                            )}

                            <div className={cn(
                                "w-8 h-8 flex items-center justify-center font-bold font-mono rounded-full mr-3 text-sm",
                                index === 0 ? "text-yellow-500 drop-shadow-[0_0_5px_rgba(234,179,8,0.5)]" :
                                    index === 1 ? "text-zinc-300" :
                                        index === 2 ? "text-amber-700" : "text-zinc-600"
                            )}>
                                {index < 3 ? <Medal className="w-5 h-5" /> : `#${entry.rank}`}
                            </div>

                            <div className="w-8 h-8 bg-cyber-gray/30 rounded-full flex items-center justify-center mr-3 overflow-hidden border border-white/10">
                                {entry.avatar_url ? (
                                    <img src={entry.avatar_url} alt={entry.username} className="w-full h-full object-cover" />
                                ) : (
                                    <Cpu className="w-4 h-4 text-cyber-gray" />
                                )}
                            </div>

                            <div className="flex-1">
                                <h3 className={cn(
                                    "font-bold text-sm tracking-wide",
                                    entry.id === user?.id ? "text-cyber-blue text-glow" : "text-zinc-300"
                                )}>
                                    {entry.username}
                                </h3>
                            </div>

                            <div className="text-right">
                                <span className="font-mono text-cyber-purple font-bold text-xs tracking-wider">{entry.xp} XP</span>
                            </div>
                        </motion.div>
                    ))}
                </div>
            </div>
        </div>
    );
}
