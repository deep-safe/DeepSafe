'use client';

import { useState, useEffect } from 'react';
import { Trophy, Users, Calendar, Loader2, Sparkles, Crown } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { supabase } from '@/lib/supabase/client';
import { useSystemUI } from '@/context/SystemUIContext';

interface ReferralStats {
    referral_count: number;
    pro_months_earned: number;
    is_pro_active: boolean;
    pro_expires_at: string | null;
    pro_activated_at: string | null;
    referrals: Array<{
        referred_user_id: string;
        username: string | null;
        created_at: string;
    }>;
}

interface ProStatusCardProps {
    onProActivated?: () => void;
}

export function ProStatusCard({ onProActivated }: ProStatusCardProps) {
    const [stats, setStats] = useState<ReferralStats | null>(null);
    const [loading, setLoading] = useState(true);
    const [activating, setActivating] = useState(false);
    const { openModal } = useSystemUI();

    useEffect(() => {
        fetchReferralStats();
    }, []);

    const fetchReferralStats = async () => {
        try {
            setLoading(true);
            const { data, error } = await supabase.rpc('get_referral_stats');

            if (error) throw error;

            setStats(data as unknown as ReferralStats);
        } catch (error) {
            console.error('Error fetching referral stats:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleActivatePro = async () => {
        if (!stats) return;

        setActivating(true);
        try {
            const { data, error } = await supabase.rpc('activate_pro_subscription');

            if (error) throw error;

            const result = data as { success: boolean; message: string; expires_at?: string; months_activated?: number };

            if (result.success) {
                openModal({
                    title: '🎉 PRO ATTIVATO!',
                    message: `Hai attivato ${result.months_activated} mesi PRO! Il tuo abbonamento è valido fino al ${new Date(result.expires_at!).toLocaleDateString('it-IT')}`,
                    type: 'info'
                });

                // Refresh stats
                await fetchReferralStats();
                onProActivated?.();
            } else {
                openModal({
                    title: 'ERRORE',
                    message: result.message,
                    type: 'alert'
                });
            }
        } catch (error: any) {
            console.error('Error activating Pro:', error);
            openModal({
                title: 'ERRORE',
                message: error.message || 'Errore durante l\'attivazione PRO',
                type: 'alert'
            });
        } finally {
            setActivating(false);
        }
    };

    const canActivatePro = stats && stats.pro_months_earned > 0 && !stats.is_pro_active;
    const progressPercentage = stats ? (stats.pro_months_earned / 12) * 100 : 0;

    if (loading) {
        return (
            <div className="bg-black/40 border border-cyber-gray/30 rounded-xl p-6 flex items-center justify-center">
                <Loader2 className="w-6 h-6 text-cyber-blue animate-spin" />
            </div>
        );
    }

    if (!stats) return null;

    return (
        <div className="bg-gradient-to-br from-cyber-dark via-black to-cyber-dark border border-amber-500/30 rounded-2xl p-6 relative overflow-hidden">
            {/* Background Effects */}
            <div className="absolute top-0 right-0 w-40 h-40 bg-amber-500/10 blur-[80px] rounded-full pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-40 h-40 bg-purple-500/10 blur-[80px] rounded-full pointer-events-none" />

            {/* Scanner Line */}
            <div className="absolute top-0 left-0 w-full h-[1px] bg-gradient-to-r from-transparent via-amber-500 to-transparent opacity-50 animate-scan pointer-events-none" />

            <div className="relative z-10 space-y-6">
                {/* Header with PRO Badge */}
                <div className="flex items-center justify-between">
                    <h3 className="text-lg font-bold font-orbitron text-white uppercase tracking-widest flex items-center gap-2">
                        <Crown className="w-6 h-6 text-amber-500" />
                        Status PRO
                    </h3>

                    <AnimatePresence>
                        {stats.is_pro_active && (
                            <motion.div
                                initial={{ scale: 0, rotate: -180 }}
                                animate={{ scale: 1, rotate: 0 }}
                                exit={{ scale: 0, rotate: 180 }}
                                className="px-3 py-1 rounded-full bg-gradient-to-r from-amber-500 to-orange-500 border border-amber-400 shadow-[0_0_20px_rgba(251,191,36,0.4)]"
                            >
                                <span className="text-xs font-bold font-orbitron text-black uppercase tracking-wider flex items-center gap-1">
                                    <Sparkles className="w-3 h-3" />
                                    PRO ATTIVO
                                </span>
                            </motion.div>
                        )}
                    </AnimatePresence>
                </div>

                {/* Progress Section */}
                <div className="space-y-3">
                    <div className="flex items-center justify-between text-sm">
                        <span className="text-zinc-400 font-mono">Mesi Guadagnati</span>
                        <span className="text-cyber-blue font-bold font-orbitron text-lg">
                            {stats.pro_months_earned} / 12
                        </span>
                    </div>

                    {/* Progress Bar */}
                    <div className="relative h-3 bg-black/60 rounded-full border border-cyber-gray/30 overflow-hidden">
                        <motion.div
                            initial={{ width: 0 }}
                            animate={{ width: `${progressPercentage}%` }}
                            transition={{ duration: 1, ease: "easeOut" }}
                            className="absolute inset-y-0 left-0 bg-gradient-to-r from-amber-500 via-orange-500 to-amber-600 shadow-[0_0_10px_rgba(251,191,36,0.5)]"
                        />
                        {/* Segments */}
                        <div className="absolute inset-0 flex">
                            {Array.from({ length: 11 }).map((_, i) => (
                                <div
                                    key={i}
                                    className="flex-1 border-r border-black/40"
                                    style={{ marginLeft: i === 0 ? '8.33%' : '0' }}
                                />
                            ))}
                        </div>
                    </div>
                </div>

                {/* Stats Grid */}
                <div className="grid grid-cols-2 gap-4">
                    {/* Friends Invited */}
                    <div className="bg-black/40 backdrop-blur-sm border border-cyber-blue/20 rounded-lg p-4 space-y-2">
                        <div className="flex items-center gap-2 text-cyber-blue">
                            <Users className="w-4 h-4" />
                            <span className="text-xs font-mono uppercase tracking-wider">Amici Invitati</span>
                        </div>
                        <div className="text-2xl font-bold font-orbitron text-white">
                            {stats.referral_count} / 12
                        </div>
                    </div>

                    {/* Expiration Date */}
                    <div className="bg-black/40 backdrop-blur-sm border border-amber-500/20 rounded-lg p-4 space-y-2">
                        <div className="flex items-center gap-2 text-amber-500">
                            <Calendar className="w-4 h-4" />
                            <span className="text-xs font-mono uppercase tracking-wider">Scadenza</span>
                        </div>
                        <div className="text-md font-bold font-orbitron text-white">
                            {stats.is_pro_active && stats.pro_expires_at ? (
                                new Date(stats.pro_expires_at).toLocaleDateString('it-IT', {
                                    day: '2-digit',
                                    month: 'short',
                                    year: 'numeric'
                                })
                            ) : (
                                <span className="text-zinc-600">Non attivo</span>
                            )}
                        </div>
                    </div>
                </div>

                {/* Activate Pro Button */}
                <AnimatePresence>
                    {canActivatePro && (
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            exit={{ opacity: 0, y: -20 }}
                            className="relative group/btn"
                        >
                            {/* Glow Effect */}
                            <div className="absolute -inset-0.5 bg-gradient-to-r from-amber-500 to-orange-500 rounded-lg blur opacity-60 group-hover/btn:opacity-100 transition duration-500 animate-pulse" />

                            <button
                                onClick={handleActivatePro}
                                disabled={activating}
                                className="relative w-full py-4 rounded-lg bg-gradient-to-r from-amber-600 to-orange-600 border border-amber-400 text-white font-bold font-orbitron tracking-widest hover:from-amber-500 hover:to-orange-500 transition-all flex items-center justify-center gap-2 shadow-[0_0_20px_rgba(251,191,36,0.4)] disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                {activating ? (
                                    <>
                                        <Loader2 className="w-5 h-5 animate-spin" />
                                        <span>ATTIVAZIONE...</span>
                                    </>
                                ) : (
                                    <>
                                        <Crown className="w-5 h-5" />
                                        <span>ATTIVA PRO ({stats.pro_months_earned} MES{stats.pro_months_earned > 1 ? 'I' : 'E'})</span>
                                    </>
                                )}
                            </button>
                        </motion.div>
                    )}
                </AnimatePresence>

                {/* Referral History */}
                {stats.referrals && stats.referrals.length > 0 && (
                    <div className="space-y-3 pt-4 border-t border-cyber-gray/20">
                        <h4 className="text-sm font-bold font-orbitron text-zinc-400 uppercase tracking-wider flex items-center gap-2">
                            <Trophy className="w-4 h-4" />
                            Ultimi Inviti
                        </h4>

                        <div className="space-y-2 max-h-40 overflow-y-auto custom-scrollbar">
                            {stats.referrals.slice(0, 5).map((referral, index) => (
                                <div
                                    key={referral.referred_user_id}
                                    className="flex items-center justify-between p-3 bg-black/40 backdrop-blur-sm border border-cyber-gray/20 rounded-lg hover:border-cyber-blue/30 transition-colors"
                                >
                                    <div className="flex items-center gap-3">
                                        <div className="w-8 h-8 rounded-full bg-cyber-blue/20 border border-cyber-blue/50 flex items-center justify-center">
                                            <span className="text-xs font-bold text-cyber-blue">#{index + 1}</span>
                                        </div>
                                        <span className="text-sm font-mono text-white">
                                            {referral.username || 'Utente'}
                                        </span>
                                    </div>
                                    <span className="text-xs text-zinc-500 font-mono">
                                        {new Date(referral.created_at).toLocaleDateString('it-IT', {
                                            day: '2-digit',
                                            month: 'short'
                                        })}
                                    </span>
                                </div>
                            ))}
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
}
