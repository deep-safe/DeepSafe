'use client';

import React, { useState } from 'react';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';
import Link from 'next/link';
import missionsData from '@/data/missions_dataset.json';
import { motion, AnimatePresence } from 'framer-motion';

// Icons mapping based on topics (simple mapping for visual flair)
const getIconForTopic = (topic: string) => {
    const t = topic.toLowerCase();
    if (t.includes('finance') || t.includes('crypto') || t.includes('money')) return '💰';
    if (t.includes('privacy') || t.includes('identity')) return '🕵️';
    if (t.includes('infrastructure') || t.includes('city') || t.includes('iot')) return '🏙️';
    if (t.includes('fake') || t.includes('social')) return '🤥';
    if (t.includes('malware') || t.includes('ransomware') || t.includes('virus')) return '🦠';
    return '🛡️';
};

export default function MissionsPage() {
    const [selectedRegion, setSelectedRegion] = useState<string | null>(null);

    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
            <SiteNavbar />

            {/* Hero Section */}
            <section className="relative pt-40 pb-20 px-4 text-center overflow-hidden">
                <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,#1a1a2e_0%,#000_100%)] z-0"></div>
                <div className="absolute top-0 left-0 w-full h-full bg-[url('/landing/assets/grid.svg')] opacity-10 z-0"></div>

                <div className="relative z-10 max-w-4xl mx-auto">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8 }}
                    >
                        <span className="inline-block py-1 px-3 rounded-full bg-[#00f3ff]/10 border border-[#00f3ff]/30 text-[#00f3ff] text-sm font-bold mb-6 tracking-widest uppercase">
                            Roadmap Educativa
                        </span>
                        <h1 className="text-4xl md:text-7xl font-bold mb-6 text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.3)]">
                            Le Tue <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#00f3ff] to-[#7000ff]">Missioni</span>
                        </h1>
                        <p className="text-xl text-gray-400 max-w-2xl mx-auto leading-relaxed">
                            Ogni regione d'Italia nasconde una minaccia digitale unica.
                            Esplora i territori, sblocca le province e diventa un esperto di cybersecurity.
                        </p>
                    </motion.div>
                </div>
            </section>

            {/* Regions Grid */}
            <section className="py-20 px-4 relative z-10">
                <div className="container mx-auto">
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                        {missionsData.map((region, index) => (
                            <motion.div
                                key={region.region_id}
                                initial={{ opacity: 0, y: 30 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: index * 0.1 }}
                                className="group relative"
                            >
                                <div
                                    className={`
                                        h-full bg-[#161622] border border-white/5 rounded-2xl p-8 hover:border-[#00f3ff]/50 transition-all duration-300 cursor-pointer overflow-hidden
                                        ${selectedRegion === region.region_id ? 'ring-2 ring-[#00f3ff] bg-[#1a1a2e]' : ''}
                                    `}
                                    onClick={() => setSelectedRegion(selectedRegion === region.region_id ? null : region.region_id)}
                                >
                                    {/* Region Header */}
                                    <div className="flex justify-between items-start mb-6">
                                        <div>
                                            <h3 className="text-3xl font-bold text-white mb-2 group-hover:text-[#00f3ff] transition-colors">
                                                {region.region_name}
                                            </h3>
                                            <div className="flex items-center gap-2 text-sm text-gray-400">
                                                <span className={`w-2 h-2 rounded-full ${region.is_unlocked ? 'bg-[#00f3ff]' : 'bg-red-500'}`}></span>
                                                {region.is_unlocked ? 'Regione Attiva' : 'Accesso Bloccato'}
                                            </div>
                                        </div>
                                        <div className="text-4xl opacity-50 group-hover:opacity-100 transition-opacity transform group-hover:scale-110 duration-300">
                                            {/* Generic region icons based on name/vibe could go here, defaulting to shield */}
                                            🛡️
                                        </div>
                                    </div>

                                    {/* Brief Description (Generated from Missions) */}
                                    <p className="text-gray-400 mb-8 border-b border-white/5 pb-6">
                                        In questa regione affronterai: <br />
                                        <span className="text-gray-200 font-medium">
                                            {region.provinces.flatMap(p => p.missions).slice(0, 3).map(m => m.topic).join(", ")}
                                        </span>
                                        ...
                                    </p>

                                    {/* Provinces List - Visible always or expandable? Let's show first few */}
                                    <div className="space-y-4">
                                        <h4 className="text-[#00f3ff] text-sm uppercase tracking-wider font-bold mb-4">Province & Obiettivi</h4>

                                        {region.provinces.map((province) => (
                                            <div key={province.id} className="bg-black/20 rounded-xl p-4 hover:bg-white/5 transition-colors">
                                                <div className="flex justify-between items-center mb-2">
                                                    <span className="font-bold text-white">{province.name}</span>
                                                    <span className="text-xs px-2 py-1 rounded bg-white/10 text-gray-300">{province.missions.length} Missioni</span>
                                                </div>
                                                {/* Show only 1st mission as teaser */}
                                                {province.missions.length > 0 && (
                                                    <div className="text-sm text-gray-400">
                                                        <span className="mr-2">{getIconForTopic(province.missions[0].topic)}</span>
                                                        {province.missions[0].title}
                                                    </div>
                                                )}

                                                {/* Expandable Details when selected */}
                                                <AnimatePresence>
                                                    {selectedRegion === region.region_id && (
                                                        <motion.div
                                                            initial={{ height: 0, opacity: 0 }}
                                                            animate={{ height: 'auto', opacity: 1 }}
                                                            exit={{ height: 0, opacity: 0 }}
                                                            className="mt-4 pt-4 border-t border-white/10 space-y-3"
                                                        >
                                                            {province.missions.map(mission => (
                                                                <div key={mission.id} className="text-sm">
                                                                    <div className="text-[#00f3ff] font-medium">{mission.title}</div>
                                                                    <div className="text-gray-500 text-xs italic mt-1">{mission.description}</div>
                                                                    <div className="mt-1 flex items-center gap-2">
                                                                        <span className="text-xs bg-[#00f3ff]/10 text-[#00f3ff] px-1.5 py-0.5 rounded">
                                                                            {mission.difficulty}
                                                                        </span>
                                                                        <span className="text-xs text-gray-400">NPC: {mission.character.name}</span>
                                                                    </div>
                                                                </div>
                                                            ))}
                                                        </motion.div>
                                                    )}
                                                </AnimatePresence>
                                            </div>
                                        ))}
                                    </div>

                                    {/* Call to Action */}
                                    <div className="mt-8 pt-4">
                                        <button className="w-full py-3 rounded-lg border border-[#00f3ff] text-[#00f3ff] font-bold hover:bg-[#00f3ff] hover:text-black transition-all">
                                            {selectedRegion === region.region_id ? 'CHIUDI DETTAGLI' : 'VEDI MISSIONI'}
                                        </button>
                                    </div>
                                </div>
                            </motion.div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Call to Action Footer Style */}
            <section className="py-20 bg-gradient-to-t from-black to-[#161622] text-center">
                <div className="container mx-auto px-4">
                    <h2 className="text-3xl md:text-4xl font-bold mb-6 text-white">Pronto a Salvare l'Italia?</h2>
                    <p className="text-gray-400 mb-10 max-w-xl mx-auto">
                        Le minacce sono reali, ma lo sono anche le tue abilità. Inizia oggi il tuo percorso.
                    </p>
                    <Link href="/dashboard" className="inline-block py-4 px-12 rounded-xl bg-[#00f3ff] text-black hover:bg-[#00d2dd] transition-all font-bold text-xl shadow-[0_0_20px_rgba(0,243,255,0.4)]">
                        VAI ALLA DASHBOARD
                    </Link>
                </div>
            </section>

            <SiteFooter />
        </div>
    );
}
