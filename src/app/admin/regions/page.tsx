'use client';

import React, { useEffect, useState } from 'react';
import { createBrowserClient } from '@supabase/ssr';
import { Database } from '@/types/supabase';
import { useRouter } from 'next/navigation';
import { Map, Save, ArrowLeft, Search, RefreshCw, AlertTriangle } from 'lucide-react';
import { ConfirmationModal } from '@/components/admin/ConfirmationModal';

// Initialize Supabase Client
const supabase = createBrowserClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

type Region = Database['public']['Tables']['regions']['Row'];

export default function AdminRegionsPage() {
    const router = useRouter();
    const [isLoading, setIsLoading] = useState(true);
    const [regions, setRegions] = useState<Region[]>([]);
    const [filteredRegions, setFilteredRegions] = useState<Region[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [editingId, setEditingId] = useState<string | null>(null);
    const [editForm, setEditForm] = useState<Partial<Region>>({});

    // Confirmation Modal State
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

    useEffect(() => {
        fetchRegions();
    }, []);

    useEffect(() => {
        const lowerTerm = searchTerm.toLowerCase();
        setFilteredRegions(regions.filter(region =>
            region.id.toLowerCase().includes(lowerTerm)
        ));
    }, [searchTerm, regions]);

    const fetchRegions = async () => {
        setIsLoading(true);
        const { data, error } = await supabase
            .from('regions')
            .select('*')
            .order('id');

        if (error) {
            console.error('Error fetching regions:', error);
            alert('Failed to fetch regions');
        } else {
            setRegions(data || []);
        }
        setIsLoading(false);
    };

    const handleEdit = (region: Region) => {
        setEditingId(region.id);
        setEditForm({
            cost: region.cost,
            tier: region.tier
        });
    };

    const handleSave = async (id: string) => {
        askConfirmation(
            'Salva Modifiche',
            `Sei sicuro di voler aggiornare il costo per ${id}?`,
            async () => {
                const { error } = await supabase
                    .from('regions')
                    .update(editForm)
                    .eq('id', id);

                if (error) {
                    console.error('Error updating region:', error);
                    alert('Error updating region');
                } else {
                    setRegions(regions.map(r => r.id === id ? { ...r, ...editForm } : r));
                    setEditingId(null);
                }
            },
            'info',
            'Salva'
        );
    };

    const handleCancelEdit = () => {
        setEditingId(null);
        setEditForm({});
    };

    if (isLoading) {
        return <div className="min-h-screen bg-slate-950 flex items-center justify-center text-cyan-500 font-mono">LOADING REGIONS...</div>;
    }

    return (
        <div className="min-h-screen bg-slate-950 text-slate-200 font-sans selection:bg-cyan-500/30 p-8">
            {/* Header */}
            <header className="flex items-center justify-between mb-8 border-b border-slate-800 pb-4">
                <div className="flex items-center gap-4">
                    <button
                        onClick={() => router.push('/admin')}
                        className="p-2 hover:bg-slate-800 rounded-full transition-colors text-slate-400 hover:text-white"
                    >
                        <ArrowLeft className="w-6 h-6" />
                    </button>
                    <div className="p-3 bg-cyan-900/20 rounded-xl border border-cyan-500/30">
                        <Map className="w-8 h-8 text-cyan-500" />
                    </div>
                    <div>
                        <h1 className="text-3xl font-bold text-white font-orbitron tracking-wider">REGION COSTS</h1>
                        <p className="text-slate-500 font-mono text-sm">MANAGE UNLOCK REQUIREMENTS</p>
                    </div>
                </div>
                <button
                    onClick={fetchRegions}
                    className="p-2 bg-slate-900 border border-slate-700 rounded hover:bg-slate-800 transition-colors"
                    title="Refresh Data"
                >
                    <RefreshCw className="w-5 h-5 text-cyan-500" />
                </button>
            </header>

            {/* Content */}
            <div className="bg-slate-900/30 border border-slate-800 rounded-xl overflow-hidden">
                <div className="p-4 border-b border-slate-800 flex items-center justify-between bg-slate-900/50">
                    <h2 className="text-lg font-bold text-white font-orbitron">REGIONS LIST</h2>
                    <div className="relative">
                        <Search className="w-4 h-4 text-slate-500 absolute left-3 top-1/2 -translate-y-1/2" />
                        <input
                            type="text"
                            placeholder="Search Region..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className="bg-slate-950 border border-slate-700 rounded-lg pl-9 pr-4 py-2 text-sm focus:outline-none focus:border-cyan-500 w-64"
                        />
                    </div>
                </div>

                <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse">
                        <thead>
                            <tr className="bg-slate-950 text-slate-500 text-xs font-mono uppercase tracking-wider">
                                <th className="p-4 border-b border-slate-800">Region Name</th>
                                <th className="p-4 border-b border-slate-800">Tier</th>
                                <th className="p-4 border-b border-slate-800">Unlock Cost (NC)</th>
                                <th className="p-4 border-b border-slate-800 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody className="text-sm divide-y divide-slate-800">
                            {filteredRegions.map(region => (
                                <tr key={region.id} className="hover:bg-slate-800/30 transition-colors">
                                    <td className="p-4 font-bold text-white">{region.id}</td>
                                    <td className="p-4 font-mono text-slate-400">
                                        {editingId === region.id ? (
                                            <select
                                                value={editForm.tier || 'level_1'}
                                                onChange={(e) => setEditForm({ ...editForm, tier: e.target.value })}
                                                className="bg-slate-950 border border-slate-700 rounded px-2 py-1"
                                            >
                                                <option value="level_1">Level 1 (Green)</option>
                                                <option value="level_2">Level 2 (Orange)</option>
                                                <option value="level_3">Level 3 (Gold)</option>
                                            </select>
                                        ) : (
                                            <span className={`
                                                ${region.tier === 'level_1' ? 'text-green-400' : ''}
                                                ${region.tier === 'level_2' ? 'text-orange-400' : ''}
                                                ${region.tier === 'level_3' ? 'text-yellow-400' : ''}
                                            `}>
                                                {region.tier}
                                            </span>
                                        )}
                                    </td>
                                    <td className="p-4 font-mono">
                                        {editingId === region.id ? (
                                            <input
                                                type="number"
                                                value={editForm.cost || 0}
                                                onChange={(e) => setEditForm({ ...editForm, cost: parseInt(e.target.value) })}
                                                className="bg-slate-950 border border-slate-700 rounded px-2 py-1 w-32 text-yellow-400"
                                            />
                                        ) : (
                                            <span className="text-yellow-400">{region.cost.toLocaleString()} NC</span>
                                        )}
                                    </td>
                                    <td className="p-4 text-right">
                                        {editingId === region.id ? (
                                            <div className="flex justify-end gap-2">
                                                <button onClick={() => handleSave(region.id)} className="p-1.5 bg-green-900/50 text-green-400 rounded hover:bg-green-900 transition-colors">
                                                    <Save className="w-4 h-4" />
                                                </button>
                                                <button onClick={handleCancelEdit} className="p-1.5 bg-slate-800 text-slate-400 rounded hover:bg-slate-700 transition-colors">
                                                    <ArrowLeft className="w-4 h-4" /> {/* Using ArrowLeft as Cancel/Back icon */}
                                                </button>
                                            </div>
                                        ) : (
                                            <button onClick={() => handleEdit(region)} className="p-1.5 hover:bg-slate-800 rounded text-cyan-400 transition-colors">
                                                Edit
                                            </button>
                                        )}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>

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
