'use client';

import React, { useEffect, useState } from 'react';
import { createBrowserClient } from '@supabase/ssr';
import { Database } from '@/types/supabase';
import { useRouter } from 'next/navigation';
import { ArrowLeft, Users, Zap, Coins, TrendingUp, Activity, Target } from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar } from 'recharts';

// Initialize Supabase Client
const supabase = createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

interface AnalyticsOverview {
    total_users: number;
    dau: number;
    total_xp: number;
    total_credits: number;
    total_spent: number;
}

interface UserGrowthData {
    date: string;
    count: number;
}

interface MissionStats {
    title: string;
    completions: number;
    avg_score: number;
}

export default function AdminAnalyticsPage() {
    const router = useRouter();
    const [isLoading, setIsLoading] = useState(true);
    const [overview, setOverview] = useState<AnalyticsOverview | null>(null);
    const [growthData, setGrowthData] = useState<UserGrowthData[]>([]);
    const [missionStats, setMissionStats] = useState<MissionStats[]>([]);

    useEffect(() => {
        checkAdminAndFetchData();
    }, []);

    const checkAdminAndFetchData = async () => {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) {
            router.push('/login');
            return;
        }

        const { data: profile } = await supabase
            .from('profiles')
            .select('is_admin')
            .eq('id', user.id)
            .single();

        if (!profile?.is_admin) {
            router.push('/');
            return;
        }

        await fetchAnalytics();
    };

    const fetchAnalytics = async () => {
        setIsLoading(true);

        // Fetch Overview
        try {
            const { data: overviewData, error: overviewError } = await supabase.rpc('get_analytics_overview');
            if (overviewError) {
                console.error('Error fetching overview:', JSON.stringify(overviewError, null, 2));
            } else {
                setOverview(overviewData as unknown as AnalyticsOverview);
            }
        } catch (err) {
            console.error('Exception fetching overview:', err);
        }

        // Fetch User Growth
        try {
            const { data: growthData, error: growthError } = await supabase.rpc('get_user_growth');
            if (growthError) {
                console.error('Error fetching user growth:', JSON.stringify(growthError, null, 2));
            } else {
                setGrowthData(growthData as unknown as UserGrowthData[]);
            }
        } catch (err) {
            console.error('Exception fetching user growth:', err);
        }

        // Fetch Mission Stats
        try {
            const { data: missionData, error: missionError } = await supabase.rpc('get_mission_stats');
            if (missionError) {
                console.error('Error fetching mission stats:', JSON.stringify(missionError, null, 2));
            } else {
                setMissionStats(missionData as unknown as MissionStats[]);
            }
        } catch (err) {
            console.error('Exception fetching mission stats:', err);
        }

        setIsLoading(false);
    };

    if (isLoading) return <div className="min-h-screen bg-black flex items-center justify-center text-cyan-500 font-mono">LOADING ANALYTICS...</div>;

    return (
        <div className="min-h-screen bg-slate-950 text-slate-200 font-sans selection:bg-cyan-500/30 p-8">
            {/* Header */}
            <header className="flex items-center justify-between mb-8">
                <div className="flex items-center gap-4">
                    <button
                        onClick={() => router.push('/admin')}
                        className="p-2 rounded-lg hover:bg-slate-800 text-slate-400 hover:text-white transition-colors"
                    >
                        <ArrowLeft className="w-6 h-6" />
                    </button>
                    <div>
                        <h1 className="text-3xl font-bold text-white font-orbitron">SYSTEM ANALYTICS</h1>
                        <p className="text-slate-400 text-sm">Real-time surveillance data</p>
                    </div>
                </div>
                <button
                    onClick={fetchAnalytics}
                    className="flex items-center gap-2 px-4 py-2 bg-slate-900 border border-cyan-500/30 hover:bg-cyan-950/30 text-cyan-400 rounded-lg transition-colors font-mono text-sm"
                >
                    <Activity className="w-4 h-4" />
                    REFRESH DATA
                </button>
            </header>

            {/* Overview Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6 mb-8">
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden group" title="Total number of registered user profiles.">
                    <div className="absolute inset-0 bg-cyan-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                    <div className="flex justify-between items-start mb-4">
                        <div className="p-3 bg-cyan-500/10 rounded-lg">
                            <Users className="w-6 h-6 text-cyan-400" />
                        </div>
                        <span className="text-xs font-mono text-cyan-500 bg-cyan-950/30 px-2 py-1 rounded">TOTAL</span>
                    </div>
                    <h3 className="text-3xl font-bold text-white font-mono mb-1">{overview?.total_users || 0}</h3>
                    <p className="text-sm text-slate-400">Registered Agents</p>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden group" title="Users who have logged in today (UTC).">
                    <div className="absolute inset-0 bg-emerald-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                    <div className="flex justify-between items-start mb-4">
                        <div className="p-3 bg-emerald-500/10 rounded-lg">
                            <Activity className="w-6 h-6 text-emerald-400" />
                        </div>
                        <span className="text-xs font-mono text-emerald-500 bg-emerald-950/30 px-2 py-1 rounded">24H</span>
                    </div>
                    <h3 className="text-3xl font-bold text-white font-mono mb-1">{overview?.dau || 0}</h3>
                    <p className="text-sm text-slate-400">Active Agents</p>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden group" title="Sum of XP across all users.">
                    <div className="absolute inset-0 bg-yellow-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                    <div className="flex justify-between items-start mb-4">
                        <div className="p-3 bg-yellow-500/10 rounded-lg">
                            <Zap className="w-6 h-6 text-yellow-400" />
                        </div>
                        <span className="text-xs font-mono text-yellow-500 bg-yellow-950/30 px-2 py-1 rounded">XP</span>
                    </div>
                    <h3 className="text-3xl font-bold text-white font-mono mb-1">{(overview?.total_xp || 0).toLocaleString()}</h3>
                    <p className="text-sm text-slate-400">Total Experience</p>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden group" title="Sum of Credits across all users.">
                    <div className="absolute inset-0 bg-purple-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                    <div className="flex justify-between items-start mb-4">
                        <div className="p-3 bg-purple-500/10 rounded-lg">
                            <Coins className="w-6 h-6 text-purple-400" />
                        </div>
                        <span className="text-xs font-mono text-purple-500 bg-purple-950/30 px-2 py-1 rounded">SUPPLY</span>
                    </div>
                    <h3 className="text-3xl font-bold text-white font-mono mb-1">{(overview?.total_credits || 0).toLocaleString()}</h3>
                    <p className="text-sm text-slate-400">Circulating Credits</p>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden group" title="Estimated value of all items in user inventories.">
                    <div className="absolute inset-0 bg-orange-500/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                    <div className="flex justify-between items-start mb-4">
                        <div className="p-3 bg-orange-500/10 rounded-lg">
                            <TrendingUp className="w-6 h-6 text-orange-400" />
                        </div>
                        <span className="text-xs font-mono text-orange-500 bg-orange-950/30 px-2 py-1 rounded">SPENT</span>
                    </div>
                    <h3 className="text-3xl font-bold text-white font-mono mb-1">{(overview?.total_spent || 0).toLocaleString()}</h3>
                    <p className="text-sm text-slate-400">Credits Spent</p>
                </div>
            </div>

            {/* Charts Section */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                {/* User Growth Chart */}
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <div className="flex items-center gap-3 mb-6">
                        <TrendingUp className="w-5 h-5 text-cyan-400" />
                        <h3 className="text-lg font-bold text-white font-orbitron">AGENT RECRUITMENT (30 DAYS)</h3>
                    </div>
                    <div className="h-[300px] w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <LineChart data={growthData}>
                                <CartesianGrid strokeDasharray="3 3" stroke="#334155" vertical={false} />
                                <XAxis
                                    dataKey="date"
                                    stroke="#94a3b8"
                                    tick={{ fontSize: 12 }}
                                    tickFormatter={(value) => new Date(value).toLocaleDateString(undefined, { day: '2-digit', month: '2-digit' })}
                                />
                                <YAxis stroke="#94a3b8" tick={{ fontSize: 12 }} />
                                <Tooltip
                                    contentStyle={{ backgroundColor: '#0f172a', borderColor: '#334155', color: '#f8fafc' }}
                                    itemStyle={{ color: '#22d3ee' }}
                                />
                                <Line
                                    type="monotone"
                                    dataKey="count"
                                    stroke="#22d3ee"
                                    strokeWidth={3}
                                    dot={{ fill: '#0f172a', stroke: '#22d3ee', strokeWidth: 2, r: 4 }}
                                    activeDot={{ r: 6, fill: '#22d3ee' }}
                                />
                            </LineChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                {/* Mission Performance */}
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <div className="flex items-center gap-3 mb-6">
                        <Target className="w-5 h-5 text-emerald-400" />
                        <h3 className="text-lg font-bold text-white font-orbitron">TOP MISSIONS</h3>
                    </div>
                    <div className="h-[300px] w-full overflow-y-auto pr-2 custom-scrollbar">
                        <div className="space-y-4">
                            {missionStats.map((mission, index) => (
                                <div key={index} className="bg-slate-950/50 p-4 rounded-lg border border-slate-800 flex items-center justify-between">
                                    <div>
                                        <h4 className="font-bold text-white text-sm mb-1">{mission.title}</h4>
                                        <div className="flex items-center gap-4 text-xs text-slate-400">
                                            <span>{mission.completions} completions</span>
                                        </div>
                                    </div>
                                    <div className="text-right">
                                        <div className="text-emerald-400 font-mono font-bold">{mission.avg_score}%</div>
                                        <div className="text-[10px] text-slate-500">AVG SCORE</div>
                                    </div>
                                </div>
                            ))}
                            {missionStats.length === 0 && (
                                <div className="text-center text-slate-500 py-10">No mission data available yet.</div>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
