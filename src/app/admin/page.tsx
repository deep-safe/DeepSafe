'use client';

import React, { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase/client';
import { Database } from '@/types/supabase';
import { useRouter } from 'next/navigation';
import { Shield, Users, Coins, Search, Save, Ban, RefreshCw, Crown, Package, Medal, Zap, Trash2, Plus, X, ShoppingCart, BookOpen, Activity, MessageSquare, Map as MapIcon } from 'lucide-react';
import { BADGES_DATA } from '@/data/badgesData';
import { GiftModal } from '@/components/admin/GiftModal';
import { ConfirmationModal } from '@/components/admin/ConfirmationModal';
import { Gift } from 'lucide-react';

// Initialize Supabase Client
// Client is already initialized

type Profile = Database['public']['Tables']['profiles']['Row'];

const INVENTORY_ITEMS = [
    { id: 'streak_freeze', name: 'Streak Freeze', icon: '❄️' },
    { id: 'system_reboot', name: 'System Reboot', icon: '🔄' },
];

export default function AdminPage() {
    const router = useRouter();
    const [isLoading, setIsLoading] = useState(true);
    const [users, setUsers] = useState<Profile[]>([]);
    const [filteredUsers, setFilteredUsers] = useState<Profile[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [editingId, setEditingId] = useState<string | null>(null);
    const [editForm, setEditForm] = useState<Partial<Profile>>({});

    // Modal States
    const [activeModal, setActiveModal] = useState<'inventory' | 'badges' | 'gift' | null>(null);
    const [selectedUser, setSelectedUser] = useState<Profile | null>(null);
    const [confirmationModal, setConfirmationModal] = useState<{
        isOpen: boolean;
        title: string;
        message: string;
        onConfirm: () => void;
        variant?: 'info' | 'danger' | 'warning' | 'success';
        confirmText?: string;
    }>({
        isOpen: false,
        title: '',
        message: '',
        onConfirm: () => { },
    });

    const closeConfirmation = () => {
        setConfirmationModal(prev => ({ ...prev, isOpen: false }));
    };

    const askConfirmation = (
        title: string,
        message: string,
        onConfirm: () => void,
        variant: 'info' | 'danger' | 'warning' | 'success' = 'info',
        confirmText = 'Conferma'
    ) => {
        setConfirmationModal({
            isOpen: true,
            title,
            message,
            onConfirm: () => {
                onConfirm();
                closeConfirmation();
            },
            variant,
            confirmText
        });
    };

    // KPI Stats
    const totalUsers = users.length;
    const totalCredits = users.reduce((acc, user) => acc + (user.credits || 0), 0);
    const activeUsers = users.filter(u => u.last_login && new Date(u.last_login) > new Date(Date.now() - 86400000)).length;

    useEffect(() => {
        checkAdminAndFetchData();
    }, []);

    useEffect(() => {
        const lowerTerm = searchTerm.toLowerCase();
        setFilteredUsers(users.filter(user =>
            (user.username?.toLowerCase().includes(lowerTerm) || '') ||
            (user.id.toLowerCase().includes(lowerTerm))
        ));
    }, [searchTerm, users]);

    const checkAdminAndFetchData = async () => {
        setIsLoading(true);
        const { data: { user } } = await supabase.auth.getUser();

        if (!user) {
            router.push('/');
            return;
        }

        // Check if user is admin
        const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('is_admin')
            .eq('id', user.id)
            .single();



        if (!profile?.is_admin) {
            console.warn('Access Denied: User is not admin (DB check)');
            // router.push('/'); // DISABLED: Relying on Lock Screen for access control
            // return;
        }

        // Fetch all profiles
        const { data: allProfiles, error } = await supabase
            .from('profiles')
            .select('*')
            .order('updated_at', { ascending: false });

        if (error) {
            console.error('Error fetching users:', error);
        } else {
            setUsers(allProfiles || []);
        }
        setIsLoading(false);
    };

    const handleEdit = (user: Profile) => {
        setEditingId(user.id);
        setEditForm({
            credits: user.credits,
            highest_streak: user.highest_streak
        });
    };

    const handleSave = async (id: string) => {
        // Validation
        const credits = editForm.credits;
        const streak = editForm.highest_streak;

        if (typeof credits !== 'number' || isNaN(credits)) {
            alert('Invalid credits value');
            return;
        }
        if (typeof streak !== 'number' || isNaN(streak)) {
            alert('Invalid streak value');
            return;
        }

        askConfirmation(
            'Salva Modifiche',
            'Sei sicuro di voler salvare le modifiche a questo utente?',
            async () => {
                // Use the existing v2 RPC which we know exists, but now with safe validated inputs
                const { data, error } = await supabase.rpc('admin_update_profile_v2' as any, {
                    target_user_id: id,
                    new_credits: credits,
                    new_streak: streak
                });

                const response = data as any;

                if (error || (response && !response.success)) {
                    console.error('Update error details:', JSON.stringify(error || response, null, 2));
                    alert(`Error updating user: ${error?.message || response?.message || 'Unknown error'}`);
                } else {
                    // Update local state optimistically
                    setUsers(users.map(u => u.id === id ? { ...u, credits: credits, highest_streak: streak } : u));
                    setFilteredUsers(filteredUsers.map(u => u.id === id ? { ...u, credits: credits, highest_streak: streak } : u)); // Also update filtered list
                    setEditingId(null);
                }
            },
            'info',
            'Salva'
        );
    };

    const handleBan = async (id: string) => {
        askConfirmation(
            'Reset Utente',
            'Sei sicuro di voler resettare questo utente? Verranno azzerati TUTTI I VALORI!',
            async () => {
                // Hard Reset / Wipe Progress
                const { data, error } = await supabase.rpc('admin_reset_user' as any, {
                    target_user_id: id
                });

                const response = data as any;

                if (error || (response && !response.success)) {
                    console.error('Reset error:', error || response?.message);
                    alert(`Error resetting user: ${error?.message || response?.message}`);
                } else {
                    checkAdminAndFetchData();
                }
            },
            'warning',
            'RESET TOTALMENTE (WIPE)'
        );
    };

    const handleDeleteUser = async (id: string) => {
        askConfirmation(
            'ELIMINAZIONE DEFINITIVA',
            'ATTENZIONE: Stai per eliminare DEFINITIVAMENTE questo utente. Questa azione NON può essere annullata. Sei assolutamente sicuro?',
            async () => {
                try {
                    const response = await fetch(`/api/admin/users/delete?userId=${id}`, {
                        method: 'DELETE',
                    });

                    if (!response.ok) {
                        const data = await response.json();
                        throw new Error(data.error || 'Delete failed');
                    }

                    // Remove from local state
                    setUsers(users.filter(u => u.id !== id));
                    // alert('User deleted successfully.'); // Optional: maybe show a success toast or just update UI
                } catch (error: any) {
                    console.error('Delete error:', error);
                    alert(`Failed to delete user: ${error.message}`);
                }
            },
            'danger',
            'ELIMINA PER SEMPRE'
        );
    };

    const handleTogglePremium = async (user: Profile) => {
        const newStatus = !user.is_premium;
        askConfirmation(
            newStatus ? 'Attiva Premium' : 'Disattiva Premium',
            `Sei sicuro di voler ${newStatus ? 'attivare' : 'disattivare'} lo stato Premium per ${user.username}?`,
            async () => {
                const { data, error } = await supabase.rpc('admin_update_profile_v2' as any, {
                    target_user_id: user.id,
                    new_is_premium: newStatus
                });

                const response = data as any;

                if (error || (response && !response.success)) {
                    console.error('Premium toggle error:', error || response?.message);
                    alert(`Error updating premium status: ${error?.message || response?.message}`);
                } else {
                    setUsers(users.map(u => u.id === user.id ? { ...u, is_premium: newStatus } : u));
                }
            },
            'info',
            newStatus ? 'Attiva' : 'Disattiva'
        );
    };

    // --- Inventory Management ---
    const openInventoryModal = (user: Profile) => {
        setSelectedUser(user);
        setActiveModal('inventory');
    };

    const handleAddItem = async (itemId: string) => {
        if (!selectedUser) return;
        const currentInventory = (selectedUser.inventory as string[]) || [];
        const newInventory = [...currentInventory, itemId];

        const { data, error } = await supabase.rpc('admin_update_profile_v2' as any, {
            target_user_id: selectedUser.id,
            new_inventory: newInventory
        });

        const response = data as any;

        if (!error && (!response || response.success)) {
            updateLocalUser(selectedUser.id, { inventory: newInventory });
        } else {
            console.error('Add item error:', error || response?.message);
            alert(`Error adding item: ${error?.message || response?.message}`);
        }
    };

    const handleRemoveItem = async (index: number) => {
        if (!selectedUser) return;
        const currentInventory = (selectedUser.inventory as string[]) || [];
        const newInventory = [...currentInventory];
        newInventory.splice(index, 1);

        const { data, error } = await supabase.rpc('admin_update_profile_v2' as any, {
            target_user_id: selectedUser.id,
            new_inventory: newInventory
        });

        const response = data as any;

        if (!error && (!response || response.success)) {
            updateLocalUser(selectedUser.id, { inventory: newInventory });
        } else {
            console.error('Remove item error:', error || response?.message);
            alert(`Error removing item: ${error?.message || response?.message}`);
        }
    };

    // --- Badge Management ---
    const openBadgeModal = (user: Profile) => {
        setSelectedUser(user);
        setActiveModal('badges');
    };

    const handleToggleBadge = async (badgeId: string) => {
        if (!selectedUser) return;
        const currentBadges = (selectedUser.earned_badges as any[]) || [];
        const hasBadge = currentBadges.some(b => b.id === badgeId);

        let newBadges;
        if (hasBadge) {
            newBadges = currentBadges.filter(b => b.id !== badgeId);
        } else {
            newBadges = [...currentBadges, { id: badgeId, earned_at: new Date().toISOString() }];
        }

        const { data, error } = await supabase.rpc('admin_update_profile_v2' as any, {
            target_user_id: selectedUser.id,
            new_earned_badges: newBadges
        });

        const response = data as any;

        if (!error && (!response || response.success)) {
            updateLocalUser(selectedUser.id, { earned_badges: newBadges });
        } else {
            console.error('Toggle badge error:', error || response?.message);
            alert(`Error toggling badge: ${error?.message || response?.message}`);
        }
    };

    const updateLocalUser = (userId: string, updates: Partial<Profile>) => {
        setUsers(users.map(u => u.id === userId ? { ...u, ...updates } : u));
        if (selectedUser && selectedUser.id === userId) {
            setSelectedUser({ ...selectedUser, ...updates });
        }
    };

    // --- System Actions ---




    if (isLoading) {
        return <div className="min-h-screen bg-black flex items-center justify-center text-cyan-500 font-mono">INITIALIZING GOD MODE...</div>;
    }

    return (
        <div className="min-h-screen bg-slate-950 text-slate-200 font-sans selection:bg-cyan-500/30 p-8">

            {/* Header */}
            <header className="flex items-center justify-between mb-8 border-b border-slate-800 pb-4">
                <div className="flex items-center gap-4">
                    <Shield className="w-10 h-10 text-cyan-500" />
                    <div>
                        <h1 className="text-3xl font-bold text-white font-orbitron tracking-wider">GOD MODE</h1>
                        <p className="text-slate-500 font-mono text-sm">SYSTEM ADMINISTRATION CONSOLE</p>
                    </div>
                </div>
                <div className="flex gap-2 items-center">
                    <button
                        onClick={checkAdminAndFetchData}
                        className="p-2 bg-slate-900 border border-slate-700 rounded hover:bg-slate-800 transition-colors"
                        title="Refresh Data"
                    >
                        <RefreshCw className="w-5 h-5 text-cyan-500" />
                    </button>

                    <div className="w-px h-8 bg-slate-800 mx-2" />

                    <button
                        onClick={() => router.push('/admin/dev')}
                        className="p-2 bg-slate-900 border border-slate-700 rounded hover:bg-slate-800 transition-colors group relative"
                        title="Dev Console"
                    >
                        <div className="absolute -top-1 -right-1 w-2 h-2 bg-red-500 rounded-full animate-pulse" />
                        <code className="text-xs font-bold text-slate-400 group-hover:text-green-400 transition-colors">DEV</code>
                    </button>
                </div>
            </header>

            {/* Control Panel Grid */}
            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-7 gap-4 mb-8">
                <button
                    onClick={() => router.push('/admin/badges')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-purple-900/20 hover:border-purple-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-purple-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <Medal className="w-6 h-6 text-purple-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-purple-300 font-mono">BADGES</span>
                </button>

                <button
                    onClick={() => router.push('/admin/shop')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-yellow-900/20 hover:border-yellow-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-yellow-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <ShoppingCart className="w-6 h-6 text-yellow-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-yellow-300 font-mono">SHOP</span>
                </button>

                <button
                    onClick={() => router.push('/admin/avatars')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-pink-900/20 hover:border-pink-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-pink-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <Users className="w-6 h-6 text-pink-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-pink-300 font-mono">AVATARS</span>
                </button>

                <button
                    onClick={() => router.push('/admin/missions')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-cyan-900/20 hover:border-cyan-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-cyan-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <BookOpen className="w-6 h-6 text-cyan-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-cyan-300 font-mono">MISSIONS</span>
                </button>

                <button
                    onClick={() => router.push('/admin/analytics')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-emerald-900/20 hover:border-emerald-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-emerald-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <Activity className="w-6 h-6 text-emerald-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-emerald-300 font-mono">ANALYTICS</span>
                </button>

                <button
                    onClick={() => router.push('/admin/feedback')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-blue-900/20 hover:border-blue-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-blue-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <MessageSquare className="w-6 h-6 text-blue-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-blue-300 font-mono">FEEDBACK</span>
                </button>

                <button
                    onClick={() => router.push('/admin/regions')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-teal-900/20 hover:border-teal-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-teal-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <MapIcon className="w-6 h-6 text-teal-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-teal-300 font-mono">REGIONS</span>
                </button>

                <button
                    onClick={() => setActiveModal('gift')}
                    className="p-4 bg-slate-900/50 border border-slate-800 rounded-xl hover:bg-indigo-900/20 hover:border-indigo-500/50 transition-all group flex flex-col items-center gap-3"
                >
                    <div className="p-3 bg-indigo-900/20 rounded-full group-hover:scale-110 transition-transform">
                        <Gift className="w-6 h-6 text-indigo-400" />
                    </div>
                    <span className="text-xs font-bold text-slate-400 group-hover:text-indigo-300 font-mono">SEND GIFT</span>
                </button>
            </div>

            {/* KPI Cards */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <div className="flex items-center gap-3 mb-2">
                        <Users className="w-5 h-5 text-blue-400" />
                        <span className="text-slate-400 font-mono text-sm">TOTAL USERS</span>
                    </div>
                    <div className="text-3xl font-bold text-white font-orbitron">{totalUsers}</div>
                </div>
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <div className="flex items-center gap-3 mb-2">
                        <Coins className="w-5 h-5 text-yellow-400" />
                        <span className="text-slate-400 font-mono text-sm">TOTAL CREDITS</span>
                    </div>
                    <div className="text-3xl font-bold text-white font-orbitron">{totalCredits.toLocaleString()}</div>
                </div>
                <div className="bg-slate-900/50 border border-slate-800 p-6 rounded-xl">
                    <div className="flex items-center gap-3 mb-2">
                        <Shield className="w-5 h-5 text-green-400" />
                        <span className="text-slate-400 font-mono text-sm">ACTIVE (24H)</span>
                    </div>
                    <div className="text-3xl font-bold text-white font-orbitron">{activeUsers}</div>
                </div>
            </div>


            {/* User Database - Minimal & Functional */}
            <div className="mt-12 mb-4 flex items-center justify-between">
                <h2 className="text-xl font-bold text-white font-orbitron tracking-wider flex items-center gap-2">
                    <Users className="w-5 h-5 text-cyan-500" />
                    USER DATABASE
                </h2>

                <div className="relative group">
                    <Search className="w-4 h-4 text-slate-500 absolute left-3 top-1/2 -translate-y-1/2 group-focus-within:text-cyan-500 transition-colors" />
                    <input
                        type="text"
                        placeholder="Search UUID or Username..."
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className="bg-slate-900/50 border border-slate-800 rounded-full pl-10 pr-4 py-2 text-sm text-slate-300 placeholder:text-slate-600 focus:outline-none focus:border-cyan-500/50 focus:bg-slate-900 transition-all w-64 hover:border-slate-700"
                    />
                </div>
            </div>

            <div className="overflow-hidden rounded-xl border border-slate-800/50 bg-slate-900/20 backdrop-blur-sm">
                <table className="w-full text-left border-collapse">
                    <thead>
                        <tr className="border-b border-slate-800/50 text-xs font-mono text-slate-500 uppercase tracking-widest">
                            <th className="p-4 pl-6 font-medium">User Details</th>
                            <th className="p-4 font-medium text-center">Status</th>
                            <th className="p-4 font-medium text-right">Credits</th>
                            <th className="p-4 font-medium text-right">Streak</th>
                            <th className="p-4 font-medium text-right">Last Login</th>
                            <th className="p-4 pr-6 font-medium text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-800/30 text-sm">
                        {filteredUsers.map(user => (
                            <tr key={user.id} className="group hover:bg-white/[0.02] transition-colors">
                                <td className="p-4 pl-6">
                                    <div className="flex flex-col">
                                        <div className="font-bold text-slate-200 flex items-center gap-2 group-hover:text-cyan-400 transition-colors">
                                            {user.username || 'Anonymous'}
                                            {user.is_admin && <Shield className="w-3 h-3 text-cyan-500" />}
                                        </div>
                                        <div className="text-[10px] text-slate-600 font-mono tracking-tight group-hover:text-slate-500 transition-colors">
                                            {user.id}
                                        </div>
                                    </div>
                                </td>
                                <td className="p-4 text-center">
                                    <button
                                        onClick={() => handleTogglePremium(user)}
                                        className={`p-1.5 rounded-lg transition-all ${user.is_premium
                                            ? 'bg-amber-500/10 text-amber-500 border border-amber-500/20 shadow-[0_0_10px_rgba(245,158,11,0.1)]'
                                            : 'bg-slate-800/50 text-slate-600 border border-slate-700/50 hover:bg-slate-800 hover:text-slate-400'
                                            }`}
                                        title={user.is_premium ? "Premium Active" : "No Premium"}
                                    >
                                        <Crown className="w-4 h-4" />
                                    </button>
                                </td>

                                <td className="p-4 text-right font-mono">
                                    {editingId === user.id ? (
                                        <input
                                            type="number"
                                            value={editForm.credits || 0}
                                            onChange={(e) => setEditForm({ ...editForm, credits: parseInt(e.target.value) })}
                                            className="bg-slate-950 border border-cyan-500/50 rounded px-2 py-1 w-20 text-right outline-none text-cyan-400"
                                            autoFocus
                                        />
                                    ) : (
                                        <span className="text-yellow-500/90 font-medium group-hover:text-yellow-400 transition-colors">
                                            {user.credits?.toLocaleString()}
                                            <span className="text-yellow-500/50 text-xs ml-1">NC</span>
                                        </span>
                                    )}
                                </td>

                                <td className="p-4 text-right font-mono">
                                    {editingId === user.id ? (
                                        <input
                                            type="number"
                                            value={editForm.highest_streak || 0}
                                            onChange={(e) => setEditForm({ ...editForm, highest_streak: parseInt(e.target.value) })}
                                            className="bg-slate-950 border border-cyan-500/50 rounded px-2 py-1 w-16 text-right outline-none text-cyan-400"
                                        />
                                    ) : (
                                        <span className={`font-medium group-hover:brightness-125 transition-colors ${(user.highest_streak || 0) > 0 ? 'text-orange-500' : 'text-slate-600'
                                            }`}>
                                            {user.highest_streak} <span className="text-sm">🔥</span>
                                        </span>
                                    )}
                                </td>

                                <td className="p-4 text-right text-slate-500 font-mono text-xs">
                                    {user.last_login
                                        ? <span>{new Date(user.last_login).toLocaleDateString()}</span>
                                        : <span className="opacity-30">Never</span>
                                    }
                                </td>

                                <td className="p-4 pr-6 text-right">
                                    {editingId === user.id ? (
                                        <div className="flex justify-end gap-2">
                                            <button onClick={() => handleSave(user.id)} className="p-1.5 bg-green-500/20 text-green-400 rounded-md hover:bg-green-500/30 transition-colors">
                                                <Save className="w-4 h-4" />
                                            </button>
                                            <button onClick={() => setEditingId(null)} className="p-1.5 bg-slate-800 text-slate-400 rounded-md hover:bg-slate-700 transition-colors">
                                                <X className="w-4 h-4" />
                                            </button>
                                        </div>
                                    ) : (
                                        <div className="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity duration-200">
                                            <button onClick={() => openInventoryModal(user)} className="p-2 hover:bg-blue-500/10 rounded-md text-slate-500 hover:text-blue-400 transition-colors" title="Inventory">
                                                <Package className="w-4 h-4" />
                                            </button>
                                            <button onClick={() => openBadgeModal(user)} className="p-2 hover:bg-purple-500/10 rounded-md text-slate-500 hover:text-purple-400 transition-colors" title="Badges">
                                                <Medal className="w-4 h-4" />
                                            </button>

                                            <div className="w-px h-4 bg-slate-800 mx-1 self-center" />

                                            <button onClick={() => handleEdit(user)} className="p-2 hover:bg-cyan-500/10 rounded-md text-slate-500 hover:text-cyan-400 transition-colors" title="Quick Edit">
                                                <Zap className="w-4 h-4" />
                                            </button>

                                            <button onClick={() => handleBan(user.id)} className="p-2 hover:bg-orange-500/10 rounded-md text-slate-500 hover:text-orange-500 transition-colors" title="Reset (Soft Ban)">
                                                <Ban className="w-4 h-4" />
                                            </button>

                                            <button onClick={() => handleDeleteUser(user.id)} className="p-2 hover:bg-red-500/10 rounded-md text-slate-500 hover:text-red-500 transition-colors" title="DELETE PERMANENTLY">
                                                <Trash2 className="w-4 h-4" />
                                            </button>
                                        </div>
                                    )}
                                </td>
                            </tr>
                        ))}

                        {filteredUsers.length === 0 && (
                            <tr>
                                <td colSpan={6} className="p-12 text-center text-slate-600 font-mono">
                                    NO USERS FOUND
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </div>

            {/* Inventory Modal */}
            {activeModal === 'inventory' && selectedUser && (
                <div className="fixed inset-0 bg-black/80 backdrop-blur-sm flex items-center justify-center z-50 p-4">
                    <div className="bg-slate-900 border border-slate-700 rounded-xl w-full max-w-lg overflow-hidden shadow-2xl">
                        <div className="p-4 border-b border-slate-800 flex justify-between items-center bg-slate-800/50">
                            <h3 className="font-orbitron font-bold text-white flex items-center gap-2">
                                <Package className="w-5 h-5 text-blue-400" />
                                INVENTORY: {selectedUser.username}
                            </h3>
                            <button onClick={() => setActiveModal(null)} className="text-slate-400 hover:text-white"><X className="w-5 h-5" /></button>
                        </div>
                        <div className="p-6">
                            <div className="mb-6">
                                <h4 className="text-xs font-mono text-slate-500 mb-2 uppercase">Current Items</h4>
                                <div className="flex flex-wrap gap-2">
                                    {((selectedUser.inventory as string[]) || []).length === 0 && <span className="text-slate-600 italic">Empty inventory</span>}
                                    {((selectedUser.inventory as string[]) || []).map((itemId, idx) => (
                                        <div key={idx} className="bg-slate-800 border border-slate-700 px-3 py-1.5 rounded-full flex items-center gap-2 text-sm">
                                            <span>{INVENTORY_ITEMS.find(i => i.id === itemId)?.icon || '📦'}</span>
                                            <span>{INVENTORY_ITEMS.find(i => i.id === itemId)?.name || itemId}</span>
                                            <button onClick={() => handleRemoveItem(idx)} className="text-slate-500 hover:text-red-400 ml-1"><X className="w-3 h-3" /></button>
                                        </div>
                                    ))}
                                </div>
                            </div>
                            <div>
                                <h4 className="text-xs font-mono text-slate-500 mb-2 uppercase">Add Item</h4>
                                <div className="grid grid-cols-2 gap-2">
                                    {INVENTORY_ITEMS.map(item => (
                                        <button
                                            key={item.id}
                                            onClick={() => handleAddItem(item.id)}
                                            className="flex items-center gap-2 p-2 bg-slate-800/50 hover:bg-slate-800 border border-slate-700 rounded text-left transition-colors"
                                        >
                                            <span>{item.icon}</span>
                                            <span className="text-sm">{item.name}</span>
                                            <Plus className="w-4 h-4 ml-auto text-slate-500" />
                                        </button>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {/* Badge Modal */}
            {activeModal === 'badges' && selectedUser && (
                <div className="fixed inset-0 bg-black/80 backdrop-blur-sm flex items-center justify-center z-50 p-4">
                    <div className="bg-slate-900 border border-slate-700 rounded-xl w-full max-w-2xl overflow-hidden shadow-2xl max-h-[80vh] flex flex-col">
                        <div className="p-4 border-b border-slate-800 flex justify-between items-center bg-slate-800/50">
                            <h3 className="font-orbitron font-bold text-white flex items-center gap-2">
                                <Medal className="w-5 h-5 text-purple-400" />
                                BADGES: {selectedUser.username}
                            </h3>
                            <button onClick={() => setActiveModal(null)} className="text-slate-400 hover:text-white"><X className="w-5 h-5" /></button>
                        </div>
                        <div className="p-6 overflow-y-auto">
                            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                {BADGES_DATA.map(badge => {
                                    const isEarned = ((selectedUser.earned_badges as any[]) || []).some(b => b.id === badge.id);
                                    return (
                                        <div
                                            key={badge.id}
                                            onClick={() => handleToggleBadge(badge.id)}
                                            className={`p-3 border rounded-lg flex items-center gap-3 cursor-pointer transition-all ${isEarned
                                                ? 'bg-purple-900/20 border-purple-500/50'
                                                : 'bg-slate-900/50 border-slate-800 opacity-60 hover:opacity-100 hover:border-slate-600'
                                                }`}
                                        >
                                            <div className="text-2xl">{badge.icon}</div>
                                            <div className="flex-1">
                                                <div className={`font-bold text-sm ${isEarned ? 'text-white' : 'text-slate-400'}`}>{badge.name}</div>
                                                <div className="text-xs text-slate-500">{badge.category}</div>
                                            </div>
                                            {isEarned && <div className="text-purple-400"><Zap className="w-4 h-4 fill-current" /></div>}
                                        </div>
                                    );
                                })}
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {/* Gift Modal */}
            <GiftModal
                isOpen={activeModal === 'gift'}
                onClose={() => setActiveModal(null)}
                users={users}
                currentAdminId="" // Not strictly needed for logic as we use auth.uid() in RLS/RPC, but good for prop
            />

            {/* Confirmation Modal */}
            <ConfirmationModal
                isOpen={confirmationModal.isOpen}
                onClose={closeConfirmation}
                onConfirm={confirmationModal.onConfirm}
                title={confirmationModal.title}
                message={confirmationModal.message}
                variant={confirmationModal.variant}
                confirmText={confirmationModal.confirmText}
            />
        </div>
    );
}
