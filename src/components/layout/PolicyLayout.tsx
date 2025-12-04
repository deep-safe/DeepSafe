'use client';

import React from 'react';
import Link from 'next/link';

interface PolicyLayoutProps {
    children: React.ReactNode;
    title: string;
    lastUpdated: string;
}

export const PolicyLayout = ({ children, title, lastUpdated }: PolicyLayoutProps) => {
    return (
        <div className="min-h-screen w-full bg-[#050505] text-gray-300 font-['Outfit'] overflow-x-hidden flex flex-col">
            {/* External Stylesheets */}
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet" />
            <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&display=swap" rel="stylesheet" />

            {/* Navbar */}
            <nav className="fixed top-0 left-0 right-0 z-50 py-6 bg-[#050505]/95 backdrop-blur-sm border-b border-white/5">
                <div className="container mx-auto px-6 flex justify-between items-center max-w-4xl">
                    <Link href="/" className="flex items-center gap-3 hover:opacity-80 transition-opacity">
                        <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/icon.svg`} alt="DeepSafe Logo" className="h-8 w-8" />
                        <span className="font-['Orbitron'] font-bold text-lg tracking-wider text-white">DEEPSAFE</span>
                    </Link>
                    <Link href="/" className="text-sm font-medium text-gray-400 hover:text-white transition-colors">
                        Torna alla Home
                    </Link>
                </div>
            </nav>

            {/* Content */}
            <div className="flex-1 pt-32 pb-20 px-6 w-full">
                <div className="max-w-3xl mx-auto w-full">
                    <div className="mb-16">
                        <h1 className="text-3xl md:text-4xl font-bold mb-4 font-['Orbitron'] text-white tracking-wide">{title}</h1>
                        <p className="text-gray-500 text-sm">Ultimo aggiornamento: {lastUpdated}</p>
                    </div>

                    <div className="prose prose-invert prose-lg max-w-none prose-headings:font-['Orbitron'] prose-headings:text-white prose-p:text-gray-300 prose-li:text-gray-300 prose-a:text-[#00f3ff]">
                        {children}
                    </div>
                </div>
            </div>

            {/* Footer */}
            <footer className="py-10 text-center border-t border-white/5 text-gray-600 bg-[#050505] relative z-10">
                <div className="container mx-auto px-4">
                    <p className="text-sm">&copy; 2025 DeepSafe. All rights reserved.</p>
                    <div className="flex justify-center gap-6 mt-4 text-sm">
                        <Link href="/privacy-policy" className="hover:text-white transition-colors">Privacy</Link>
                        <Link href="/terms" className="hover:text-white transition-colors">Terms</Link>
                        <Link href="/cookie-policy" className="hover:text-white transition-colors">Cookies</Link>
                    </div>
                </div>
            </footer>
        </div>
    );
};
