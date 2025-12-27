import Link from 'next/link';
import React from 'react';

export default function SiteFooter() {
    return (
        <footer className="py-10 text-center border-t border-[#333] text-gray-500 bg-[#0a0a12]">
            <div className="container mx-auto px-4">

                <p>&copy; 2025 DeepSafe. Tutti i diritti riservati. <br className="md:hidden" /> <span className="hidden md:inline">|</span> <Link href="/privacy-policy" className="hover:text-gray-300 transition-colors">Privacy Policy</Link> | <Link href="/terms" className="hover:text-gray-300 transition-colors">Termini e Condizioni</Link></p>
            </div>
        </footer>
    );
}
