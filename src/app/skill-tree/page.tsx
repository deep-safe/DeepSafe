'use client';

import React, { useState } from 'react';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';
import skillsData from '@/data/skills_dataset.json';
import { motion, AnimatePresence } from 'framer-motion';

export default function SkillTreePage() {
    const [selectedSkill, setSelectedSkill] = useState<string | null>(null);

    // Calculate canvas size relative to viewport for responsiveness
    // Using percentages in data (0-100) for x/y to make it responsive

    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-hidden selection:bg-[#00f3ff] selection:text-black flex flex-col">
            <SiteNavbar />

            <div className="relative flex-grow flex flex-col items-center pt-24 pb-0 px-0 md:px-4">

                {/* Background Grid */}
                <div className="absolute inset-0 bg-[url('/landing/assets/grid.svg')] opacity-20 pointer-events-none"></div>
                <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,transparent_0%,#0a0a12_100%)] pointer-events-none"></div>

                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="text-center mb-12 z-10"
                >
                    <h1 className="text-4xl md:text-5xl font-bold mb-4 bg-clip-text text-transparent bg-gradient-to-r from-[#00f3ff] via-white to-[#7000ff]">
                        Albero delle Abilità
                    </h1>
                    <p className="text-gray-400 max-w-xl mx-auto">
                        Visualizza il tuo percorso di crescita. Sblocca nuove competenze completando le missioni regionali.
                    </p>
                </motion.div>

                {/* Legend */}
                <div className="flex flex-wrap gap-4 mb-8 z-10 justify-center">
                    {Object.entries(skillsData.categories).map(([key, cat]) => (
                        <div key={key} className="flex items-center gap-2 text-xs md:text-sm bg-black/40 px-3 py-1.5 rounded-full border border-white/5">
                            <span className="w-3 h-3 rounded-full" style={{ backgroundColor: cat.color }}></span>
                            <span className="text-gray-300 uppercase tracking-wider">{cat.name}</span>
                        </div>
                    ))}
                </div>

                {/* Tree Visualization Area */}
                {/* Tree Visualization Area */}
                <div className="relative w-full h-[60vh] md:h-auto md:flex-grow z-10 group animate-in fade-in zoom-in duration-700">

                    {/* Connections (SVG Layer) */}
                    <svg className="absolute inset-0 w-full h-full pointer-events-none z-0">
                        {skillsData.nodes.map(node => {
                            if (!node.parentId) return null;
                            const parent = skillsData.nodes.find(n => n.id === node.parentId);
                            if (!parent) return null;

                            return (
                                <motion.line
                                    key={`${parent.id}-${node.id}`}
                                    x1={`${parent.x}%`}
                                    y1={`${parent.y}%`}
                                    x2={`${node.x}%`}
                                    y2={`${node.y}%`}
                                    initial={{ pathLength: 0, opacity: 0 }}
                                    animate={{ pathLength: 1, opacity: 0.3 }}
                                    transition={{ duration: 1.5, delay: 0.5 }}
                                    stroke={skillsData.categories[node.category as keyof typeof skillsData.categories].color}
                                    strokeWidth="2"
                                    strokeDasharray="5 5"
                                />
                            );
                        })}
                    </svg>

                    {/* Nodes (Interactive Buttons) */}
                    {skillsData.nodes.map((node, index) => (
                        <motion.div
                            key={node.id}
                            initial={{ scale: 0, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            transition={{ delay: index * 0.1 + 0.5, type: "spring", stiffness: 200 }}
                            className="absolute transform -translate-x-1/2 -translate-y-1/2"
                            style={{
                                left: `${node.x}%`,
                                top: `${node.y}%`
                            }}
                        >
                            <button
                                onClick={() => setSelectedSkill(node.id)}
                                className={`
                                    relative group/node flex items-center justify-center w-16 h-16 md:w-20 md:h-20 rounded-full 
                                    bg-[#0a0a12] border-2 transition-all duration-300 z-10
                                    ${selectedSkill === node.id ? 'scale-125 shadow-[0_0_30px_rgba(0,243,255,0.5)] z-20' : 'hover:scale-110 hover:shadow-[0_0_15px_rgba(255,255,255,0.2)]'}
                                `}
                                style={{
                                    borderColor: skillsData.categories[node.category as keyof typeof skillsData.categories].color,
                                    boxShadow: selectedSkill === node.id ? `0 0 30px ${skillsData.categories[node.category as keyof typeof skillsData.categories].color}40` : ''
                                }}
                            >
                                <span className="text-2xl md:text-3xl filter drop-shadow-md">{node.icon}</span>

                                {/* Label below node */}
                                <div className="absolute top-full mt-3 w-40 text-center opacity-0 group-hover/node:opacity-100 transition-opacity pointer-events-none">
                                    <span className="text-sm font-bold bg-black/80 px-2 py-1 rounded text-white border border-white/10">
                                        {node.title}
                                    </span>
                                </div>
                            </button>
                        </motion.div>
                    ))}

                </div>

                {/* Skill Detail Modal - Moved to root level for proper overlay */}
                <AnimatePresence>
                    {selectedSkill && (
                        <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                            {/* Backdrop */}
                            <motion.div
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                exit={{ opacity: 0 }}
                                onClick={() => setSelectedSkill(null)}
                                className="absolute inset-0 bg-black/60 backdrop-blur-md"
                            />

                            {/* Modal Card */}
                            <motion.div
                                initial={{ opacity: 0, scale: 0.9, y: 20 }}
                                animate={{ opacity: 1, scale: 1, y: 0 }}
                                exit={{ opacity: 0, scale: 0.9, y: 20 }}
                                className="relative w-full max-w-lg bg-[#0a0a12] rounded-3xl border border-white/10 shadow-[0_0_50px_rgba(0,0,0,0.5)] overflow-hidden"
                            >
                                {(() => {
                                    const skill = skillsData.nodes.find(n => n.id === selectedSkill);
                                    if (!skill) return null;
                                    const category = skillsData.categories[skill.category as keyof typeof skillsData.categories];

                                    return (
                                        <div className="flex flex-col max-h-[85vh]">
                                            {/* Header with gradient background based on category */}
                                            <div className="relative p-6 pb-8 overflow-hidden">
                                                <div
                                                    className="absolute inset-0 opacity-20"
                                                    style={{ background: `linear-gradient(to bottom, ${category.color}, transparent)` }}
                                                />
                                                <button
                                                    onClick={() => setSelectedSkill(null)}
                                                    className="absolute top-4 right-4 p-2 rounded-full bg-black/20 hover:bg-black/40 text-white/70 hover:text-white transition-colors z-10"
                                                >
                                                    <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                                    </svg>
                                                </button>

                                                <div className="relative z-10 flex flex-col items-center text-center">
                                                    <div className="w-20 h-20 rounded-2xl border-2 flex items-center justify-center bg-[#1a1a2e] mb-4 shadow-lg transform rotate-3"
                                                        style={{ borderColor: category.color, boxShadow: `0 0 20px ${category.color}30` }}>
                                                        <span className="text-4xl transform -rotate-3">{skill.icon}</span>
                                                    </div>

                                                    <span className="text-xs uppercase tracking-[0.2em] font-bold py-1 px-3 rounded-full bg-black/30 border border-white/10 mb-3" style={{ color: category.color }}>
                                                        {category.name} • Lvl {skill.level}
                                                    </span>

                                                    <h2 className="text-3xl font-bold text-white tracking-tight">{skill.title}</h2>
                                                </div>
                                            </div>

                                            {/* Scrollable Content */}
                                            <div className="p-6 pt-0 overflow-y-auto custom-scrollbar">
                                                <p className="text-gray-300 leading-relaxed mb-6 text-center text-lg">
                                                    {skill.description}
                                                </p>

                                                <div className="bg-[#161622] rounded-xl p-5 border border-white/5 mb-6">
                                                    <h3 className="text-xs font-bold text-gray-500 uppercase tracking-wider mb-4 border-b border-white/5 pb-2">Competenze da Acquisire</h3>
                                                    <ul className="space-y-3">
                                                        <li className="flex items-start">
                                                            <div className="mt-0.5 mr-3 w-5 h-5 rounded-full bg-green-500/10 flex items-center justify-center shrink-0">
                                                                <span className="text-green-400 text-xs">✓</span>
                                                            </div>
                                                            <span className="text-gray-300 text-sm">Teoria fondamentale e concetti chiave</span>
                                                        </li>
                                                        <li className="flex items-start">
                                                            <div className="mt-0.5 mr-3 w-5 h-5 rounded-full bg-[#00f3ff]/10 flex items-center justify-center shrink-0">
                                                                <span className="text-[#00f3ff] text-xs">⚡</span>
                                                            </div>
                                                            <span className="text-gray-300 text-sm">Simulazione pratica in ambiente sandbox</span>
                                                        </li>
                                                        <li className="flex items-start">
                                                            <div className="mt-0.5 mr-3 w-5 h-5 rounded-full bg-purple-500/10 flex items-center justify-center shrink-0">
                                                                <span className="text-purple-400 text-xs">🏆</span>
                                                            </div>
                                                            <span className="text-gray-300 text-sm">Test finale di validazione competenze</span>
                                                        </li>
                                                    </ul>
                                                </div>

                                                <button className="w-full py-4 font-bold rounded-xl bg-gradient-to-r from-[#00f3ff] to-[#0099ff] text-black hover:scale-[1.02] active:scale-[0.98] transition-all shadow-[0_0_20px_rgba(0,243,255,0.3)]">
                                                    INIZIA LEZIONE
                                                </button>
                                            </div>
                                        </div>
                                    );
                                })()}
                            </motion.div>
                        </div>
                    )}
                </AnimatePresence>
            </div>
            <SiteFooter />
        </div>
    );
}
