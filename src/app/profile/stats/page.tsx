'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { motion } from 'framer-motion';
import { ArrowLeft, Activity, TrendingUp, Zap, PieChart as PieIcon, List } from 'lucide-react';
import { useUserStore } from '@/store/useUserStore';
import { XPTrendChart, SkillsRadarChart, MissionPieChart } from '@/components/profile/StatsCharts';

// Mock Data Generators
const generateXPTrend = (currentXP: number) => {
    const data = [];
    let xp = Math.max(0, currentXP - 500);
    const now = new Date();
    for (let i = 6; i >= 0; i--) {
        const date = new Date(now);
        date.setDate(date.getDate() - i);
        data.push({
            date: date.toLocaleDateString('it-IT', { day: '2-digit', month: '2-digit' }),
            xp: Math.floor(xp)
        });
        xp += Math.random() * 100;
    }
    // Ensure last point matches current XP
    data[data.length - 1].xp = currentXP;
    return data;
};

const SKILLS_DATA = [
    { subject: 'Combattimento', A: 80, fullMark: 100 },
    { subject: 'Intelligence', A: 65, fullMark: 100 },
    { subject: 'Tecnologia', A: 90, fullMark: 100 },
    { subject: 'Carisma', A: 50, fullMark: 100 },
    { subject: 'Agilità', A: 70, fullMark: 100 },
];

const MISSION_DATA = [
    { name: 'Sabotaggio', value: 400 },
    { name: 'Infiltrazione', value: 300 },
    { name: 'Ricognizione', value: 300 },
    { name: 'Hacking', value: 200 },
];

export default function AdvancedStatsPage() {
    const router = useRouter();
    const { xp, isPremium, refreshProfile } = useUserStore();
    const [xpData, setXpData] = useState<any[]>([]);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const init = async () => {
            // Give a small buffer for hydration or fetch fresh data
            await refreshProfile();
            setIsLoading(false);
        };
        init();
    }, [refreshProfile]);

    useEffect(() => {
        if (!isLoading && !isPremium) {
            router.push('/profile');
        }
        if (!isLoading) {
            setXpData(generateXPTrend(xp));
        }
    }, [xp, isPremium, router, isLoading]);

    if (isLoading) {
        return (
            <div className="min-h-screen bg-slate-950 flex items-center justify-center text-cyan-500 font-orbitron animate-pulse">
                CARICAMENTO DATI...
            </div>
        );
    }

    if (!isPremium) return null;

    return (
        <div className="min-h-screen bg-slate-950 text-slate-200 font-sans selection:bg-cyan-500/30 pb-20">
            {/* Background Grid */}
            <div className="fixed inset-0 bg-[linear-gradient(rgba(69,162,158,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(69,162,158,0.03)_1px,transparent_1px)] bg-[size:20px_20px] pointer-events-none" />

            {/* Header */}
            <header className="sticky top-0 z-50 bg-slate-950/80 backdrop-blur-md border-b border-slate-800 p-4">
                <div className="max-w-4xl mx-auto flex items-center gap-4">
                    <button
                        onClick={() => router.back()}
                        className="p-2 rounded-full hover:bg-slate-800 transition-colors text-slate-400 hover:text-white"
                    >
                        <ArrowLeft className="w-6 h-6" />
                    </button>
                    <div>
                        <h1 className="text-xl font-bold font-orbitron text-white tracking-wider flex items-center gap-2">
                            <Activity className="w-5 h-5 text-cyan-500" />
                            ANALISI PRESTAZIONI
                        </h1>
                        <p className="text-xs text-slate-500 font-mono">RAPPORTO DETTAGLIATO AGENTE</p>
                    </div>
                </div>
            </header>

            <main className="max-w-4xl mx-auto p-4 space-y-6 relative z-10">

                {/* XP Trend Section */}
                <section className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 relative overflow-hidden">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-cyan-500/5 blur-[40px] rounded-full pointer-events-none" />
                    <h2 className="text-lg font-bold font-orbitron text-white mb-4 flex items-center gap-2">
                        <TrendingUp className="w-5 h-5 text-cyan-500" />
                        CRESCITA ESPERIENZA (7 GIORNI)
                    </h2>
                    <div className="h-[300px] w-full">
                        <XPTrendChart data={xpData} />
                    </div>
                </section>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    {/* Skills Radar */}
                    <section className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 relative overflow-hidden">
                        <div className="absolute top-0 right-0 w-32 h-32 bg-purple-500/5 blur-[40px] rounded-full pointer-events-none" />
                        <h2 className="text-lg font-bold font-orbitron text-white mb-4 flex items-center gap-2">
                            <Zap className="w-5 h-5 text-purple-500" />
                            PROFILO COMPETENZE
                        </h2>
                        <div className="h-[300px] w-full">
                            <SkillsRadarChart data={SKILLS_DATA} />
                        </div>
                    </section>

                    {/* Mission Distribution */}
                    <section className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 relative overflow-hidden">
                        <div className="absolute top-0 right-0 w-32 h-32 bg-amber-500/5 blur-[40px] rounded-full pointer-events-none" />
                        <h2 className="text-lg font-bold font-orbitron text-white mb-4 flex items-center gap-2">
                            <PieIcon className="w-5 h-5 text-amber-500" />
                            TIPOLOGIA MISSIONI
                        </h2>
                        <div className="h-[300px] w-full flex items-center justify-center">
                            <MissionPieChart data={MISSION_DATA} />
                        </div>
                        {/* Legend */}
                        <div className="grid grid-cols-2 gap-2 mt-4">
                            {MISSION_DATA.map((entry, index) => (
                                <div key={index} className="flex items-center gap-2 text-xs text-slate-400 font-mono">
                                    <div className="w-3 h-3 rounded-full" style={{ backgroundColor: ['#06b6d4', '#a855f7', '#f59e0b', '#10b981'][index] }} />
                                    {entry.name}
                                </div>
                            ))}
                        </div>
                    </section>
                </div>

                {/* Recent Activity List */}
                <section className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 relative overflow-hidden">
                    <h2 className="text-lg font-bold font-orbitron text-white mb-4 flex items-center gap-2">
                        <List className="w-5 h-5 text-emerald-500" />
                        REGISTRO ATTIVITÀ RECENTI
                    </h2>
                    <div className="space-y-3">
                        {[1, 2, 3, 4, 5].map((i) => (
                            <div key={i} className="flex items-center justify-between p-3 rounded-lg bg-white/5 border border-white/5 hover:bg-white/10 transition-colors">
                                <div className="flex items-center gap-3">
                                    <div className="w-2 h-2 rounded-full bg-emerald-500" />
                                    <div>
                                        <div className="text-sm font-bold text-white font-orbitron">MISSIONE COMPLETATA</div>
                                        <div className="text-xs text-slate-500 font-mono">Operazione "Ombra Notturna" - Settore 7</div>
                                    </div>
                                </div>
                                <div className="text-right">
                                    <div className="text-sm font-bold text-cyan-400">+150 XP</div>
                                    <div className="text-[10px] text-slate-600 font-mono">2 ORE FA</div>
                                </div>
                            </div>
                        ))}
                    </div>
                </section>

            </main>
        </div>
    );
}
