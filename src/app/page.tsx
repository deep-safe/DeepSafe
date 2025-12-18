'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';

import { WaitlistSuccessModal } from '@/components/landing/WaitlistSuccessModal';
import Countdown from '@/components/landing/Countdown';

export default function LandingPage() {
    const [email, setEmail] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [showSuccessModal, setShowSuccessModal] = useState(false);

    const handleWaitlistSubmit = async (e: React.FormEvent) => {
        e.preventDefault(); // Prevent default form submission which would reload the page
        if (!email) {
            alert('Per favore inserisci un indirizzo email valido.');
            return;
        }

        setIsSubmitting(true);

        try {
            const response = await fetch("https://formspree.io/f/mblnawdv", {
                method: "POST",
                body: JSON.stringify({ email }),
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            });

            if (response.ok) {
                setShowSuccessModal(true);
                setEmail('');
            } else {
                alert('C\'è stato un problema. Riprova più tardi.');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('Errore di connessione. Riprova più tardi.');
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <>
            {/* External Stylesheets for Landing Page */}
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/shared.css`} />
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/theme.css`} />
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700;900&display=swap" rel="stylesheet" />

            <WaitlistSuccessModal
                isOpen={showSuccessModal}
                onClose={() => setShowSuccessModal(false)}
            />

            <div className="theme-youth min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
                {/* Navbar */}
                <nav className="absolute w-full z-10 py-5">
                    <div className="container mx-auto px-4 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/new-logo.png`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                            <span className="font-['Orbitron'] font-black text-xl md:text-2xl tracking-widest bg-gradient-to-r from-white via-blue-200 to-blue-500 bg-clip-text text-transparent">DEEPSAFE</span>
                        </div>
                        <a href="#waitlist" className="btn btn-primary hidden md:inline-block" style={{ fontSize: '1.2rem', padding: '15px 40px' }}>ISCRIVITI ALLA LISTA D'ATTESA</a>
                    </div>
                </nav>

                {/* Hero Section */}
                <header className="hero section min-h-[90vh] flex items-center text-center pt-32 pb-20 relative overflow-hidden bg-[radial-gradient(circle_at_center,#1a1a2e_0%,#000_100%)]">
                    {/* Background Map Overlay */}
                    <div className="absolute inset-0 bg-[url('/landing/assets/italy-map-empty.jpg')] bg-no-repeat bg-center bg-cover opacity-20 mix-blend-overlay pointer-events-none"></div>

                    <div className="container mx-auto px-4 relative z-10 flex flex-col items-center gap-12 md:gap-24">
                        <h1 className="text-4xl md:text-6xl lg:text-7xl font-bold leading-tight uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">
                            L'Italia del Futuro <br /> <span className="text-[#00f3ff]">Ha Bisogno di Te</span>
                        </h1>
                        <p className="text-lg md:text-xl max-w-[600px] mx-auto opacity-90 text-gray-300 text-center">
                            Il mondo digitale è sotto attacco. Hacker, deepfake e blackout minacciano il nostro paese.
                            Hai le skills per salvarlo?
                        </p>

                        <Countdown targetDate="2025-12-24T12:00:00" />

                        <div className="flex flex-col md:flex-row gap-6 justify-center items-center w-full max-w-2xl mx-auto md:max-w-none">
                            <a href="#waitlist" className="btn btn-primary" style={{ fontSize: '1.2rem', padding: '15px 40px' }}>ISCRIVITI ALLA LISTA D'ATTESA</a>
                            <a href="#features" className="btn hidden md:inline-block" style={{ border: '1px solid white', color: 'white', fontSize: '1.2rem', padding: '15px 40px' }}>SCOPRI DI PIÙ</a>
                        </div>
                    </div>
                </header>

                {/* Gameplay Preview Section */}
                <section id="features" className="section py-20 bg-[#161622]">
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

                {/* Profile Section (from target-youth.html, adding back missing section for completeness) */}
                <section className="section py-20 bg-[#0a0a12]">
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

                {/* Shop Section */}
                <section className="section py-20 bg-[#161622]">
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
                                <a href="#waitlist" className="btn btn-primary" style={{ fontSize: '1rem', padding: '12px 30px' }}>ENTRA NELLO STORE</a>
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
                <section className="section py-20 bg-[#0a0a12]">
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
                    <div className="container mx-auto px-4 text-center flex flex-col items-center">
                        <h2 className="text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide text-white drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]">Sei Pronto a Giocare?</h2>
                        <p className="mb-10 max-w-lg mx-auto text-gray-300 text-center">
                            Iscriviti alla lista d'attesa per ottenere un premio esclusivo e l’accesso anticipato all’app.
                        </p>

                        <form className="waitlist-form w-full flex flex-col gap-4" style={{ maxWidth: '400px' }} onSubmit={handleWaitlistSubmit}>
                            <input
                                type="email"
                                placeholder="Inserisci la tua email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                className="w-full p-4 rounded bg-white/10 border border-white/20 text-white placeholder-gray-400 focus:outline-none focus:border-[#00f3ff] transition-colors"
                            />
                            <button type="submit" className="btn btn-primary" style={{ width: '100%' }} disabled={isSubmitting}>
                                {isSubmitting ? 'INVIO...' : 'FAI RICHIESTA PER PARTECIPARE'}
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
                        <p>&copy; 2025 DeepSafe. Tutti i diritti riservati. | <Link href="/privacy-policy" className="hover:text-gray-300 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-gray-300 transition-colors">Termini e Condizioni</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
