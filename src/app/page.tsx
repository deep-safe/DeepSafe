'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';

export default function LandingPage() {
    const [email, setEmail] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleWaitlistSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!email) {
            alert('Per favore inserisci un indirizzo email valido.');
            return;
        }

        setIsSubmitting(true);

        // Simulate API call or implement actual logic here
        // For now, mirroring the demo logic from main.js
        console.log(`Registered email (Demo): ${email}`);

        // Simulate network delay
        await new Promise(resolve => setTimeout(resolve, 1000));

        alert('Grazie per esserti iscritto alla lista d\'attesa! A breve ti invieremo tutte le istruzioni per accedere all\'app');
        setEmail('');
        setIsSubmitting(false);
    };

    return (
        <>
            {/* External Stylesheets for Landing Page */}
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/shared.css`} />
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/theme.css`} />
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700;900&display=swap" rel="stylesheet" />

            <div className="theme-youth min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
                {/* Navbar */}
                <nav className="absolute w-full z-10 py-5">
                    <div className="container mx-auto px-4 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/logo.png`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                            <span className="font-['Orbitron'] font-black text-xl md:text-2xl tracking-widest bg-gradient-to-r from-white via-blue-200 to-blue-500 bg-clip-text text-transparent">DEEPSAFE</span>
                        </div>
                        <a href="#waitlist" className="btn-primary px-10 py-5 text-base md:text-lg rounded-2xl font-bold text-white bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 shadow-lg shadow-cyan-500/30 hover:shadow-cyan-500/50 hover:-translate-y-0.5 transition-all duration-300">UNISCITI ALLA LISTA D'ATTESA</a>
                    </div>
                </nav>

                {/* Hero Section */}
                <header className="hero section min-h-[90vh] flex items-center text-center pt-32 pb-20 relative overflow-hidden bg-[radial-gradient(circle_at_center,#1a1a2e_0%,#000_100%)]">
                    {/* Background Map Overlay */}
                    <div className="absolute inset-0 bg-[url('/landing/assets/italy-map-empty.jpg')] bg-no-repeat bg-center bg-cover opacity-20 mix-blend-overlay pointer-events-none"></div>

                    <div className="container mx-auto px-4 relative z-10">
                        <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold mb-6 leading-tight uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">
                            L'Italia del Futuro <br /> <span className="text-[#00f3ff]">Ha Bisogno di Te</span>
                        </h1>
                        <p className="text-lg md:text-xl mb-10 max-w-2xl mx-auto opacity-90 text-gray-300">
                            Il mondo digitale è sotto attacco. Hacker, deepfake e blackout minacciano il nostro paese.
                            Hai le skills per salvarlo?
                        </p>
                        <div className="flex flex-col md:flex-row gap-6 justify-center items-center w-full max-w-2xl mx-auto md:max-w-none">
                            <a href="#waitlist" className="btn-primary w-full md:w-auto px-10 py-5 text-base md:text-lg font-bold text-white bg-gradient-to-r from-cyan-500 to-blue-600 rounded-2xl hover:from-cyan-400 hover:to-blue-500 shadow-xl shadow-cyan-500/40 hover:shadow-cyan-500/60 hover:-translate-y-1 transition-all duration-300 text-center">UNISCITI ALLA LISTA D'ATTESA</a>
                            <a href="#features" className="btn w-full md:w-auto px-10 py-5 text-base md:text-lg font-bold border-2 border-white text-white rounded-2xl hover:bg-white/10 hover:border-cyan-400 hover:text-cyan-400 hover:shadow-[0_0_25px_rgba(0,243,255,0.3)] transition-all duration-300 text-center">SCOPRI DI PIÙ</a>
                        </div>
                    </div>
                </header>

                {/* Gameplay Preview Section */}
                <section id="features" className="section py-20 bg-[#161622]">
                    <div className="container mx-auto px-4">
                        <div className="flex flex-col md:flex-row items-center gap-10 md:gap-16">
                            <div className="flex-1 min-w-[300px]">
                                <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Level Up Your Skills</h2>
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
                                {/* Placeholder for gameplay video/image */}
                                <div className="rounded-2xl overflow-hidden border-2 border-[#00f3ff] shadow-[0_0_20px_rgba(0,243,255,0.2)]">
                                    <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-1.jpg`} alt="Gameplay Preview" className="w-full h-auto block" />
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Map Section */}
                <section className="section py-20 bg-[#0a0a12]">
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
                <section id="waitlist" className="section py-20 bg-gradient-to-t from-black to-[#161622]">
                    <div className="container mx-auto px-4 text-center">
                        <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Sei Pronto a Giocare?</h2>
                        <p className="mb-10 max-w-lg mx-auto text-gray-300">
                            Iscriviti alla lista d'attesa per ottenere l'accesso anticipato e una skin esclusiva per il tuo avatar.
                        </p>

                        <form className="waitlist-form max-w-md mx-auto flex flex-col gap-4" onSubmit={handleWaitlistSubmit}>
                            <input
                                type="email"
                                placeholder="Inserisci la tua email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                className="w-full p-4 rounded bg-white/10 border border-white/20 text-white placeholder-gray-400 focus:outline-none focus:border-[#00f3ff] transition-colors"
                            />
                            <button type="submit" className="btn-primary w-full py-5 text-base md:text-lg font-bold text-white bg-gradient-to-r from-cyan-500 to-blue-600 rounded-2xl shadow-lg hover:shadow-xl hover:from-cyan-400 hover:to-blue-500 hover:-translate-y-0.5 transition-all duration-300 disabled:opacity-70 disabled:cursor-not-allowed" disabled={isSubmitting}>
                                {isSubmitting ? 'INVIO...' : 'UNISCITI ALLA LISTA D\'ATTESA'}
                            </button>
                        </form>
                    </div>
                </section>

                {/* Download Section */}
                {/* <section id="download" className="section py-20 bg-[#161622] text-center">
                    <div className="container mx-auto px-4">
                        <h2 className="text-3xl md:text-4xl font-bold mb-8 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Scarica DeepSafe Ora</h2>
                        <p className="mb-10 text-gray-300">Disponibile per iOS e Android.</p>
                        <div className="flex flex-col md:flex-row justify-center gap-5">
                            <a href="#" className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-900 transition-colors border border-gray-800">
                                <span className="text-2xl"></span> App Store
                            </a>
                            <a href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/deepsafe.apk`} className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-900 transition-colors border border-gray-800">
                                <span className="text-2xl">🤖</span> Scarica APK
                            </a>
                            <Link href="/dashboard" className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-900 transition-colors border border-gray-800">
                                <span className="text-2xl">🌐</span> Web App
                            </Link>
                        </div>
                    </div>
                </section> */}

                <footer className="py-10 text-center border-t border-[#333] text-gray-500 bg-[#0a0a12]">
                    <div className="container mx-auto px-4">
                        <p>&copy; 2025 DeepSafe. All rights reserved. | <Link href="/privacy-policy" className="hover:text-gray-300 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-gray-300 transition-colors">Terms</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
