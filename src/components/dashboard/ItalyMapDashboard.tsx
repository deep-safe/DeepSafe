"use client";

import React, { useState, useMemo } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Province, provincesData } from '@/data/provincesData';
import ItalyMapSVG from './ItalyMapSVG';
import TopBar from './TopBar';
import ProvinceModal from './ProvinceModal';
import { Lock, ArrowLeft, Map } from 'lucide-react';
import { getRegionBoundingBox } from '@/utils/svgUtils';

const ITALY_VIEWBOX = "0 0 800 1000";

const ItalyMapDashboard: React.FC = () => {
    const [toast, setToast] = useState<{ message: string; type: 'info' | 'error' } | null>(null);
    const [selectedProvince, setSelectedProvince] = useState<Province | null>(null);

    // Navigation State
    const [viewMode, setViewMode] = useState<'ITALY' | 'REGION'>('ITALY');
    const [selectedRegion, setSelectedRegion] = useState<string | null>(null);
    const [highlightedRegion, setHighlightedRegion] = useState<string | null>(null);
    const [viewBox, setViewBox] = useState(ITALY_VIEWBOX);

    // Calculate Region ViewBox with padding
    const calculateRegionViewBox = (regionName: string) => {
        const regionProvinces = provincesData.filter(p => p.region === regionName);
        const paths = regionProvinces.map(p => p.path);
        const bbox = getRegionBoundingBox(paths);

        if (!bbox) return ITALY_VIEWBOX;

        // Add 20% padding
        const paddingX = bbox.width * 0.2;
        const paddingY = bbox.height * 0.2;
        const minX = bbox.minX - paddingX / 2;
        const minY = bbox.minY - paddingY / 2;
        const width = bbox.width + paddingX;
        const height = bbox.height + paddingY;

        return `${minX} ${minY} ${width} ${height}`;
    };

    const handleProvinceClick = (province: Province) => {
        if (viewMode === 'ITALY') {
            // Level 1 -> Level 2: Zoom into Region
            const region = province.region;
            const newViewBox = calculateRegionViewBox(region);

            setSelectedRegion(region);
            setViewBox(newViewBox);
            setViewMode('REGION');
        } else {
            // Level 2: Select Province for Mission
            setSelectedProvince(province);
        }
    };

    const handleBackToItaly = () => {
        setSelectedRegion(null);
        setViewBox(ITALY_VIEWBOX);
        setViewMode('ITALY');
    };

    const handleProvinceHover = (province: Province | null) => {
        if (viewMode === 'ITALY') {
            setHighlightedRegion(province ? province.region : null);
        } else {
            setHighlightedRegion(null);
        }
    };

    const handleStartMission = () => {
        if (selectedProvince) {
            console.log(`Starting mission for: ${selectedProvince.name}`);
            showToast(`Missione avviata: ${selectedProvince.name}`, 'info');
            setSelectedProvince(null);
            // Navigate to mission page or start logic here
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

            {/* Navigation Header / Breadcrumbs */}
            <div className="absolute top-24 left-0 w-full z-20 px-4 md:px-8 pointer-events-none">
                <div className="flex items-center justify-between max-w-4xl mx-auto">
                    <motion.div
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        className="flex items-center gap-2 pointer-events-auto"
                    >
                        <AnimatePresence mode="wait">
                            {viewMode === 'REGION' && (
                                <motion.button
                                    initial={{ opacity: 0, x: -10 }}
                                    animate={{ opacity: 1, x: 0 }}
                                    exit={{ opacity: 0, x: -10 }}
                                    onClick={handleBackToItaly}
                                    className="flex items-center gap-2 px-3 py-2 rounded-lg bg-slate-900/80 border border-slate-700 hover:border-cyan-500/50 text-slate-300 hover:text-cyan-400 transition-all backdrop-blur-md shadow-lg group"
                                >
                                    <ArrowLeft className="w-4 h-4 group-hover:-translate-x-1 transition-transform" />
                                    <span className="text-xs font-orbitron font-bold tracking-wider">ITALIA</span>
                                </motion.button>
                            )}
                        </AnimatePresence>

                        <div className="flex items-center gap-2 px-4 py-2 rounded-lg bg-slate-900/50 border border-slate-800/50 backdrop-blur-sm">
                            <Map className="w-4 h-4 text-cyan-500" />
                            <div className="flex items-center text-xs font-orbitron font-bold tracking-widest text-slate-400">
                                <span className={viewMode === 'ITALY' ? 'text-cyan-400 text-glow' : ''}>ITALIA</span>
                                {selectedRegion && (
                                    <>
                                        <span className="mx-2 text-slate-600">/</span>
                                        <motion.span
                                            initial={{ opacity: 0, x: 10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            className="text-cyan-400 text-glow uppercase"
                                        >
                                            {selectedRegion}
                                        </motion.span>
                                    </>
                                )}
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>

            {/* Main Map Area */}
            <main className="w-full h-full flex items-center justify-center p-4 md:p-8 pt-20 pb-24">
                <ItalyMapSVG
                    onProvinceClick={handleProvinceClick}
                    onProvinceHover={handleProvinceHover}
                    viewBox={viewBox}
                    activeRegion={selectedRegion}
                    highlightedRegion={highlightedRegion}
                />
            </main>

            {/* Province Selection Modal */}
            <AnimatePresence>
                {selectedProvince && (
                    <ProvinceModal
                        province={selectedProvince}
                        onClose={() => setSelectedProvince(null)}
                    />
                )}
            </AnimatePresence>

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
