'use client';

import React, { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase/client';
import { useRouter } from 'next/navigation';
import { ArrowLeft, Users, Trophy, TrendingUp, RefreshCw, Share2, Crown } from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Cell } from 'recharts';

interface AdminReferralStats {
    total_referrals: number;
    total_pro_months_distributed: number;
    top_referrers: Array<{
        username: string;
        count: number;
        pro_months_earned: number;
    }>;
    daily_growth: Array<{
        date: string;
        count: number;
    }>;
}

const COLORS = ['#22d3ee', '#34d399', '#f472b6', '#a78bfa', '#fbbf24'];

export default function AdminReferralsPage() {
    const router = useRouter();
    const [isLoading, setIsLoading] = useState(true);
    const [stats, setStats] = useState<AdminReferralStats | null>(null);

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

        await fetchStats();
    };

    const fetchStats = async () => {
        setIsLoading(true);
        try {
            const { data, error } = await supabase.rpc('get_admin_referral_stats' as any);
            if (error) {
                console.error('Error fetching referral stats:', error);
            } else {
                setStats(data as unknown as AdminReferralStats);
            }
        } catch (err) {
            console.error('Unexpected error:', err);
        } finally {
            setIsLoading(false);
        }
    };

    if (isLoading) return <div className="min-h-screen bg-black flex items-center justify-center text-cyan-500 font-mono">LOADING REFERRAL DATA...</div>;

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
                        <h1 className="text-3xl font-bold text-white font-orbitron flex items-center gap-2">
                            <Share2 className="w-8 h-8 text-cyan-500" />
                            REFERRAL ANALYTICS
                        </h1>
                        <p className="text-slate-400 text-sm font-mono">Tracking growth & rewards</p>
                    </div>
                </div>
                <button
                    onClick={fetchStats}
                    className="flex items-center gap-2 px-4 py-2 bg-slate-900 border border-slate-700 hover:bg-cyan-950/30 hover:border-cyan-500/50 text-cyan-400 rounded-lg transition-colors font-mono text-sm"
                >
                    <RefreshCw className="w-4 h-4" />
                    REFRESH
                </button>
            </header>

            {/* KPI Cards */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-cyan-500/5 rounded-full filter blur-3xl -translate-y-1/2 translate-x-1/2" />
                    <div className="flex items-center gap-3 mb-2">
                        <Users className="w-5 h-5 text-cyan-400" />
                        <span className="text-slate-400 font-mono text-sm uppercase">Total Invites</span>
                    </div>
                    <div className="text-4xl font-bold text-white font-orbitron">{stats?.total_referrals || 0}</div>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-amber-500/5 rounded-full filter blur-3xl -translate-y-1/2 translate-x-1/2" />
                    <div className="flex items-center gap-3 mb-2">
                        <Crown className="w-5 h-5 text-amber-500" />
                        <span className="text-slate-400 font-mono text-sm uppercase">Pro Months Given</span>
                    </div>
                    <div className="text-4xl font-bold text-white font-orbitron">{stats?.total_pro_months_distributed || 0}</div>
                    <div className="text-xs text-slate-500 mt-2 font-mono">Approx. Value: €{(stats?.total_pro_months_distributed || 0) * 4.99}</div>
                </div>

                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl relative overflow-hidden">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-emerald-500/5 rounded-full filter blur-3xl -translate-y-1/2 translate-x-1/2" />
                    <div className="flex items-center gap-3 mb-2">
                        <TrendingUp className="w-5 h-5 text-emerald-400" />
                        <span className="text-slate-400 font-mono text-sm uppercase">Top Referrer</span>
                    </div>
                    <div className="text-2xl font-bold text-white font-orbitron truncate">
                        {stats?.top_referrers?.[0]?.username || 'N/A'}
                    </div>
                    <div className="text-xs text-emerald-400 mt-2 font-mono flex items-center gap-1">
                        {stats?.top_referrers?.[0]?.count || 0} Invites
                    </div>
                </div>
            </div>

            {/* Charts Section */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
                {/* Growth Chart */}
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <h3 className="text-lg font-bold text-white font-orbitron mb-6 flex items-center gap-2">
                        <TrendingUp className="w-5 h-5 text-cyan-400" />
                        REFERRAL GROWTH (30 DAYS)
                    </h3>
                    <div className="h-[300px] w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <LineChart data={stats?.daily_growth || []}>
                                <CartesianGrid strokeDasharray="3 3" stroke="#334155" vertical={false} />
                                <XAxis
                                    dataKey="date"
                                    stroke="#94a3b8"
                                    tick={{ fontSize: 12 }}
                                    tickFormatter={(value) => new Date(value).toLocaleDateString(undefined, { day: '2-digit', month: '2-digit' })}
                                />
                                <YAxis stroke="#94a3b8" tick={{ fontSize: 12 }} allowDecimals={false} />
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

                {/* Top Referrers Bar Chart */}
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <h3 className="text-lg font-bold text-white font-orbitron mb-6 flex items-center gap-2">
                        <Trophy className="w-5 h-5 text-amber-500" />
                        TOP REFERRERS
                    </h3>
                    <div className="h-[300px] w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <BarChart data={stats?.top_referrers?.slice(0, 5) || []} layout="vertical">
                                <CartesianGrid strokeDasharray="3 3" stroke="#334155" horizontal={false} />
                                <XAxis type="number" stroke="#94a3b8" tick={{ fontSize: 12 }} allowDecimals={false} />
                                <YAxis
                                    dataKey="username"
                                    type="category"
                                    stroke="#94a3b8"
                                    tick={{ fontSize: 12 }}
                                    width={100}
                                />
                                <Tooltip
                                    cursor={{ fill: 'rgba(255,255,255,0.05)' }}
                                    contentStyle={{ backgroundColor: '#0f172a', borderColor: '#334155', color: '#f8fafc' }}
                                />
                                <Bar dataKey="count" radius={[0, 4, 4, 0]}>
                                    {(stats?.top_referrers?.slice(0, 5) || []).map((entry, index) => (
                                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                    ))}
                                </Bar>
                            </BarChart>
                        </ResponsiveContainer>
                    </div>
                </div>
            </div>

            {/* Detailed Leaderboard Table */}
            <div className="bg-slate-900/50 border border-slate-800 rounded-xl overflow-hidden">
                <div className="p-6 border-b border-slate-800">
                    <h3 className="text-lg font-bold text-white font-orbitron flex items-center gap-2">
                        <Users className="w-5 h-5 text-cyan-500" />
                        DETAILED LEADERBOARD
                    </h3>
                </div>
                <div className="overflow-x-auto">
                    <table className="w-full text-left">
                        <thead className="bg-slate-900/50 text-xs uppercase text-slate-500 font-mono">
                            <tr>
                                <th className="p-4 pl-6">Rank</th>
                                <th className="p-4">Agent</th>
                                <th className="p-4 text-right">Referrals</th>
                                <th className="p-4 text-right pr-6">Earned PRO</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-800/50">
                            {(stats?.top_referrers || []).map((user, index) => (
                                <tr key={index} className="hover:bg-white/[0.02] transition-colors">
                                    <td className="p-4 pl-6 font-mono text-slate-500">#{index + 1}</td>
                                    <td className="p-4 font-bold text-white">{user.username}</td>
                                    <td className="p-4 text-right font-mono text-cyan-400">{user.count}</td>
                                    <td className="p-4 text-right pr-6 font-mono text-amber-500">{user.pro_months_earned} Months</td>
                                </tr>
                            ))}
                            {(stats?.top_referrers || []).length === 0 && (
                                <tr>
                                    <td colSpan={4} className="p-8 text-center text-slate-500 text-sm font-mono">
                                        No referral data found.
                                    </td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
}
