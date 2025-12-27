'use client';

import React from 'react';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';
import Link from 'next/link';

export default function PrezziPage() {
    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
            <SiteNavbar />

            <main className="pt-32 pb-20 container mx-auto px-4">
                <header className="text-center mb-16">
                    <h1 className="text-4xl md:text-6xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">
                        Scegli il tuo <span className="text-[#00f3ff]">Livello</span>
                    </h1>
                    <p className="text-xl max-w-3xl mx-auto text-gray-300">
                        Investi nella tua sicurezza con il piano adatto a te.
                    </p>
                </header>

                <div className="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto">
                    {/* Free Tier */}
                    <div className="bg-[#161622] rounded-2xl p-8 border border-[#333] flex flex-col relative overflow-hidden">
                        <h3 className="text-2xl font-bold text-white mb-2">BASE</h3>
                        <div className="text-4xl font-bold text-[#00f3ff] mb-6">Gratis</div>
                        <p className="text-gray-400 mb-8 h-12">Per iniziare il tuo viaggio nella sicurezza digitale.</p>

                        <ul className="space-y-4 mb-8 flex-1">
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Accesso a tutte le Regioni
                            </li>
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> 2 Missioni per Provincia Giocabili
                            </li>
                        </ul>

                        <Link href="/dashboard" className="btn w-full text-center py-3 rounded-xl border border-[#00f3ff] text-[#00f3ff] hover:bg-[#00f3ff] hover:text-black transition-all font-bold">
                            INIZIA ORA
                        </Link>
                    </div>

                    {/* Pro Tier (Highlighted) */}
                    <div className="bg-gradient-to-b from-[#1a1a2e] to-[#161622] rounded-2xl p-8 border-2 border-[#00f3ff] shadow-[0_0_30px_rgba(0,243,255,0.15)] flex flex-col relative transform md:-translate-y-4">
                        <div className="absolute top-0 right-0 bg-[#00f3ff] text-black text-xs font-bold px-3 py-1 rounded-bl-lg">POPOLARE</div>
                        <h3 className="text-2xl font-bold text-white mb-2">PRO</h3>
                        <div className="text-4xl font-bold text-[#00f3ff] mb-1">€4.99</div>
                        <div className="text-sm text-gray-400 mb-6">/ mese</div>
                        <p className="text-gray-400 mb-8 h-12">Sblocca tutto il potenziale e accedi ai tool avanzati.</p>

                        <ul className="space-y-4 mb-8 flex-1">
                            <li className="flex items-center text-white font-bold">
                                <span className="text-[#00f3ff] mr-3">✓</span> Tutti BENEFIT di BASE
                            </li>
                            <li className="flex items-center text-white">
                                <span className="text-[#00f3ff] mr-3">✓</span> Statistiche Personali
                            </li>
                            <li className="flex items-center text-white">
                                <span className="text-[#00f3ff] mr-3">✓</span> Badge "Pro" Esclusivo
                            </li>
                        </ul>

                        <Link href="/dashboard" className="btn w-full text-center py-3 rounded-xl border border-[#00f3ff] text-[#00f3ff] hover:bg-[#00f3ff] hover:text-black transition-all font-bold">
                            INIZIA ORA
                        </Link>
                    </div>

                    {/* Premium Tier */}
                    <div className="bg-[#161622] rounded-2xl p-8 border border-[#333] flex flex-col relative overflow-hidden">
                        <h3 className="text-2xl font-bold text-white mb-2">PREMIUM</h3>
                        <div className="text-4xl font-bold text-[#e0e0e0] mb-1">€9.99</div>
                        <div className="text-sm text-gray-400 mb-6">/ mese</div>
                        <p className="text-gray-400 mb-8 h-12">Formazione di alto livello e supporto dedicato.</p>

                        <ul className="space-y-4 mb-8 flex-1">
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Tutti BENEFIT del livello PRO
                            </li>
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Squad Multiplayer
                            </li>
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Avatar Speciale Personalizzato
                            </li>
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Accesso anticipato alle Beta
                            </li>
                            <li className="flex items-center text-gray-300">
                                <span className="text-[#00f3ff] mr-3">✓</span> Statistiche Avanzate e Grafici
                            </li>
                        </ul>

                        <Link href="/dashboard" className="btn w-full text-center py-3 rounded-xl border border-[#00f3ff] text-[#00f3ff] hover:bg-[#00f3ff] hover:text-black transition-all font-bold">
                            INIZIA ORA
                        </Link>
                    </div>
                </div>
            </main>

            <SiteFooter />
        </div>
    );
}
