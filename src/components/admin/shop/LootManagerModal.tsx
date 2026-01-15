import React, { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase/client';
import { X, Save, Trash2, Plus, Zap, Percent, Coins, Clock, Gift, Users } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

interface LootItem {
    id?: string;
    reward_type: string;
    reward_value: number;
    weight: number;
    description: string;
    box_id: string;
}

interface LootManagerModalProps {
    isOpen: boolean;
    onClose: () => void;
    boxId: string;
    initialLoot: LootItem[];
    onSave: (newLoot: LootItem[]) => void;
}

export function LootManagerModal({ isOpen, onClose, boxId, initialLoot, onSave }: LootManagerModalProps) {
    const [loot, setLoot] = useState<LootItem[]>(initialLoot);
    const [newItem, setNewItem] = useState<Partial<LootItem>>({
        reward_type: 'xp',
        reward_value: 100,
        weight: 10,
        description: ''
    });

    // Sync local state with initialLoot prop when it changes or modal opens
    useEffect(() => {
        if (isOpen) {
            setLoot(initialLoot);
        }
    }, [initialLoot, isOpen]);

    const totalWeight = loot.reduce((acc, item) => acc + item.weight, 0);

    const handleAddItem = () => {
        if (!newItem.description) return;

        const item: LootItem = {
            id: `temp_${Date.now()}`,
            box_id: boxId,
            reward_type: newItem.reward_type!,
            reward_value: newItem.reward_value || 0,
            weight: newItem.weight || 10,
            description: newItem.description!
        };

        setLoot([...loot, item]);
        setNewItem({
            reward_type: 'xp',
            reward_value: 100,
            weight: 10,
            description: ''
        });
    };

    const handleRemoveItem = (index: number) => {
        const newLoot = [...loot];
        newLoot.splice(index, 1);
        setLoot(newLoot);
    };

    const handleSave = async () => {
        onSave(loot);
        onClose();
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 bg-black/90 backdrop-blur-md flex items-center justify-center z-[100] p-4">
            <motion.div
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                className="bg-slate-900 border border-purple-500/30 rounded-2xl w-full max-w-4xl overflow-hidden shadow-2xl flex flex-col max-h-[90vh]"
            >
                {/* Header */}
                <div className="p-6 border-b border-purple-500/20 bg-slate-900 flex justify-between items-center">
                    <div>
                        <h2 className="text-2xl font-bold font-orbitron text-purple-400 flex items-center gap-2">
                            <Zap className="fill-purple-400" />
                            LOOT MANAGER
                        </h2>
                        <p className="text-slate-400 text-sm font-mono">
                            Total Weight: <span className="text-white font-bold">{totalWeight}</span>
                            (Probabilities calculated dynamically)
                        </p>
                    </div>
                    <button onClick={onClose} className="p-2 hover:bg-slate-800 rounded-full transition-colors">
                        <X className="w-6 h-6 text-slate-400" />
                    </button>
                </div>

                {/* Content */}
                <div className="flex-1 overflow-y-auto p-6 space-y-6">

                    {/* Add New Item Form */}
                    <div className="bg-slate-800/50 p-4 rounded-xl border border-slate-700">
                        <h3 className="text-sm font-bold text-white mb-4 flex items-center gap-2">
                            <Plus className="w-4 h-4 text-green-400" /> ADD NEW REWARD
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
                            <div className="md:col-span-1">
                                <label className="text-[10px] text-slate-500 font-mono block mb-1">TYPE</label>
                                <select
                                    value={newItem.reward_type}
                                    onChange={e => setNewItem({ ...newItem, reward_type: e.target.value })}
                                    className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-2 text-sm text-white focus:border-purple-500 outline-none"
                                >
                                    <option value="xp">XP (Experience)</option>
                                    <option value="credits">NC (Credits)</option>
                                    <option value="lives">VITE (Hearts)</option>
                                    <option value="streak_freeze">STREAK FREEZE</option>
                                    <option value="avatar">AVATAR (Random)</option>
                                </select>
                            </div>
                            <div className="md:col-span-1">
                                <label className="text-[10px] text-slate-500 font-mono block mb-1">VALUE</label>
                                <input
                                    type="number"
                                    value={newItem.reward_value}
                                    onChange={e => setNewItem({ ...newItem, reward_value: parseInt(e.target.value) })}
                                    disabled={newItem.reward_type === 'avatar'} // Fixed value for avatar logic
                                    className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-2 text-sm text-white focus:border-purple-500 outline-none disabled:opacity-50"
                                    placeholder="0"
                                />
                            </div>
                            <div className="md:col-span-1">
                                <label className="text-[10px] text-slate-500 font-mono block mb-1">WEIGHT</label>
                                <input
                                    type="number"
                                    value={newItem.weight}
                                    onChange={e => setNewItem({ ...newItem, weight: parseInt(e.target.value) })}
                                    className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-2 text-sm text-white focus:border-purple-500 outline-none"
                                    placeholder="10"
                                />
                            </div>
                            <div className="md:col-span-2 flex gap-2">
                                <div className="flex-1">
                                    <label className="text-[10px] text-slate-500 font-mono block mb-1">DESCRIPTION</label>
                                    <input
                                        type="text"
                                        value={newItem.description}
                                        onChange={e => setNewItem({ ...newItem, description: e.target.value })}
                                        className="w-full bg-slate-950 border border-slate-700 rounded px-2 py-2 text-sm text-white focus:border-purple-500 outline-none"
                                        placeholder="e.g. Huge XP Boost"
                                    />
                                </div>
                                <button
                                    onClick={handleAddItem}
                                    className="mt-5 px-4 bg-purple-600 hover:bg-purple-500 text-white rounded font-bold transition-colors"
                                >
                                    ADD
                                </button>
                            </div>
                        </div>
                    </div>

                    {/* Visual Probability Bar */}
                    <div className="h-4 w-full bg-slate-800 rounded-full overflow-hidden flex">
                        {loot.map((item, idx) => {
                            const percent = (item.weight / totalWeight) * 100;
                            const colors = ['bg-purple-500', 'bg-cyan-500', 'bg-emerald-500', 'bg-yellow-500', 'bg-red-500'];
                            return (
                                <div
                                    key={idx}
                                    style={{ width: `${percent}%` }}
                                    className={`${colors[idx % colors.length]} h-full relative group`}
                                >
                                    <div className="absolute bottom-full mb-2 left-1/2 -translate-x-1/2 bg-black text-white text-xs px-2 py-1 rounded opacity-0 group-hover:opacity-100 whitespace-nowrap z-10 pointer-events-none border border-slate-700">
                                        {percent.toFixed(1)}% - {item.description}
                                    </div>
                                </div>
                            );
                        })}
                    </div>

                    {/* Items List */}
                    <div className="space-y-2">
                        {loot.map((item, idx) => {
                            const percent = totalWeight > 0 ? ((item.weight / totalWeight) * 100).toFixed(1) : '0';
                            return (
                                <motion.div
                                    initial={{ opacity: 0, y: 10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    key={idx}
                                    className="flex items-center justify-between bg-slate-800/80 p-4 rounded-lg border border-slate-700 hover:border-purple-500/50 transition-colors"
                                >
                                    <div className="flex items-center gap-4">
                                        <div className="w-10 h-10 rounded-lg bg-slate-900 flex items-center justify-center text-xl border border-slate-800">
                                            {item.reward_type === 'xp' && <Zap className="w-5 h-5 text-yellow-400" />}
                                            {item.reward_type === 'credits' && <Coins className="w-5 h-5 text-cyan-400" />}
                                            {item.reward_type === 'lives' && <Gift className="w-5 h-5 text-red-400" />}
                                            {item.reward_type === 'streak_freeze' && <Clock className="w-5 h-5 text-orange-400" />}
                                            {item.reward_type === 'avatar' && <Users className="w-5 h-5 text-purple-400" />}
                                        </div>
                                        <div>
                                            <div className="font-bold text-white">{item.description}</div>
                                            <div className="text-xs text-slate-400 font-mono">
                                                {item.reward_type.toUpperCase()} +{item.reward_value}
                                            </div>
                                        </div>
                                    </div>

                                    <div className="flex items-center gap-6">
                                        <div className="text-right">
                                            <div className="text-sm font-bold text-purple-400">{percent}%</div>
                                            <div className="text-[10px] text-slate-500 font-mono center">CHANCE</div>
                                        </div>
                                        <div className="text-right">
                                            <div className="text-sm font-bold text-white">{item.weight}</div>
                                            <div className="text-[10px] text-slate-500 font-mono">WEIGHT</div>
                                        </div>
                                        <button
                                            onClick={() => handleRemoveItem(idx)}
                                            className="p-2 hover:bg-red-900/20 text-slate-500 hover:text-red-400 rounded transition-colors"
                                        >
                                            <Trash2 className="w-5 h-5" />
                                        </button>
                                    </div>
                                </motion.div>
                            );
                        })}
                        {loot.length === 0 && (
                            <div className="text-center py-10 text-slate-500 italic">No loot configured. The box is empty!</div>
                        )}
                    </div>

                </div>

                {/* Footer */}
                <div className="p-6 border-t border-slate-800 bg-slate-900 flex justify-end gap-3">
                    <button onClick={onClose} className="px-6 py-3 text-slate-400 hover:text-white transition-colors">
                        Cancel
                    </button>
                    <button
                        onClick={handleSave}
                        className="px-8 py-3 bg-gradient-to-r from-purple-600 to-cyan-600 hover:from-purple-500 hover:to-cyan-500 text-white font-bold rounded-lg shadow-lg shadow-purple-900/20 transition-all transform hover:scale-105"
                    >
                        <Save className="w-4 h-4 inline-block mr-2" />
                        SAVE CONFIGURATION
                    </button>
                </div>
            </motion.div>
        </div>
    );
}
