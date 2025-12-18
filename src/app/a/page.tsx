'use client';

import React, { useState } from 'react';
import Link from 'next/link';

import { WaitlistSuccessModal } from '@/components/landing/WaitlistSuccessModal';
import Countdown from '@/components/landing/Countdown';
import LeaderboardSection from '@/components/landing/LeaderboardSection';

export default function AdultLandingPage() {
    const [email, setEmail] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [showSuccessModal, setShowSuccessModal] = useState(false);

    const handleWaitlistSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!email) {
            alert('Per favore inserisci un indirizzo email valido.');
            return;
        }

        setIsSubmitting(true);

        try {
            const response = await fetch('https://formspree.io/f/meoyzdqw', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ email })
            });

            if (response.ok) {
                setShowSuccessModal(true);
                setEmail('');
            } else {
                alert('Si è verificato un errore. Riprova più tardi.');
            }
        } catch (error) {
            console.error('Error submitting form:', error);
            alert('Errore di connessione. Riprova più tardi.');
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <>
            {/* External Stylesheets */}
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/shared.css`} />
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/theme.css`} />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />

            <WaitlistSuccessModal
                isOpen={showSuccessModal}
                onClose={() => setShowSuccessModal(false)}
            />

            <div className="theme-adult min-h-screen w-full bg-slate-50 text-slate-900 font-['Inter'] selection:bg-indigo-100 selection:text-indigo-900">
                {/* Navbar */}
                <nav className="w-full py-6 bg-white/90 backdrop-blur-md sticky top-0 z-50 border-b border-gray-100">
                    <div className="container mx-auto px-6 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/logo.png`} alt="DeepSafe Logo" className="h-10 w-10" />
                            <span className="font-bold text-xl tracking-tight text-slate-900">DEEPSAFE</span>
                        </div>
                        <a href="#waitlist" className="hidden sm:inline-flex items-center justify-center px-10 py-3 text-sm font-semibold text-white transition-all duration-200 bg-indigo-600 rounded-full hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-600 shadow-lg shadow-indigo-600/20">
                            Accesso Anticipato
                        </a>
                    </div>
                </nav>

                {/* Hero Section */}
                {/* Hero Section */}
                {/* Hero Section */}
                <header className="relative pt-24 pb-32 lg:pt-32 lg:pb-40 overflow-hidden bg-white">
                    <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top_right,_var(--tw-gradient-stops))] from-indigo-50/50 via-white to-white opacity-80"></div>
                    <div className="container mx-auto px-6 relative">
                        <div className="flex flex-col lg:flex-row items-center gap-16 md:gap-24">
                            <div className="flex-1 max-w-2xl text-center lg:text-left flex flex-col gap-10">
                                <div className="inline-flex items-center gap-2 px-4 py-1.5 mb-8 rounded-full bg-indigo-50 border border-indigo-100 text-indigo-700 text-sm font-semibold tracking-wide self-center lg:self-start">
                                    <span className="flex h-2 w-2 rounded-full bg-indigo-600 animate-pulse"></span>
                                    Formazione Professionale
                                </div>
                                <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold tracking-tight text-slate-900 leading-[1.1]">
                                    Cyber Security <br />
                                    <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-600 to-blue-600">
                                        per l'Era Moderna
                                    </span>
                                </h1>
                                <p className="text-xl md:text-2xl text-slate-600 leading-relaxed font-light max-w-xl mx-auto lg:mx-0">
                                    Metti al sicuro la tua carriera e la tua identità digitale.
                                    Un percorso formativo avanzato, progettato per professionisti che non possono permettersi errori.
                                </p>

                                <Countdown targetDate="2025-12-24T12:00:00" variant="adult" />

                                <div className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start pt-4">
                                    <a href="#waitlist" className="inline-flex items-center justify-center px-10 py-5 text-lg font-bold !text-white hover:text-white transition-all duration-300 bg-slate-900 rounded-xl hover:bg-slate-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-slate-900 shadow-xl hover:shadow-2xl hover:-translate-y-1 group">
                                        Unisciti alla Waitlist
                                        <svg className="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 8l4 4m0 0l-4 4m4-4H3" /></svg>
                                    </a>
                                </div>
                                <div className="mt-8 flex flex-wrap justify-center lg:justify-start gap-x-8 gap-y-4 text-sm text-slate-500 font-medium">
                                    <div className="flex items-center gap-2">
                                        <svg className="w-5 h-5 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                                        Certificati Verificati
                                    </div>
                                    <div className="flex items-center gap-2">
                                        <svg className="w-5 h-5 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
                                        Simulazioni con IA
                                    </div>
                                </div>
                            </div>
                            <div className="flex-1 w-full max-w-[500px] lg:max-w-none relative mt-10 lg:mt-0">
                                <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[120%] h-[120%] bg-indigo-600/5 rounded-full blur-3xl"></div>
                                <img
                                    src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-2.jpg`}
                                    alt="Professional Dashboard"
                                    className="relative rounded-2xl shadow-2xl shadow-indigo-900/10 border border-slate-200/60 w-full hover:scale-[1.02] transition-transform duration-700 object-cover"
                                />
                            </div>
                        </div>
                    </div>
                </header>

                {/* Ecosystem Grid Section */}
                <section className="py-32 bg-slate-50 border-y border-slate-200/60">
                    <div className="container mx-auto px-6">
                        <div className="text-center max-w-3xl mx-auto mb-24">
                            <span className="text-indigo-600 font-bold tracking-widest uppercase text-sm mb-4 block">Ecosistema Integrato</span>
                            <h2 className="text-3xl md:text-5xl font-bold text-slate-900 mb-6 tracking-tight">Protezione Digitale Completa</h2>
                            <p className="text-xl text-slate-600 font-light">
                                Un ecosistema completo che ti prepara ad affrontare le minacce reali del web, dal phishing all'ingegneria sociale.
                            </p>
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 items-start">
                            {/* Card 1 */}
                            <div className="group bg-white rounded-2xl p-6 shadow-md hover:shadow-2xl transition-all duration-300 border border-slate-100 hover:border-indigo-100 hover:-translate-y-1 h-full flex flex-col">
                                <div className="rounded-xl overflow-hidden bg-slate-100 mb-8 border border-slate-200 aspect-[16/10] flex items-center justify-center relative shadow-inner">
                                    <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-shop.png`} alt="Marketplace" className="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
                                </div>
                                <div className="flex-1 flex flex-col">
                                    <h3 className="text-2xl font-bold text-slate-900 mb-3 group-hover:text-indigo-700 transition-colors">Strumenti Difensivi</h3>
                                    <p className="text-slate-600 text-base leading-relaxed">Accedi a strumenti avanzati per monitorare e proteggere i tuoi account in tempo reale.</p>
                                </div>
                            </div>

                            {/* Card 2 */}
                            <div className="group bg-white rounded-2xl p-6 shadow-md hover:shadow-2xl transition-all duration-300 border border-slate-100 hover:border-indigo-100 hover:-translate-y-1 h-full flex flex-col">
                                <div className="rounded-xl overflow-hidden bg-slate-100 mb-8 border border-slate-200 aspect-[16/10] relative shadow-inner">
                                    <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-daily-streak.png`} alt="Daily Progress" className="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
                                </div>
                                <div className="flex-1 flex flex-col">
                                    <h3 className="text-2xl font-bold text-slate-900 mb-3 group-hover:text-indigo-700 transition-colors">Micro-Training Quotidiano</h3>
                                    <p className="text-slate-600 text-base leading-relaxed">Costruisci abitudini di sicurezza solide con brevi sessioni giornaliere (5 min) ad alto impatto.</p>
                                </div>
                            </div>

                            {/* Card 3 */}
                            <div className="group bg-white rounded-2xl p-6 shadow-md hover:shadow-2xl transition-all duration-300 border border-slate-100 hover:border-indigo-100 hover:-translate-y-1 h-full flex flex-col">
                                <div className="rounded-xl overflow-hidden bg-slate-100 mb-8 border border-slate-200 aspect-[16/10] relative shadow-inner">
                                    <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-1.jpg`} alt="Real World Scenarios" className="absolute inset-0 w-full h-full object-cover group-hover:scale-105 transition-transform duration-700" />
                                </div>
                                <div className="flex-1 flex flex-col">
                                    <h3 className="text-2xl font-bold text-slate-900 mb-3 group-hover:text-indigo-700 transition-colors">Scenari del Mondo Reale</h3>
                                    <p className="text-slate-600 text-base leading-relaxed">Mettiti alla prova con scenari realistici ambientati nel contesto lavorativo italiano.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Leaderboard Section */}
                <LeaderboardSection variant="adult" />

                {/* Features List Section */}
                <section className="section py-20 bg-white border-y border-slate-100">
                    <div className="container mx-auto px-6">
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
                            <div className="flex flex-col gap-4">
                                <div className="w-12 h-12 bg-indigo-50 rounded-xl flex items-center justify-center text-indigo-600 mb-2">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" /></svg>
                                </div>
                                <h3 className="text-lg font-bold text-slate-900">Livello Enterprise</h3>
                                <p className="text-slate-600 text-sm leading-relaxed">Protocolli di sicurezza standard industriale spiegati in modo che tu possa applicarli subito.</p>
                            </div>
                            <div className="flex flex-col gap-4">
                                <div className="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600 mb-2">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
                                </div>
                                <h3 className="text-lg font-bold text-slate-900">Vantaggio di Carriera</h3>
                                <p className="text-slate-600 text-sm leading-relaxed">La competenza in cybersecurity è oggi una delle skill più richieste e pagate nel mercato del lavoro.</p>
                            </div>
                            <div className="flex flex-col gap-4">
                                <div className="w-12 h-12 bg-indigo-50 rounded-xl flex items-center justify-center text-indigo-600 mb-2">
                                    <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" /></svg>
                                </div>
                                <h3 className="text-lg font-bold text-slate-900">Controllo dei Dati</h3>
                                <p className="text-slate-600 text-sm leading-relaxed">Riprendi il controllo delle tue informazioni personali sparse nel web e proteggi la tua reputazione.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Premium Waitlist Section */}
                <section id="waitlist" className="py-24 md:py-32 bg-slate-900 relative overflow-hidden">
                    {/* Background effects */}
                    <div className="absolute top-0 right-0 -mr-20 -mt-20 w-[600px] h-[600px] bg-indigo-600/20 rounded-full blur-[100px] pointer-events-none"></div>
                    <div className="absolute bottom-0 left-0 -ml-20 -mb-20 w-[600px] h-[600px] bg-blue-600/20 rounded-full blur-[100px] pointer-events-none"></div>

                    <div className="container mx-auto px-6 relative z-10">
                        <div className="max-w-5xl mx-auto flex flex-col items-center text-center">
                            {/* Inner glow */}
                            <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-px bg-gradient-to-r from-transparent via-white/20 to-transparent"></div>

                            <div className="mb-12">
                                <h2 className="text-3xl md:text-5xl font-bold text-white mb-6 tracking-tight leading-tight">
                                    Proteggi la tua <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-blue-400">Presenza Digitale</span>
                                </h2>
                                <p className="text-lg md:text-xl text-slate-300 max-w-2xl mx-auto font-light leading-relaxed text-center">
                                    Unisciti a migliaia di professionisti che stanno già mettendo al sicuro il loro futuro.
                                    <br className="hidden md:block" /> Accesso anticipato e guida esclusiva inclusi.
                                </p>
                            </div>

                            <form className="max-w-2xl mx-auto flex flex-col sm:flex-row gap-4 relative z-20" onSubmit={handleWaitlistSubmit}>
                                <div className="flex-1 relative group">
                                    <div className="absolute -inset-0.5 bg-gradient-to-r from-indigo-500 to-blue-500 rounded-xl blur opacity-30 group-hover:opacity-60 transition duration-1000 group-hover:duration-200"></div>
                                    <input
                                        type="email"
                                        id="email"
                                        placeholder="la tua email qui"
                                        required
                                        className="relative w-full bg-slate-800 border border-slate-700 text-white placeholder-slate-500 text-lg rounded-xl px-6 py-4 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all shadow-xl"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                    />
                                </div>
                                <button
                                    type="submit"
                                    className="sm:w-auto bg-indigo-600 hover:bg-indigo-500 text-white text-lg font-bold px-16 py-5 rounded-xl shadow-lg shadow-indigo-600/30 transition-all duration-200 hover:-translate-y-0.5 whitespace-nowrap"
                                    disabled={isSubmitting}
                                >
                                    {isSubmitting ? '...' : 'Inizia Ora'}
                                </button>
                            </form>
                            <p className="text-center text-xs text-slate-500 mt-6 max-w-lg mx-auto">
                                🔒 La tua email è al sicuro. Contattiamo solo per aggiornamenti di valore essenziali.
                            </p>
                        </div>
                    </div>
                </section>

                <footer className="py-12 bg-slate-900 border-t border-slate-800 text-slate-500 text-sm">
                    <div className="container mx-auto px-6 text-center">
                        <p>&copy; 2025 DeepSafe. Professional Security Training.</p>
                    </div>
                </footer>
            </div>
        </>
    );
}
