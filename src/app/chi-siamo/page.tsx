'use client';

import React from 'react';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';

export default function ChiSiamoPage() {
    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
            <SiteNavbar />

            <main className="pt-32 pb-20 container mx-auto px-4">
                <header className="text-center mb-16">
                    <h1 className="text-4xl md:text-6xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">
                        Chi <span className="text-[#00f3ff]">Siamo</span>
                    </h1>
                    <p className="text-xl max-w-3xl mx-auto text-gray-300">
                        Siamo un team di visionari decisi a trasformare la sicurezza informatica in una sfida epica.
                    </p>
                </header>

                <section className="grid md:grid-cols-2 gap-12 max-w-5xl mx-auto mb-20">
                    {/* Founder 1 */}
                    <div className="bg-[#161622] p-8 rounded-2xl border border-[#333] hover:border-[#00f3ff] transition-colors group">
                        <div className="w-32 h-32 mx-auto mb-6 rounded-full overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.3)]">
                            <img
                                src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/simone.png`}
                                alt="Simone Mattioli"
                                className="w-full h-full object-cover"
                            />
                        </div>
                        <h2 className="text-2xl font-bold text-center text-white mb-2">Simone Mattioli</h2>
                        <p className="text-[#00f3ff] text-center font-mono mb-4">Co-Founder & Tech Lead</p>
                        <p className="text-gray-400 text-center leading-relaxed">
                            Appassionato di tecnologia e sicurezza, Simone guida lo sviluppo tecnico di DeepSafe con l'obiettivo di rendere l'apprendimento accessibile e coinvolgente per tutti.
                        </p>
                    </div>

                    {/* Founder 2 */}
                    <div className="bg-[#161622] p-8 rounded-2xl border border-[#333] hover:border-[#00f3ff] transition-colors group">
                        <div className="w-32 h-32 mx-auto mb-6 rounded-full overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.3)]">
                            <img
                                src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/sergio.png`}
                                alt="Sergio Suarato"
                                className="w-full h-full object-cover"
                            />
                        </div>
                        <h2 className="text-2xl font-bold text-center text-white mb-2">Sergio Suarato</h2>
                        <p className="text-[#00f3ff] text-center font-mono mb-4">Co-Founder & Visionary</p>
                        <p className="text-gray-400 text-center leading-relaxed">
                            Con una visione chiara del futuro digitale, Sergio lavora per creare un ecosistema dove la sicurezza è una competenza fondamentale per le nuove generazioni.
                        </p>
                    </div>
                </section>

                <section className="max-w-4xl mx-auto text-center bg-gradient-to-b from-[#161622] to-[#0a0a12] p-10 rounded-3xl border border-[#333]">
                    <h2 className="text-3xl font-bold mb-6 text-white">La Nostra Missione</h2>
                    <p className="text-lg text-gray-300 leading-relaxed mb-8">
                        <br /><br />
                        Abbiamo creato DeepSafe perché crediamo che la cybersecurity non debba essere noiosa o riservata a pochi esperti.
                        In un mondo sempre più connesso, ogni cittadino deve avere gli strumenti per proteggere la propria identità e il proprio futuro.
                        <br /><br />
                        Vogliamo rendere l'Italia un paese più sicuro, un utente alla volta.
                    </p>
                </section>
            </main>

            <SiteFooter />
        </div>
    );
}
