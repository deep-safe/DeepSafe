import Link from 'next/link';
import React, { useState } from 'react';

export default function SiteNavbar() {
    const [isMenuOpen, setIsMenuOpen] = useState(false);

    return (
        <nav className="absolute w-full z-20 py-5">
            <div className="container mx-auto px-4 flex justify-between items-center">
                <div className="flex items-center gap-12">
                    <Link href="/" className="flex items-center gap-3 hover:opacity-90 transition-opacity">
                        <img src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/new-logo.png`} alt="DeepSafe Logo" className="h-10 w-10 md:h-[45px] md:w-[45px]" />
                        <span className="font-['Orbitron'] font-black text-xl md:text-2xl tracking-widest bg-gradient-to-r from-white via-blue-200 to-blue-500 bg-clip-text text-transparent">DEEPSAFE</span>
                    </Link>

                    {/* Desktop Menu Links - Left Aligned */}
                    <div className="flex items-center gap-8 ml-10">
                        <Link href="/chi-siamo" className="text-gray-300 hover:text-[#00f3ff] transition-colors font-['Outfit'] font-bold text-lg tracking-wide whitespace-nowrap">
                            CHI SIAMO
                        </Link>
                        <Link href="/missioni" className="text-gray-300 hover:text-[#00f3ff] transition-colors font-['Outfit'] font-bold text-lg tracking-wide whitespace-nowrap">
                            MISSIONI
                        </Link>
                        <Link href="/skill-tree" className="text-gray-300 hover:text-[#00f3ff] transition-colors font-['Outfit'] font-bold text-lg tracking-wide whitespace-nowrap">
                            SKILL TREE
                        </Link>
                        <Link href="/prezzi" className="text-gray-300 hover:text-[#00f3ff] transition-colors font-['Outfit'] font-bold text-lg tracking-wide whitespace-nowrap">
                            PREZZI
                        </Link>
                        <Link href="/links" className="text-gray-300 hover:text-[#00f3ff] transition-colors font-['Outfit'] font-bold text-lg tracking-wide whitespace-nowrap">
                            LINKS
                        </Link>
                    </div>
                </div>

                {/* Desktop CTA - Right Aligned */}
                <div className="block">
                    <Link href="/dashboard" className="btn btn-primary whitespace-nowrap" style={{ fontSize: '1rem', padding: '10px 30px' }}>
                        PROVA LA WEB APP
                    </Link>
                </div>

                {/* Mobile Menu Button - Hidden for now as we force desktop view or user is on desktop */}
                <button
                    className="lg:hidden text-white hidden"
                    onClick={() => setIsMenuOpen(!isMenuOpen)}
                >
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d={isMenuOpen ? "M6 18L18 6M6 6l12 12" : "M4 6h16M4 12h16M4 18h16"} />
                    </svg>
                </button>

                {/* Mobile Menu Overlay */}
                {isMenuOpen && (
                    <div className="absolute top-full left-0 w-full bg-[#0a0a12]/95 backdrop-blur-md border-b border-[#333] p-4 flex flex-col gap-4 md:hidden text-center animate-in slide-in-from-top-4">
                        <Link href="/chi-siamo" onClick={() => setIsMenuOpen(false)} className="text-gray-300 hover:text-[#00f3ff] py-2 font-bold text-lg">
                            CHI SIAMO
                        </Link>
                        <Link href="/missioni" onClick={() => setIsMenuOpen(false)} className="text-gray-300 hover:text-[#00f3ff] py-2 font-bold text-lg">
                            MISSIONI
                        </Link>
                        <Link href="/prezzi" onClick={() => setIsMenuOpen(false)} className="text-gray-300 hover:text-[#00f3ff] py-2 font-bold text-lg">
                            PREZZI
                        </Link>
                        <Link href="/links" onClick={() => setIsMenuOpen(false)} className="text-gray-300 hover:text-[#00f3ff] py-2 font-bold text-lg">
                            LINKS
                        </Link>
                        <Link href="/dashboard" onClick={() => setIsMenuOpen(false)} className="btn btn-primary w-full inline-block">
                            PROVA LA APP
                        </Link>
                    </div>
                )}
            </div>
        </nav>
    );
}
