'use client';

import React, { useState } from 'react';
import Link from 'next/link';

export default function SeniorLandingPage() {
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
        console.log(`Registered email (Senior): ${email}`);
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
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet" />

            <div className="theme-senior min-h-screen w-full bg-white text-gray-800 font-['Roboto']">
                {/* Navbar */}
                <nav className="w-full py-4 bg-white shadow-sm sticky top-0 z-50">
                    <div className="container mx-auto px-4 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/icon.svg`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                            <span className="font-['Roboto'] font-bold text-xl md:text-2xl tracking-wide text-emerald-800">DEEPSAFE</span>
                        </div>
                        <a href="#download" className="btn-primary px-6 py-3 text-base md:text-lg rounded-lg font-medium bg-emerald-600 text-white hover:bg-emerald-700 transition-colors">SCARICA L'APP</a>
                    </div>
                </nav>

                {/* Hero Section */}
                <header className="hero section py-16 md:py-24 bg-white">
                    <div className="container mx-auto px-4">
                        <div className="flex flex-col md:flex-row items-center gap-12 md:gap-16">
                            <div className="flex-1 min-w-[300px]">
                                <h1 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6 leading-tight text-emerald-900">
                                    Naviga in Sicurezza,<br /> Senza Paura.
                                </h1>
                                <p className="text-xl md:text-2xl mb-8 text-gray-600 leading-relaxed">
                                    Internet può sembrare complicato, ma non deve essere pericoloso.
                                    Impara a riconoscere le truffe, proteggere i tuoi risparmi e navigare serenamente con la nostra
                                    app semplice e intuitiva.
                                </p>
                                <a href="#download" className="btn-primary inline-block px-8 py-4 text-xl font-medium bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors shadow-lg shadow-emerald-600/20">SCARICA L'APP</a>
                                <p className="mt-4 text-base text-gray-500">* Nessuna carta di credito richiesta</p>
                            </div>
                            <div className="flex-1 w-full min-w-[300px] text-center">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-1.jpg`} alt="Applicazione Facile da Usare"
                                    className="rounded-2xl shadow-2xl max-w-[90%] mx-auto h-auto" />
                            </div>
                        </div>
                    </div>
                </header>

                {/* Features Section */}
                <section className="section py-20 bg-gray-50">
                    <div className="container mx-auto px-4">
                        <h2 className="text-center text-3xl md:text-4xl font-bold mb-12 text-emerald-900">Cosa Imparerai</h2>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
                            <div className="text-center p-6 bg-white rounded-xl shadow-sm">
                                <div className="w-20 h-20 bg-emerald-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <span className="text-4xl">✉️</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-emerald-800">Stop alle Email False</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Impara a distinguere una email vera da un tentativo di "phishing" che vuole rubare i tuoi dati.
                                </p>
                            </div>
                            <div className="text-center p-6 bg-white rounded-xl shadow-sm">
                                <div className="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <span className="text-4xl">🔒</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-red-800">Password Sicure</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Scopri come creare password impossibili da indovinare ma facili da ricordare per te.</p>
                            </div>
                            <div className="text-center p-6 bg-white rounded-xl shadow-sm">
                                <div className="w-20 h-20 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <span className="text-4xl">📱</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-blue-800">Social Consapevole</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Usa i social network senza rischi, evitando di condividere informazioni troppo personali.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* How it works */}
                <section className="section py-20 bg-white">
                    <div className="container mx-auto px-4">
                        <div className="bg-white border-2 border-gray-200 rounded-3xl overflow-hidden flex flex-col md:flex-row shadow-lg">
                            <div className="flex-1 min-w-[300px] h-64 md:h-auto">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/region.jpg`} alt="Mappa Italia"
                                    className="w-full h-full object-cover" />
                            </div>
                            <div className="flex-1 p-8 md:p-12">
                                <h2 className="text-3xl md:text-4xl font-bold mb-6 text-emerald-900">Un Viaggio nell'Italia del Futuro</h2>
                                <p className="mb-6 text-xl text-gray-600 leading-relaxed">
                                    L'app è strutturata come un gioco semplice. Viaggerai attraverso le regioni italiane risolvendo
                                    piccoli problemi quotidiani.
                                </p>
                                <p className="mb-8 text-xl text-gray-600 leading-relaxed">
                                    Niente termini tecnici incomprensibili. Solo esempi pratici e consigli utili per la vita di
                                    tutti i giorni.
                                </p>
                                <ul className="space-y-4">
                                    <li className="flex items-center text-xl text-gray-700">
                                        <span className="text-emerald-600 text-2xl mr-4 font-bold">✓</span>
                                        Lezioni di 5 minuti
                                    </li>
                                    <li className="flex items-center text-xl text-gray-700">
                                        <span className="text-emerald-600 text-2xl mr-4 font-bold">✓</span>
                                        Adatto a tutti i livelli
                                    </li>
                                    <li className="flex items-center text-xl text-gray-700">
                                        <span className="text-emerald-600 text-2xl mr-4 font-bold">✓</span>
                                        Divertente e rilassante
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Waitlist Section */}
                <section id="waitlist" className="section py-20 bg-emerald-50">
                    <div className="container mx-auto px-4 text-center">
                        <h2 className="text-3xl md:text-4xl font-bold mb-6 text-emerald-900">Unisciti alla Lista d'Attesa</h2>
                        <p className="mb-10 text-xl text-gray-600 max-w-2xl mx-auto">
                            Lascia la tua email per sapere quando l'app sarà disponibile. <br className="hidden md:block" />
                            È gratuito e senza impegno.
                        </p>

                        <form className="waitlist-form max-w-lg mx-auto bg-white p-8 rounded-2xl shadow-lg" onSubmit={handleWaitlistSubmit}>
                            <label htmlFor="email" className="block text-left mb-3 font-medium text-gray-700 text-lg">Il tuo indirizzo email</label>
                            <input
                                type="email"
                                id="email"
                                placeholder="nome@esempio.it"
                                required
                                className="w-full p-4 mb-6 rounded-lg border border-gray-300 text-gray-900 text-lg focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />
                            <button type="submit" className="btn-primary w-full py-4 text-xl font-bold bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors disabled:opacity-70" disabled={isSubmitting}>
                                {isSubmitting ? '...' : 'Tienimi Informato'}
                            </button>
                        </form>
                    </div>
                </section>

                {/* Download Section */}
                <section id="download" className="section py-20 bg-gray-50 text-center">
                    <div className="container mx-auto px-4">
                        <h2 className="text-3xl md:text-4xl font-bold mb-8 text-emerald-900">Scarica DeepSafe Ora</h2>
                        <p className="mb-10 text-xl text-gray-600">Disponibile per iOS e Android.</p>
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
                </section>

                <footer className="py-10 text-center text-gray-500 text-sm md:text-base border-t border-gray-200 bg-white">
                    <div className="container mx-auto px-4">
                        <p>&copy; 2025 DeepSafe. All rights reserved. | <Link href="/privacy-policy" className="hover:text-emerald-800 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-emerald-800 transition-colors">Terms</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
