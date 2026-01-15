'use client';

import { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Search, UserPlus, Check, Loader2, Share2, Shield, Copy, Crown } from 'lucide-react';
import { supabase } from '@/lib/supabase/client';
import { Database } from '@/types/supabase';
import { useAvatars } from '@/hooks/useAvatars';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder';
// Client is already initialized

interface AddFriendModalProps {
    isOpen: boolean;
    onClose: () => void;
    currentUserId: string;
}

export function AddFriendModal({ isOpen, onClose, currentUserId }: AddFriendModalProps) {
    const [searchQuery, setSearchQuery] = useState('');
    const [searchResults, setSearchResults] = useState<any[]>([]);
    const [loading, setLoading] = useState(false);
    const [sentRequests, setSentRequests] = useState<Set<string>>(new Set());
    const [inviteCopied, setInviteCopied] = useState(false);
    const [referralCode, setReferralCode] = useState<string | null>(null); // NUOVO: codice referral utente
    const { avatars } = useAvatars();

    // NUOVO: Fetch referral code when modal opens
    useEffect(() => {
        if (isOpen && !referralCode) {
            supabase
                .from('profiles')
                .select('referral_code')
                .eq('id', currentUserId)
                .single()
                .then(({ data }) => {
                    if (data?.referral_code) {
                        setReferralCode(data.referral_code);
                    }
                });
        }
    }, [isOpen, referralCode, currentUserId]);

    const handleSearch = async () => {
        if (!searchQuery.trim()) return;
        setLoading(true);
        try {
            const { data, error } = await supabase
                .from('profiles')
                .select('id, username, avatar_url')
                .ilike('username', `%${searchQuery}%`)
                .neq('id', currentUserId)
                .limit(5);

            if (error) throw error;
            setSearchResults(data || []);
        } catch (err) {
            console.error('Error searching users:', err);
        } finally {
            setLoading(false);
        }
    };

    const sendRequest = async (friendId: string) => {
        try {
            const { error } = await supabase
                .from('friendships')
                .insert({ user_id: currentUserId, friend_id: friendId, status: 'pending' });

            if (error) throw error;

            setSentRequests(prev => new Set(prev).add(friendId));
        } catch (err) {
            console.error('Error sending request:', err);
            // Handle duplicate key error (already requested) gracefully if needed
        }
    };

    if (!isOpen) return null;

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                className="fixed inset-0 z-[100] flex items-center justify-center bg-black/80 backdrop-blur-sm p-4"
                onClick={onClose}
            >
                <motion.div
                    initial={{ scale: 0.9, y: 20 }}
                    animate={{ scale: 1, y: 0 }}
                    exit={{ scale: 0.9, y: 20 }}
                    className="bg-cyber-dark border border-cyber-blue/30 rounded-xl w-full max-w-md overflow-hidden shadow-[0_0_30px_rgba(69,162,158,0.2)]"
                    onClick={e => e.stopPropagation()}
                >
                    <div className="p-4 border-b border-white/10 flex justify-between items-center bg-black/40">
                        <h3 className="text-lg font-bold font-orbitron text-white tracking-wide">AGGIUNGI AGENTE</h3>
                        <button onClick={onClose} className="text-zinc-400 hover:text-white">
                            <X className="w-5 h-5" />
                        </button>
                    </div>

                    <div className="p-4 space-y-4">
                        <div className="flex gap-2">
                            <div className="relative flex-1">
                                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-zinc-500" />
                                <input
                                    type="text"
                                    placeholder="Cerca username..."
                                    value={searchQuery}
                                    onChange={(e) => setSearchQuery(e.target.value)}
                                    onKeyDown={(e) => e.key === 'Enter' && handleSearch()}
                                    className="w-full bg-black/20 border border-white/10 rounded-lg pl-10 pr-4 py-2 text-sm text-white focus:border-cyber-blue/50 focus:outline-none transition-colors"
                                />
                            </div>
                            <button
                                onClick={handleSearch}
                                disabled={loading}
                                className="bg-cyber-blue/20 text-cyber-blue border border-cyber-blue/50 px-4 py-2 rounded-lg font-bold text-sm hover:bg-cyber-blue/30 transition-colors disabled:opacity-50"
                            >
                                {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : 'CERCA'}
                            </button>
                        </div>

                        <div className="space-y-2 max-h-[80vh] overflow-y-auto custom-scrollbar">
                            {searchResults.map(user => {
                                // Resolve Avatar
                                const avatarDef = avatars.find(a => a.id === user.avatar_url);
                                const avatarSrc = avatarDef?.src || '/avatars/rookie.png';

                                return (
                                    <div key={user.id} className="flex items-center justify-between p-3 bg-white/5 rounded-lg border border-white/5">
                                        <div className="flex items-center gap-3">
                                            <div className="w-8 h-8 rounded-full bg-black border border-white/10 overflow-hidden">
                                                <img
                                                    src={avatarSrc}
                                                    alt={user.username}
                                                    className="w-full h-full object-cover"
                                                    onError={(e) => {
                                                        (e.target as HTMLImageElement).src = '/avatars/rookie.png';
                                                    }}
                                                />
                                            </div>
                                            <span className="text-sm font-bold text-zinc-200">{user.username}</span>
                                        </div>
                                        <button
                                            onClick={() => sendRequest(user.id)}
                                            disabled={sentRequests.has(user.id)}
                                            className={`p-2 rounded-lg transition-colors ${sentRequests.has(user.id)
                                                ? 'bg-green-500/20 text-green-500'
                                                : 'bg-cyber-blue/10 text-cyber-blue hover:bg-cyber-blue/20'
                                                }`}
                                        >
                                            {sentRequests.has(user.id) ? <Check className="w-4 h-4" /> : <UserPlus className="w-4 h-4" />}
                                        </button>
                                    </div>
                                );
                            })}
                            {searchResults.length === 0 && searchQuery && !loading && (
                                <div className="text-center py-6 space-y-4">
                                    <p className="text-zinc-400 text-sm">
                                        Nessun agente trovato con questo nome.
                                    </p>
                                    <p className="text-xs text-zinc-500 mb-2">
                                        Il tuo amico non è ancora su DeepSafe?
                                    </p>

                                    {/* Invite Section - Direct Show */}
                                    <div className="bg-gradient-to-br from-cyber-blue/5 to-purple-500/5 border border-cyber-blue/20 rounded-xl p-4 space-y-4">
                                        <div className="space-y-2">
                                            <div className="flex items-center justify-center gap-2 text-cyber-blue">
                                                <Crown className="w-5 h-5" />
                                                <p className="text-sm font-bold font-orbitron">INVITA E GUADAGNA</p>
                                            </div>

                                            {/* Referral Code Display */}
                                            <div className="bg-black/40 border border-amber-500/30 rounded-lg p-4 relative overflow-hidden">
                                                {/* Animated glow */}
                                                <div className="absolute inset-0 bg-gradient-to-r from-transparent via-amber-500/10 to-transparent animate-pulse" />

                                                <div className="relative text-center">
                                                    <p className="text-3xl font-bold font-mono text-amber-400 tracking-[0.3em] text-glow select-all">
                                                        {referralCode || 'LOADING...'}
                                                    </p>
                                                </div>
                                            </div>

                                            {/* Rewards Info */}
                                            <div className="grid grid-cols-2 gap-2 text-[10px]">
                                                <div className="bg-red-500/10 border border-red-500/30 rounded p-2 text-center">
                                                    <p className="text-red-400 font-bold">+10 ❤️</p>
                                                    <p className="text-zinc-500">Per Entrambi</p>
                                                </div>
                                                <div className="bg-amber-500/10 border border-amber-500/30 rounded p-2 text-center">
                                                    <p className="text-amber-400 font-bold">+1 Mese PRO</p>
                                                    <p className="text-zinc-500">Per Te</p>
                                                </div>
                                            </div>
                                        </div>

                                        {/* Action Buttons */}
                                        <div className="flex gap-2">
                                            <button
                                                onClick={() => {
                                                    if (referralCode) {
                                                        navigator.clipboard.writeText(referralCode);
                                                        setInviteCopied(true);
                                                        setTimeout(() => setInviteCopied(false), 2000);
                                                    }
                                                }}
                                                className="flex-1 flex items-center justify-center gap-2 bg-cyber-blue/10 border border-cyber-blue/30 px-3 py-2 rounded-lg text-cyber-blue text-xs font-bold hover:bg-cyber-blue/20 transition-all font-mono"
                                            >
                                                {inviteCopied ? <Check className="w-3 h-3" /> : <Copy className="w-3 h-3" />}
                                                {inviteCopied ? 'COPIATO!' : 'COPIA'}
                                            </button>
                                            <button
                                                onClick={() => {
                                                    if (referralCode && navigator.share) {
                                                        navigator.share({
                                                            title: 'Unisciti a DeepSafe!',
                                                            text: `Usa il mio codice invito ${referralCode} per ottenere +10 cuori gratis! 🎁`,
                                                            url: window.location.origin + '/login'
                                                        });
                                                    } else if (referralCode) {
                                                        navigator.clipboard.writeText(`Usa il mio codice invito ${referralCode} su ${window.location.origin}/login per ottenere +10 cuori gratis!`);
                                                        setInviteCopied(true);
                                                        setTimeout(() => setInviteCopied(false), 2000);
                                                    }
                                                }}
                                                className="flex-1 flex items-center justify-center gap-2 bg-purple-500/10 border border-purple-500/30 px-3 py-2 rounded-lg text-purple-400 text-xs font-bold hover:bg-purple-500/20 transition-all font-mono"
                                            >
                                                <Share2 className="w-3 h-3" />
                                                CONDIVIDI
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            )}
                        </div>
                    </div>
                </motion.div>
            </motion.div>
        </AnimatePresence>
    );
}
