'use client';

import React from 'react';
import SiteNavbar from '@/components/site/SiteNavbar';
import SiteFooter from '@/components/site/SiteFooter';

import { Instagram, Youtube, Facebook, Mail } from 'lucide-react';

export default function LinksPage() {
    const links = [
        {
            title: 'Seguici su Instagram',
            url: 'https://www.instagram.com/deepsafe_/',
            icon: <Instagram className="w-6 h-6" />
        },
        {
            title: 'Seguici su YouTube',
            url: 'https://www.youtube.com/@Deep-Safe',
            icon: <Youtube className="w-6 h-6" />
        },
        {
            title: 'Seguici su Facebook',
            url: 'https://www.facebook.com/people/DeepSafe/61584281526377/',
            icon: <Facebook className="w-6 h-6" />
        },
        {
            title: 'Seguici su TikTok',
            url: 'https://www.tiktok.com/@deepsafe',
            icon: (
                <svg viewBox="0 0 24 24" fill="currentColor" className="w-6 h-6">
                    <path d="M12.525.02c1.31-.02 2.61-.01 3.91-.02.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.65-1.62-1.12-1.09-.96-1.93-2.1-2.48-3.41v9.33c.09 4.14-3.15 7.42-7.25 7.6-4.22-.04-7.6-3.41-7.62-7.63.16-4.52 3.98-7.96 8.44-7.5 .52.03 1.03.11 1.54.23v4.22c-.63-.35-1.34-.54-2.06-.55-2.22-.05-4.08 1.69-4.14 3.91-.01 2.21 1.77 4.02 3.99 4.04 2.21.05 4.02-1.77 4.04-3.99V.02h2.26z" />
                </svg>
            )
        },
        {
            title: 'Scrivici una Email',
            url: 'mailto:deepsafe.app@gmail.com',
            icon: <Mail className="w-6 h-6" />
        },
    ];

    return (
        <div className="min-h-screen w-full bg-[#0a0a12] text-[#e0e0e0] font-['Outfit'] overflow-x-hidden">
            <SiteNavbar />

            <main className="pt-32 pb-20 container mx-auto px-4 max-w-lg">
                <header className="text-center mb-10">
                    <div className="w-24 h-24 mx-auto mb-6 rounded-full bg-gradient-to-r from-blue-500 to-purple-600 p-1">
                        <div className="w-full h-full rounded-full bg-black flex items-center justify-center">
                            <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/new-logo.png`} alt="Logo" className="w-12 h-12" />
                        </div>
                    </div>
                    <h1 className="text-3xl font-bold mb-2 text-white">DeepSafe Resources</h1>
                    <p className="text-gray-400">Tutto il mondo DeepSafe a portata di click.</p>
                </header>

                <div className="space-y-4">
                    {links.map((link, index) => (
                        <a
                            key={index}
                            href={link.url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="block w-full p-4 bg-[#161622] border border-[#333] hover:border-[#00f3ff] hover:bg-[#1a1a2e] hover:shadow-[0_0_15px_rgba(0,243,255,0.2)] rounded-xl transition-all group flex items-center"
                        >
                            <span className="mr-4 text-white group-hover:text-[#00f3ff] transition-colors">{link.icon}</span>
                            <span className="font-bold text-white group-hover:text-[#00f3ff] transition-colors">{link.title}</span>
                            <span className="ml-auto text-gray-500 group-hover:text-white">→</span>
                        </a>
                    ))}
                </div>
            </main>

            <SiteFooter />
        </div>
    );
}
