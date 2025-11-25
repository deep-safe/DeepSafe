"use client";

import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Province } from '@/data/provincesData';
import ItalyMapSVG from './ItalyMapSVG';
import TopBar from './TopBar';
import { Lock } from 'lucide-react';

const ItalyMapDashboard: React.FC = () => {
    const [toast, setToast] = useState<{ message: string; type: 'info' | 'error' } | null>(null);

    const handleProvinceClick = (province: Province) => {
        if (province.status === 'locked') {
            showToast(`Access Denied: ${province.name} is currently locked. Complete previous regions first.`, 'error');
        } else {
            console.log(`Open Mission Select for: ${province.name}`);
            showToast(`Mission Select: ${province.name}`, 'info');
            // Here you would open the actual modal
        }
    };

    const showToast = (message: string, type: 'info' | 'error') => {
        setToast({ message, type });
        setTimeout(() => setToast(null), 3000);
    };

    return (
        <div className="relative w-full h-screen bg-slate-950 overflow-hidden font-sans text-slate-200 selection:bg-cyan-500/30">

            {/* Background Ambient Glow */}
            <div className="absolute top-[-20%] left-[-10%] w-[50%] h-[50%] bg-cyan-900/20 rounded-full blur-[120px] pointer-events-none" />
            <div className="absolute bottom-[-20%] right-[-10%] w-[50%] h-[50%] bg-amber-900/10 rounded-full blur-[120px] pointer-events-none" />

            {/* HUD Elements */}
            <TopBar />

            {/* Main Map Area */}
            <main className="w-full h-full flex items-center justify-center p-4 md:p-8 pt-20 pb-24">
                <ItalyMapSVG onProvinceClick={handleProvinceClick} />
            </main>

            {/* Toast Notification */}
            <AnimatePresence>
                {toast && (
                    <motion.div
                        initial={{ opacity: 0, y: 50, x: '-50%' }}
                        animate={{ opacity: 1, y: 0, x: '-50%' }}
                        exit={{ opacity: 0, y: 20, x: '-50%' }}
                        className={`absolute bottom-24 left-1/2 px-6 py-3 rounded-lg backdrop-blur-md border shadow-2xl flex items-center gap-3 z-50 ${toast.type === 'error'
                            ? 'bg-red-950/80 border-red-500/50 text-red-200'
                            : 'bg-cyan-950/80 border-cyan-500/50 text-cyan-200'
                            }`}
                    >
                        {toast.type === 'error' && <Lock className="w-4 h-4" />}
                        <span className="text-sm font-medium">{toast.message}</span>
                    </motion.div>
                )}
            </AnimatePresence>

        </div>
    );
};

export default ItalyMapDashboard;
