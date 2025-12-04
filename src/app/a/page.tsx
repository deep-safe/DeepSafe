'use client';

import React, { useState } from 'react';
import Link from 'next/link';

export default function AdultLandingPage() {
    const [email, setEmail] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleWaitlistSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!email) {
            alert('Per favore inserisci un indirizzo email valido.');
            return;
        }

        setIsSubmitting(true);

        // Simulate API call
        console.log(`Registered email (Adult): ${email}`);
        await new Promise(resolve => setTimeout(resolve, 1000));

        alert('Grazie per esserti iscritto alla lista d\'attesa! A breve ti invieremo tutte le istruzioni per accedere all\'app');
        setEmail('');
        setIsSubmitting(false);
    };

    return (
        <>
            {/* External Stylesheets */}
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/shared.css`} />
            <link rel="stylesheet" href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/css/theme.css`} />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap" rel="stylesheet" />

            <div className="theme-adult min-h-screen w-full bg-white text-gray-800 font-['Inter']">
                {/* Navbar */}
                <nav className="w-full py-5 border-b border-gray-100 bg-white/80 backdrop-blur-md sticky top-0 z-50">
                    <div className="container mx-auto px-4 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/logo.png`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                            <span className="font-['Inter'] font-extrabold text-xl md:text-2xl tracking-wide text-gray-900">DEEPSAFE</span>
                        </div>
                        <a href="#waitlist" className="btn-primary px-10 py-5 text-base md:text-lg rounded-2xl font-bold text-white bg-gradient-to-r from-blue-600 via-indigo-600 to-violet-700 hover:from-blue-500 hover:via-indigo-500 hover:to-violet-600 shadow-lg shadow-blue-600/20 hover:shadow-blue-600/40 hover:-translate-y-0.5 transition-all duration-300 bg-[length:200%_auto] hover:bg-right">UNISCITI ALLA LISTA D'ATTESA</a>
                    </div>
                </nav>

                <header className="hero section py-20 md:py-32 bg-slate-50 border-b border-gray-200">
                    <div className="container mx-auto px-4">
                        <div className="flex flex-col md:flex-row items-center gap-12 md:gap-16">
                            <div className="flex-1 min-w-[300px]">
                                <h1 className="text-4xl md:text-5xl lg:text-6xl font-extrabold mb-6 leading-tight text-gray-900">
                                    Il Tuo Futuro Digitale <br /> <span className="text-blue-600">È Al Sicuro?</span>
                                </h1>
                                <p className="text-lg md:text-xl mb-8 text-gray-600 leading-relaxed max-w-xl">
                                    In un mondo sempre più connesso, la sicurezza non è un optional.
                                    Impara a proteggere i tuoi dati, la tua carriera e la tua privacy con un percorso formativo
                                    avanzato e coinvolgente.
                                </p>
                                <div className="flex flex-col sm:flex-row gap-6">
                                    <a href="#waitlist" className="btn-primary inline-block w-full sm:w-auto px-10 py-5 text-base md:text-lg font-bold text-white bg-gradient-to-r from-blue-600 via-indigo-600 to-violet-700 rounded-2xl hover:from-blue-500 hover:via-indigo-500 hover:to-violet-600 shadow-xl shadow-blue-600/30 hover:shadow-blue-600/50 hover:-translate-y-1 transition-all duration-300 text-center bg-[length:200%_auto] hover:bg-right">UNISCITI ALLA LISTA D'ATTESA</a>
                                </div>
                            </div>
                            <div className="flex-1 w-full min-w-[300px]">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-2.jpg`} alt="App Dashboard"
                                    className="rounded-xl shadow-2xl w-full h-auto" />
                            </div>
                        </div>
                    </div>
                </header>

                {/* Value Props */}
                <section className="section py-20 bg-white">
                    <div className="container mx-auto px-4">
                        <div className="text-center mb-16">
                            <h2 className="text-3xl md:text-4xl font-bold mb-4 text-gray-900">Perché DeepSafe?</h2>
                            <p className="text-gray-600 max-w-2xl mx-auto text-lg">
                                Un approccio pratico e moderno all'educazione digitale, progettato per chi lavora e vive online.
                            </p>
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                            <div className="card p-8 bg-white rounded-xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                                <div className="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mb-6">
                                    <span className="text-2xl">🛡️</span>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Cyber Security Reale</h3>
                                <p className="text-gray-600 leading-relaxed">Simulazioni realistiche di attacchi phishing, malware e violazioni dati per
                                    imparare a riconoscerli all'istante.</p>
                            </div>
                            <div className="card p-8 bg-white rounded-xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                                <div className="w-12 h-12 bg-emerald-50 rounded-lg flex items-center justify-center mb-6">
                                    <span className="text-2xl">🤖</span>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Intelligenza Artificiale</h3>
                                <p className="text-gray-600 leading-relaxed">Comprendi come funziona l'IA, come usarla a tuo vantaggio e come difenderti
                                    dai deepfake.</p>
                            </div>
                            <div className="card p-8 bg-white rounded-xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                                <div className="w-12 h-12 bg-orange-50 rounded-lg flex items-center justify-center mb-6">
                                    <span className="text-2xl">📈</span>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Micro-Learning</h3>
                                <p className="text-gray-600 leading-relaxed">Lezioni brevi ed efficaci ("pillole") che si adattano ai tuoi ritmi
                                    lavorativi. 5 minuti al giorno.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Map/Context Section */}
                <section className="section py-20 bg-slate-50">
                    <div className="container mx-auto px-4">
                        <div className="flex flex-col md:flex-row items-center gap-12 md:gap-16">
                            <div className="flex-1 w-full min-w-[300px]">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/region.jpg`} alt="Mappa Regionale"
                                    className="rounded-xl shadow-xl w-full h-auto" />
                            </div>
                            <div className="flex-1 min-w-[300px]">
                                <h2 className="text-3xl md:text-4xl font-bold mb-6 text-gray-900">Risolvi Problemi Reali</h2>
                                <p className="mb-6 text-gray-600 text-lg leading-relaxed">
                                    Non è solo teoria. In DeepSafe ti troverai a gestire crisi digitali in un'Italia futuristica.
                                    Ogni provincia rappresenta una sfida diversa, dalla gestione delle password alla protezione
                                    delle infrastrutture critiche.
                                </p>
                                <p className="text-gray-600 text-lg leading-relaxed">
                                    Metti alla prova le tue competenze e ottieni certificazioni verificate man mano che avanzi.
                                </p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Waitlist Section */}
                <section id="waitlist" className="section py-20 bg-white">
                    <div className="container mx-auto px-4">
                        <div className="bg-blue-600 rounded-2xl p-10 md:p-16 text-center text-white shadow-xl max-w-4xl mx-auto">
                            <h2 className="text-3xl md:text-4xl font-bold mb-4 text-white">Proteggi la tua Presenza Digitale</h2>
                            <p className="mb-8 opacity-90 max-w-2xl mx-auto text-lg">
                                Iscriviti ora per ricevere l'accesso prioritario al lancio e una guida esclusiva sulla sicurezza
                                informatica per professionisti.
                            </p>

                            <form className="waitlist-form max-w-lg mx-auto flex flex-col sm:flex-row gap-4" onSubmit={handleWaitlistSubmit}>
                                <input
                                    type="email"
                                    placeholder="La tua email professionale"
                                    required
                                    className="flex-1 p-4 rounded-lg border-none text-gray-900 placeholder-gray-500 focus:ring-2 focus:ring-white/50 outline-none"
                                    value={email}
                                    onChange={(e) => setEmail(e.target.value)}
                                />
                                <button type="submit" className="btn w-full sm:w-auto px-10 py-5 text-white font-bold text-base md:text-lg bg-gradient-to-r from-blue-600 via-indigo-600 to-violet-700 rounded-2xl hover:from-blue-500 hover:via-indigo-500 hover:to-violet-600 shadow-lg hover:shadow-xl hover:-translate-y-0.5 transition-all duration-300 disabled:opacity-70 disabled:cursor-not-allowed bg-[length:200%_auto] hover:bg-right" disabled={isSubmitting}>
                                    {isSubmitting ? '...' : 'Iscriviti'}
                                </button>
                            </form>
                        </div>
                    </div>
                </section>
                {/* Download Section */}
                {/* <section id="download" className="section py-20 bg-slate-50 text-center">
                    <div className="container mx-auto px-4">
                        <h2 className="text-3xl md:text-4xl font-bold mb-6 text-gray-900">Scarica DeepSafe Ora</h2>
                        <p className="mb-10 text-gray-600 text-lg">Disponibile per iOS e Android.</p>
                        <div className="flex flex-col md:flex-row justify-center gap-5">
                            <a href="#" className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-800 transition-colors shadow-lg">
                                <span className="text-2xl"></span> App Store
                            </a>
                            <a href={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/deepsafe.apk`} className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-800 transition-colors shadow-lg">
                                <span className="text-2xl">🤖</span> Scarica APK
                            </a>
                            <Link href="/dashboard" className="btn flex items-center justify-center gap-3 px-6 py-3 bg-black text-white rounded-xl hover:bg-gray-800 transition-colors shadow-lg">
                                <span className="text-2xl">🌐</span> Web App
                            </Link>
                        </div>
                    </div>
                </section> */}

                <footer className="py-10 text-center bg-white border-t border-gray-100 text-gray-500">
                    <div className="container mx-auto px-4">
                        <p>&copy; 2025 DeepSafe. All rights reserved. | <Link href="/privacy-policy" className="hover:text-gray-800 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-gray-800 transition-colors">Terms</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
