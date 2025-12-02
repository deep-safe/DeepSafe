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
            <link rel="stylesheet" href="/landing/css/shared.css" />
            <link rel="stylesheet" href="/landing/css/theme.css" />
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700;900&display=swap" rel="stylesheet" />

            <div className="theme-youth">
                {/* Navbar */}
                <nav style={{ padding: '20px 0', position: 'absolute', width: '100%', zIndex: 10 }}>
                    <div className="container" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                            <img src="/landing/assets/icon.svg" alt="DeepSafe Logo" style={{ height: '45px', width: '45px' }} />
                            <span style={{ fontFamily: "'Orbitron', sans-serif", fontWeight: 900, fontSize: '1.5rem', letterSpacing: '2px', background: 'linear-gradient(to right, #ffffff, #bfdbfe, #3b82f6)', WebkitBackgroundClip: 'text', backgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>DEEPSAFE</span>
                        </div>
                        <a href="#download" className="btn btn-primary">SCARICA L'APP</a>
                    </div>
                </nav>

                {/* Hero Section */}
                <header className="hero section"
                    style={{ minHeight: '90vh', display: 'flex', alignItems: 'center', textAlign: 'center', paddingTop: '120px' }}>
                    <div className="container" style={{ position: 'relative', zIndex: 2 }}>
                        <h1 style={{ fontSize: '3.5rem', marginBottom: '20px', lineHeight: 1.1 }}>
                            L'Italia del Futuro <br /> <span style={{ color: 'var(--primary-color)' }}>Ha Bisogno di Te</span>
                        </h1>
                        <p
                            style={{ fontSize: '1.2rem', marginBottom: '40px', maxWidth: '600px', marginLeft: 'auto', marginRight: 'auto', opacity: 0.9 }}>
                            Il mondo digitale è sotto attacco. Hacker, deepfake e blackout minacciano il nostro paese.
                            Hai le skills per salvarlo?
                        </p>
                        <div style={{ display: 'flex', gap: '20px', justifyContent: 'center', flexWrap: 'wrap' }}>
                            <a href="#download" className="btn btn-primary" style={{ fontSize: '1.2rem', padding: '15px 40px' }}>SCARICA L'APP</a>
                            <a href="#features" className="btn" style={{ border: '1px solid white', color: 'white' }}>SCOPRI DI PIÙ</a>
                        </div>
                    </div>
                </header>

                {/* Gameplay Preview Section */}
                <section id="features" className="section" style={{ backgroundColor: 'var(--card-bg)' }}>
                    <div className="container">
                        <div style={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center', gap: '40px' }}>
                            <div style={{ flex: 1, minWidth: '300px' }}>
                                <h2 style={{ fontSize: '2.5rem', marginBottom: '20px' }}>Level Up Your Skills</h2>
                                <p style={{ marginBottom: '20px' }}>
                                    Non è solo un corso, è una missione. Viaggia attraverso le regioni italiane in un futuro
                                    cyberpunk.
                                    Ogni territorio ha una minaccia diversa:
                                </p>
                                <ul style={{ marginBottom: '30px' }}>
                                    <li style={{ marginBottom: '10px', display: 'flex', alignItems: 'center' }}>
                                        <span style={{ color: 'var(--primary-color)', marginRight: '10px' }}>►</span> Sconfiggi i Malware
                                    </li>
                                    <li style={{ marginBottom: '10px', display: 'flex', alignItems: 'center' }}>
                                        <span style={{ color: 'var(--primary-color)', marginRight: '10px' }}>►</span> Smaschera le Fake
                                        News
                                    </li>
                                    <li style={{ marginBottom: '10px', display: 'flex', alignItems: 'center' }}>
                                        <span style={{ color: 'var(--primary-color)', marginRight: '10px' }}>►</span> Proteggi la tua
                                        Identità
                                    </li>
                                </ul>
                            </div>
                            <div style={{ flex: 1, minWidth: '300px' }}>
                                {/* Placeholder for gameplay video/image */}
                                <div
                                    style={{ borderRadius: '20px', overflow: 'hidden', border: '2px solid var(--primary-color)', boxShadow: '0 0 20px rgba(0, 243, 255, 0.2)' }}>
                                    <img src="/landing/assets/app-screenshot-1.jpg" alt="Gameplay Preview" style={{ width: '100%', height: 'auto', display: 'block' }} />
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Map Section */}
                <section className="section">
                    <div className="container text-center">
                        <h2 style={{ marginBottom: '40px' }}>Conquista i Territori</h2>
                        <div style={{ position: 'relative', maxWidth: '800px', margin: '0 auto' }}>
                            <img src="/landing/assets/italy-map-full.jpg" alt="Mappa Italia Futura"
                                style={{ borderRadius: '20px', opacity: 0.8, width: '100%', height: 'auto' }} />
                            <div
                                style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%, -50%)', background: 'rgba(0,0,0,0.8)', padding: '20px', borderRadius: '10px', border: '1px solid var(--primary-color)' }}>
                                <h3 style={{ color: 'var(--primary-color)' }}>Missioni Attive</h3>
                                <p>Sblocca nuove regioni completando le sfide di sicurezza.</p>
                            </div>
                        </div>
                    </div>
                </section>

                {/* Waitlist Section */}
                <section id="waitlist" className="section" style={{ background: 'linear-gradient(to top, #000, var(--card-bg))' }}>
                    <div className="container text-center">
                        <h2 style={{ marginBottom: '20px' }}>Sei Pronto a Giocare?</h2>
                        <p style={{ marginBottom: '40px', maxWidth: '500px', marginLeft: 'auto', marginRight: 'auto' }}>
                            Iscriviti alla lista d'attesa per ottenere l'accesso anticipato e una skin esclusiva per il tuo avatar.
                        </p>

                        <form className="waitlist-form" onSubmit={handleWaitlistSubmit}>
                            <input
                                type="email"
                                placeholder="Inserisci la tua email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                            />
                            <button type="submit" className="btn btn-primary" disabled={isSubmitting}>
                                {isSubmitting ? 'INVIO...' : 'JOIN THE BETA'}
                            </button>
                        </form>
                    </div>
                </section>

                {/* Download Section */}
                <section id="download" className="section" style={{ backgroundColor: 'var(--card-bg)', textAlign: 'center' }}>
                    <div className="container">
                        <h2 style={{ marginBottom: '30px' }}>Scarica DeepSafe Ora</h2>
                        <p style={{ marginBottom: '40px' }}>Disponibile per iOS e Android.</p>
                        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px', flexWrap: 'wrap' }}>
                            <a href="#" className="btn"
                                style={{ background: '#000', color: 'white', display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 20px', borderRadius: '10px' }}>
                                <span style={{ fontSize: '1.5rem' }}></span> App Store
                            </a>
                            <a href="/landing/assets/deepsafe.apk" className="btn"
                                style={{ background: '#000', color: 'white', display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 20px', borderRadius: '10px' }}>
                                <span style={{ fontSize: '1.5rem' }}>🤖</span> Scarica APK
                            </a>
                            <Link href="/dashboard" className="btn"
                                style={{ background: '#000', color: 'white', display: 'flex', alignItems: 'center', gap: '10px', padding: '10px 20px', borderRadius: '10px' }}>
                                <span style={{ fontSize: '1.5rem' }}>🌐</span> Web App
                            </Link>
                        </div>
                    </div>
                </section>

                <footer style={{ padding: '40px 0', textAlign: 'center', borderTop: '1px solid #333', color: '#666' }}>
                    <div className="container">
                        <p>&copy; 2025 DeepSafe. All rights reserved. | <Link href="/privacy-policy" style={{ color: '#888' }}>Privacy Policy</Link> | <Link href="/terms" style={{ color: '#888' }}>Terms</Link></p>
                    </div>
                </footer>
            </div>
        </>
    );
}
