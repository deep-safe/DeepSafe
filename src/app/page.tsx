'use client';

import React from 'react';
import Link from 'next/link';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';
import LeaderboardSection from '@/components/landing/LeaderboardSection';

export default function LandingPage() {
    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
            {/* Navbar */}
            <SiteNavbar />

            {/* Hero Section */}
            <header className="min-h-[90vh] flex items-center text-center pt-32 pb-20 relative overflow-hidden bg-[radial-gradient(circle_at_center,#1a1a2e_0%,#000_100%)]">
                {/* Background Map Overlay */}
                <div className="absolute inset-0 bg-[url('/landing/assets/italy-map-empty.jpg')] bg-no-repeat bg-center bg-cover opacity-20 mix-blend-overlay pointer-events-none"></div>

                <div className="container mx-auto px-4 relative z-10 flex flex-col items-center gap-12 md:gap-24">
                    <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold leading-tight uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">
                        L'Italia del Futuro <br /> <span className="text-[#00f3ff]">Ha Bisogno di Te</span>
                    </h1>
                    <p className="text-lg md:text-xl max-w-[600px] mx-auto opacity-90 text-gray-300 text-center">
                        La sicurezza digitale dell'Italia passa dalla consapevolezza di ognuno.
                        Ogni giorno, nuove minacce mettono a rischio identità e risparmi.
                        <br className="hidden md:block" />
                        DeepSafe ti dà gli strumenti per difendere te stesso e il tuo futuro.
                    </p>

                    <div className="flex flex-col md:flex-row gap-6 justify-center items-center w-full max-w-2xl mx-auto md:max-w-none">
                        <Link href="/dashboard" className="w-full md:w-auto text-center py-4 px-10 rounded-xl bg-[#00f3ff] text-black hover:bg-[#00d2dd] transition-all font-bold text-lg md:text-xl">
                            PROVA LA WEB APP
                        </Link>
                        <a href="#features" className="hidden md:inline-block py-4 px-10 rounded-xl border border-white text-white hover:bg-white hover:text-black transition-all font-bold text-lg md:text-xl">
                            SCOPRI DI PIÙ
                        </a>
                    </div>
                </div>
            </header>

            {/* Gameplay Preview Section */}
            <section id="features" className="py-20 bg-[#161622]">
                <div className="container mx-auto px-4">
                    <div className="flex flex-col md:flex-row items-center gap-10 md:gap-16">
                        <div className="flex-1 min-w-[300px]">
                            <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Potenzia le Tue Abilità</h2>
                            <p className="mb-6 text-gray-300 leading-relaxed">
                                Non è solo un corso, è una missione. Viaggia attraverso le regioni italiane in un futuro
                                cyberpunk.
                                Ogni territorio ha una minaccia diversa:
                            </p>
                            <ul className="mb-8 space-y-3">
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Sconfiggi i Malware
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Smaschera le Fake News
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Proteggi la tua Identità
                                </li>
                            </ul>
                        </div>
                        <div className="flex-1 w-full min-w-[300px]">
                            <div className="rounded-2xl overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.2)]">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-1.jpg`} alt="Gameplay Preview" className="w-full h-auto block" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Profile Section */}
            <section className="py-20 bg-[#0a0a12]">
                <div className="container mx-auto px-4">
                    <div className="flex flex-col md:flex-row-reverse items-center gap-10 md:gap-16">
                        <div className="flex-1 min-w-[300px]">
                            <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Forgia la Tua Leggenda</h2>
                            <p className="mb-6 text-gray-300 leading-relaxed">
                                Il tuo profilo non è solo una pagina, è la tua carta d'identità nel metaverso di DeepSafe.
                            </p>
                            <ul className="mb-8 space-y-3">
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Personalizza il tuo Avatar 3D
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Colleziona Badge Esclusivi
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Monitora i tuoi progressi
                                </li>
                            </ul>
                        </div>
                        <div className="flex-1 w-full min-w-[300px]">
                            <div className="rounded-2xl overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.2)]">
                                <video autoPlay loop muted playsInline className="w-full h-auto">
                                    <source src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/profile-video.mp4`} type="video/mp4" />
                                </video>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Leaderboard Section */}
            <LeaderboardSection variant="youth" />

            {/* Shop Section */}
            <section className="py-20 bg-[#161622]">
                <div className="container mx-auto px-4">
                    <div className="flex flex-col md:flex-row items-center gap-10 md:gap-16">
                        <div className="flex-1 min-w-[300px]">
                            <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Cyber Shop</h2>
                            <p className="mb-6 text-gray-300 leading-relaxed">
                                Usa i crediti guadagnati completando le missioni per potenziare il tuo arsenale.
                            </p>
                            <p className="mb-8 opacity-80 text-gray-400">
                                Accedi allo shop per sbloccare nuovi visualizzatori, skin per l'interfaccia e potenziamenti che
                                ti aiuteranno nelle sfide più difficili.
                            </p>
                            <Link href="/shop" className="inline-block py-3 px-8 rounded-xl bg-[#00f3ff] text-black hover:bg-[#00d2dd] transition-all font-bold text-lg">
                                ENTRA NELLO STORE
                            </Link>
                        </div>
                        <div className="flex-1 w-full min-w-[300px]">
                            <div className="rounded-2xl overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.2)]">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-shop.png`} alt="Shop Preview" className="w-full h-auto block" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Daily Streak Section */}
            <section className="py-20 bg-[#0a0a12]">
                <div className="container mx-auto px-4">
                    <div className="flex flex-col md:flex-row-reverse items-center gap-10 md:gap-16">
                        <div className="flex-1 min-w-[300px]">
                            <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Non Perdere la Scia</h2>
                            <p className="mb-6 text-gray-300 leading-relaxed">
                                Accedi ogni giorno per mantenere la tua streak. Sblocca casse misteriose e ricompense esclusive.
                            </p>
                            <ul className="mb-8 space-y-3">
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Ricompense Giornaliere
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Moltiplicatori di XP
                                </li>
                                <li className="flex items-center text-gray-300">
                                    <span className="text-[#00f3ff] mr-3">►</span> Casse Misteriose
                                </li>
                            </ul>
                        </div>
                        <div className="flex-1 w-full min-w-[300px]">
                            <div className="rounded-2xl overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.2)]">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-daily-streak.png`} alt="Daily Streak Preview" className="w-full h-auto block" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Map Section */}
            <section className="py-20 bg-[#0a0a12]">
                <div className="container mx-auto px-4 text-center">
                    <h2 className="text-3xl md:text-4xl font-bold mb-10 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Conquista i Territori</h2>
                    <div className="relative max-w-4xl mx-auto">
                        <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/italy-map-full.jpg`} alt="Mappa Italia Futura" className="rounded-2xl opacity-80 w-full h-auto" />
                        <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-black/80 p-6 rounded-xl border border-[#00f3ff] w-[90%] md:w-auto">
                            <h3 className="text-[#00f3ff] text-xl font-bold mb-2 uppercase">Missioni Attive</h3>
                            <p className="text-gray-300 text-sm md:text-base">Sblocca nuove regioni completando le sfide di sicurezza.</p>
                        </div>
                    </div>
                </div>
            </section>

            {/* Waitlist Section */}
            <section id="waitlist" className="py-20 bg-gradient-to-t from-black to-[#161622]">
                <div className="container mx-auto px-4 text-center flex flex-col items-center">
                    <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Sei Pronto a Giocare?</h2>
                    <p className="mb-10 max-w-lg mx-auto text-gray-300 text-center">
                    </p>

                    <div className="flex justify-center w-full">
                        <Link href="/dashboard" className="w-full max-w-[300px] text-center py-4 rounded-xl bg-[#00f3ff] text-black hover:bg-[#00d2dd] transition-all font-bold text-lg md:text-xl">
                            PROVA LA WEB APP
                        </Link>
                    </div>
                </div>
            </section>

            <SiteFooter />
        </div>
    );
}
