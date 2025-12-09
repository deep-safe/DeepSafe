'use client';

import React, { useState } from 'react';
import Link from 'next/link';

import { WaitlistSuccessModal } from '@/components/landing/WaitlistSuccessModal';

export default function SeniorLandingPage() {
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
            const response = await fetch('https://formspree.io/f/xovglbqo', {
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
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet" />

            <WaitlistSuccessModal
                isOpen={showSuccessModal}
                onClose={() => setShowSuccessModal(false)}
            />

            <div className="theme-senior min-h-screen w-full bg-white text-gray-800 font-['Roboto']">
                {/* Navbar */}
                <nav className="w-full py-4 bg-white shadow-sm sticky top-0 z-50">
                    <div className="container mx-auto px-4 flex justify-between items-center">
                        <div className="flex items-center gap-3">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/logo.png`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                            <span className="font-['Roboto'] font-bold text-xl md:text-2xl tracking-wide text-emerald-800">DEEPSAFE</span>
                        </div>
                        <a href="#waitlist" className="btn-primary px-10 py-5 text-base md:text-lg rounded-2xl font-bold bg-emerald-600 text-white hover:bg-emerald-700 shadow-lg shadow-emerald-600/20 hover:shadow-emerald-600/40 hover:-translate-y-0.5 transition-all duration-300">UNISCITI ALLA LISTA D'ATTESA</a>
                    </div>
                </nav>

                {/* Hero Section */}
                <header className="hero section py-20 md:py-32 bg-gradient-to-b from-white to-emerald-50/30">
                    <div className="container mx-auto px-4">
                        <div className="flex flex-col md:flex-row items-center gap-12 md:gap-20">
                            <div className="flex-1 min-w-[300px]">
                                <h1 className="text-4xl md:text-5xl lg:text-7xl font-bold mb-8 leading-tight text-emerald-950 tracking-tight">
                                    La tecnologia semplice,<br /> <span className="text-emerald-600">per tutti.</span>
                                </h1>
                                <p className="text-xl md:text-2xl mb-10 text-gray-600 leading-relaxed font-light">
                                    Impara a riconoscere le truffe, proteggere i tuoi risparmi e navigare serenamente.
                                    Con <span className="font-semibold text-emerald-800">DeepSafe</span>, internet non fa più paura.
                                </p>
                                <div className="flex flex-col sm:flex-row gap-6">
                                    <a href="#waitlist" className="btn-primary inline-flex justify-center items-center w-full sm:w-auto px-12 py-6 text-xl md:text-2xl font-bold bg-emerald-600 text-white rounded-full hover:bg-emerald-700 shadow-xl shadow-emerald-500/20 hover:shadow-2xl hover:shadow-emerald-500/30 hover:-translate-y-1 transition-all duration-300 tracking-wide">
                                        Inizia Ora - È Gratis
                                    </a>
                                </div>
                                <div className="mt-6 flex items-center gap-2 text-gray-500 text-base">
                                    <svg className="w-5 h-5 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path></svg>
                                    <span>Nessuna carta di credito richiesta</span>
                                </div>
                            </div>
                            <div className="flex-1 w-full min-w-[300px] text-center relative">
                                <div className="absolute inset-0 bg-emerald-200 rounded-full blur-3xl opacity-20 transform translate-y-10"></div>
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/app-screenshot-1.jpg`} alt="Applicazione Facile da Usare"
                                    className="relative rounded-3xl shadow-2xl border-4 border-white max-w-[90%] mx-auto h-auto transform rotate-1 hover:rotate-0 transition-transform duration-500" />
                            </div>
                        </div>
                    </div>
                </header>

                {/* Features Section */}
                <section className="section py-24 bg-white">
                    <div className="container mx-auto px-4">
                        <h2 className="text-center text-3xl md:text-5xl font-bold mb-16 text-emerald-950 tracking-tight">Cosa Imparerai</h2>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 md:gap-12">
                            {/* Feature 1 */}
                            <div className="group text-center p-8 bg-white rounded-3xl border border-gray-100 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
                                <div className="w-24 h-24 bg-red-50 rounded-2xl flex items-center justify-center mx-auto mb-8 group-hover:bg-red-100 transition-colors">
                                    <span className="text-5xl">✉️</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-gray-900">Riconosci le Email Pericolose</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Impara a distinguere una email vera da un tentativo di truffa che vuole rubare i tuoi dati o i tuoi soldi.</p>
                            </div>
                            {/* Feature 2 */}
                            <div className="group text-center p-8 bg-white rounded-3xl border border-gray-100 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
                                <div className="w-24 h-24 bg-emerald-50 rounded-2xl flex items-center justify-center mx-auto mb-8 group-hover:bg-emerald-100 transition-colors">
                                    <span className="text-5xl">🔒</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-gray-900">Password Semplici e Sicure</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Scopri come creare password impossibili da indovinare per gli altri, ma facili da ricordare per te.</p>
                            </div>
                            {/* Feature 3 */}
                            <div className="group text-center p-8 bg-white rounded-3xl border border-gray-100 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1">
                                <div className="w-24 h-24 bg-blue-50 rounded-2xl flex items-center justify-center mx-auto mb-8 group-hover:bg-blue-100 transition-colors">
                                    <span className="text-5xl">📱</span>
                                </div>
                                <h3 className="text-2xl font-bold mb-4 text-gray-900">Usa WhatsApp senza rischi</h3>
                                <p className="text-lg text-gray-600 leading-relaxed">Comunica con figli e nipoti in sicurezza, evitando link sospetti e catene dannose o truffaldine.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Benefits Section */}
                <section className="section py-24 bg-emerald-50/50">
                    <div className="container mx-auto px-4">
                        <div className="text-center max-w-3xl mx-auto mb-16">
                            <span className="text-emerald-600 font-bold tracking-widest uppercase text-sm mb-4 block">I Vantaggi Reali</span>
                            <h2 className="text-3xl md:text-4xl font-bold text-emerald-950">Perché è utile per te</h2>
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                            <div className="flex flex-col items-center text-center p-6">
                                <div className="mb-6 p-5 bg-white rounded-2xl shadow-sm ring-1 ring-emerald-100 text-emerald-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" /></svg>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Proteggi i tuoi Risparmi</h3>
                                <p className="text-gray-600 leading-relaxed">Evita le trappole online sempre più comuni pensate per sottrarre denaro.</p>
                            </div>
                            <div className="flex flex-col items-center text-center p-6">
                                <div className="mb-6 p-5 bg-white rounded-2xl shadow-sm ring-1 ring-emerald-100 text-emerald-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" /><path d="M14.05 2a9 9 0 0 1 8 7.94" /><path d="M14.05 6A5 5 0 0 1 18 10" /></svg>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Evita Truffe Telefoniche</h3>
                                <p className="text-gray-600 leading-relaxed">Impara a riconoscere chi ti chiama davvero e chi finge di essere la tua banca.</p>
                            </div>
                            <div className="flex flex-col items-center text-center p-6">
                                <div className="mb-6 p-5 bg-white rounded-2xl shadow-sm ring-1 ring-emerald-100 text-emerald-600">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /></svg>
                                </div>
                                <h3 className="text-xl font-bold mb-3 text-gray-900">Aiuta la tua Famiglia</h3>
                                <p className="text-gray-600 leading-relaxed">Diventa un punto di riferimento per la sicurezza dei tuoi cari e dei tuoi nipoti.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Testimonial Section */}
                <section className="section py-24 bg-white">
                    <div className="container mx-auto px-4 max-w-5xl cursor-default">
                        <div className="bg-gradient-to-br from-emerald-50 to-white p-8 md:p-14 rounded-[2.5rem] shadow-xl flex flex-col md:flex-row gap-10 items-center border border-emerald-100/50">
                            <div className="w-32 h-32 md:w-48 md:h-48 rounded-full flex-shrink-0 overflow-hidden border-4 border-white shadow-lg ring-4 ring-emerald-50">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/testimonial-maria.png`} alt="Maria" className="w-full h-full object-cover" />
                            </div>
                            <div className="text-center md:text-left">
                                <div className="text-emerald-300 w-12 h-12 mb-6 mx-auto md:mx-0">
                                    <svg fill="currentColor" viewBox="0 0 32 32" aria-hidden="true"><path d="M9.352 4C4.456 7.456 1 13.12 1 19.36c0 5.088 3.072 8.064 6.624 8.064 3.36 0 5.856-2.688 5.856-5.856 0-3.168-2.208-5.472-5.088-5.472-.576 0-1.344.096-1.536.192.48-3.264 3.552-7.104 6.624-9.024L9.352 4zm16.512 0c-4.8 3.456-8.256 9.12-8.256 15.36 0 5.088 3.072 8.064 6.624 8.064 3.264 0 5.856-2.688 5.856-5.856 0-3.168-2.304-5.472-5.184-5.472-.576 0-1.248.096-1.44.192.48-3.264 3.456-7.104 6.528-9.024L25.864 4z"></path></svg>
                                </div>
                                <p className="text-xl md:text-3xl text-gray-800 font-serif italic mb-8 leading-relaxed">
                                    "Pensavo che internet non facesse per me. Grazie a DeepSafe ho imparato a navigare senza paura di sbagliare. Ora mi sento più sicura e autonoma."
                                </p>
                                <div>
                                    <p className="font-bold text-gray-900 text-xl">Maria G.</p>
                                    <p className="text-emerald-700 font-medium">68 anni, Pensionata</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* How it works */}
                <section className="section py-24 bg-gray-50">
                    <div className="container mx-auto px-4">
                        <div className="bg-white border border-gray-100 rounded-[2rem] overflow-hidden flex flex-col md:flex-row shadow-2xl shadow-gray-200/50">
                            <div className="flex-1 min-w-[300px] h-72 md:h-auto overflow-hidden">
                                <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/region.jpg`} alt="Mappa Italia"
                                    className="w-full h-full object-cover hover:scale-105 transition-transform duration-700" />
                            </div>
                            <div className="flex-1 p-10 md:p-16">
                                <span className="inline-block px-4 py-1.5 rounded-full bg-emerald-100 text-emerald-800 text-sm font-bold mb-6">METODO SEMPLIFICATO</span>
                                <h2 className="text-3xl md:text-4xl font-bold mb-6 text-emerald-950">Un Viaggio nell'Italia del Futuro</h2>
                                <p className="mb-6 text-xl text-gray-600 leading-relaxed">
                                    L'app è strutturata come un gioco semplice. Viaggerai attraverso le regioni italiane risolvendo
                                    piccoli problemi quotidiani.
                                </p>
                                <p className="mb-10 text-xl text-gray-600 leading-relaxed">
                                    Niente termini tecnici incomprensibili. Solo esempi pratici e consigli utili per la vita di
                                    tutti i giorni.
                                </p>
                                <ul className="space-y-6">
                                    <li className="flex items-center text-xl text-gray-800">
                                        <div className="w-8 h-8 rounded-full bg-emerald-100 flex items-center justify-center mr-4 flex-shrink-0">
                                            <span className="text-emerald-600 text-lg font-bold">✓</span>
                                        </div>
                                        Lezioni brevi di soli 5 minuti
                                    </li>
                                    <li className="flex items-center text-xl text-gray-800">
                                        <div className="w-8 h-8 rounded-full bg-emerald-100 flex items-center justify-center mr-4 flex-shrink-0">
                                            <span className="text-emerald-600 text-lg font-bold">✓</span>
                                        </div>
                                        Adatto a chi parte da zero
                                    </li>
                                    <li className="flex items-center text-xl text-gray-800">
                                        <div className="w-8 h-8 rounded-full bg-emerald-100 flex items-center justify-center mr-4 flex-shrink-0">
                                            <span className="text-emerald-600 text-lg font-bold">✓</span>
                                        </div>
                                        Divertente, chiaro e rilassante
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Waitlist Section */}
                <section id="waitlist" className="section py-24 bg-emerald-900 text-white relative overflow-hidden">
                    <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10"></div>
                    <div className="container mx-auto px-4 text-center relative z-10">
                        <span className="text-emerald-300 font-bold tracking-widest uppercase text-sm mb-4 block">ACCESSO ANTICIPATO</span>
                        <h2 className="text-4xl md:text-5xl font-bold mb-8">Unisciti alla Lista d'Attesa</h2>
                        <p className="mb-12 text-xl md:text-2xl text-emerald-100 max-w-2xl mx-auto font-light">
                            Lascia la tua email per sapere quando l'app sarà disponibile. <br className="hidden md:block" />
                            È gratuito e senza impegno.
                        </p>

                        <form className="waitlist-form max-w-lg mx-auto bg-white p-2 rounded-2xl shadow-2xl flex flex-col md:flex-row gap-2" onSubmit={handleWaitlistSubmit}>
                            <input
                                type="email"
                                id="email"
                                placeholder="Inserisci la tua email qui..."
                                required
                                className="flex-1 p-5 rounded-xl border-none text-gray-900 text-lg focus:ring-2 focus:ring-emerald-500 outline-none placeholder-gray-400"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />
                            <button type="submit" className="btn-primary w-full md:w-auto px-8 py-5 text-lg font-bold bg-emerald-600 text-white rounded-xl hover:bg-emerald-700 transition-colors disabled:opacity-70 whitespace-nowrap" disabled={isSubmitting}>
                                {isSubmitting ? 'Wait...' : 'Avvisami!'}
                            </button>
                        </form>
                        <p className="mt-8 text-emerald-200/60 text-sm">Non invieremo spam. Solo notizie importanti.</p>
                    </div>
                </section>

                {/* Download Section */}
                {/* <section id="download" className="section py-20 bg-gray-50 text-center">
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
                </section> */}

                <footer className="py-10 text-center text-gray-500 text-sm md:text-base border-t border-gray-200 bg-white">
                    <div className="container mx-auto px-4">
                        <p>&copy; 2025 DeepSafe. All rights reserved. | <Link href="/privacy-policy" className="hover:text-emerald-800 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-emerald-800 transition-colors">Terms</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
