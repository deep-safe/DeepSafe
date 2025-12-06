import React from 'react';
import { X, Check } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';

interface WaitlistSuccessModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export const WaitlistSuccessModal: React.FC<WaitlistSuccessModalProps> = ({ isOpen, onClose }) => {
    // Social Links Configuration
    const SOCIALS = [
        {
            name: 'Instagram',
            url: 'https://instagram.com/deepsafe_app', // Placeholder
            icon: (
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
                    <rect width="20" height="20" x="2" y="2" rx="5" ry="5" />
                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" />
                    <line x1="17.5" x2="17.51" y1="6.5" y2="6.5" />
                </svg>
            ),
            color: 'hover:text-pink-500 hover:border-pink-500/50 hover:bg-pink-500/10'
        },
        {
            name: 'TikTok',
            url: 'https://tiktok.com/@deepsafe', // Placeholder
            icon: (
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
                    <path d="M9 12a4 4 0 1 0 4 4V4a5 5 0 0 0 5 5" />
                </svg>
            ),
            color: 'hover:text-cyan-400 hover:border-cyan-400/50 hover:bg-cyan-400/10'
        },
        {
            name: 'YouTube',
            url: 'https://youtube.com/@DeepSafe', // Placeholder
            icon: (
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="w-6 h-6">
                    <path d="M2.5 17a24.12 24.12 0 0 1 0-10 2 2 0 0 1 1.4-1.4 49.56 49.56 0 0 1 16.2 0A2 2 0 0 1 21.5 7a24.12 24.12 0 0 1 0 10 2 2 0 0 1-1.4 1.4 49.55 49.55 0 0 1-16.2 0A2 2 0 0 1 2.5 17" />
                    <path d="m10 15 5-3-5-3z" />
                </svg>
            ),
            color: 'hover:text-red-500 hover:border-red-500/50 hover:bg-red-500/10'
        }
    ];

    if (!isOpen) return null;

    return (
        <AnimatePresence>
            {isOpen && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                    {/* Backdrop */}
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        onClick={onClose}
                        className="absolute inset-0 bg-black/90 backdrop-blur-sm"
                    />

                    {/* Modal Content */}
                    <motion.div
                        initial={{ scale: 0.9, opacity: 0, y: 20 }}
                        animate={{ scale: 1, opacity: 1, y: 0 }}
                        exit={{ scale: 0.9, opacity: 0, y: 20 }}
                        className="relative w-full max-w-sm md:max-w-[480px] bg-[#0f172a] border border-blue-500/30 rounded-3xl shadow-[0_0_60px_rgba(59,130,246,0.15)] overflow-hidden"
                    >
                        {/* Decorative Top Line */}
                        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-blue-500 to-transparent opacity-80" />

                        {/* Close Button */}
                        <button
                            onClick={onClose}
                            className="absolute top-4 right-4 p-2 rounded-full hover:bg-white/5 text-slate-400 hover:text-white transition-all z-10"
                        >
                            <X className="w-5 h-5" />
                        </button>

                        <div className="p-8 md:p-10 flex flex-col items-center text-center gap-8">

                            {/* Success Icon */}
                            <div className="w-24 h-24 rounded-full bg-green-500/10 border border-green-500/20 flex items-center justify-center shrink-0 mt-2 shadow-[0_0_30px_rgba(34,197,94,0.15)]">
                                <Check className="w-12 h-12 text-green-400 drop-shadow-[0_0_10px_rgba(74,222,128,0.5)]" />
                            </div>

                            {/* Text Content */}
                            <div className="flex flex-col gap-2">
                                <h2 className="text-2xl font-bold text-white font-orbitron tracking-wide leading-tight">
                                    ISCRIZIONE<br />CONFERMATA!
                                </h2>
                                <p className="text-slate-400 text-sm leading-relaxed px-4">
                                    Sei ufficialmente in lista d'attesa. Ti invieremo presto le istruzioni per l'accesso.
                                </p>
                            </div>

                            {/* Divider with Text */}
                            <div className="w-full flex items-center gap-4 text-[10px] text-slate-600 font-mono tracking-widest uppercase py-2">
                                <div className="h-[1px] bg-slate-800 flex-1" />
                                RIMANI AGGIORNATO
                                <div className="h-[1px] bg-slate-800 flex-1" />
                            </div>

                            {/* Social Links */}
                            <div className="flex justify-center gap-4 w-full">
                                {SOCIALS.map((social) => (
                                    <a
                                        key={social.name}
                                        href={social.url}
                                        target="_blank"
                                        rel="noopener noreferrer"
                                        className={`p-4 rounded-xl border border-slate-800 bg-slate-800/50 text-slate-400 transition-all duration-300 hover:scale-110 ${social.color} group relative overflow-hidden`}
                                        title={social.name}
                                    >
                                        <div className="relative z-10">
                                            {social.icon}
                                        </div>
                                        {/* Hover Glow */}
                                        <div className="absolute inset-0 bg-current opacity-0 group-hover:opacity-5 transition-opacity duration-300" />
                                    </a>
                                ))}
                            </div>

                            {/* Close Action */}
                            <button
                                onClick={onClose}
                                className="w-full py-5 text-lg bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-xl transition-all shadow-[0_0_20px_rgba(37,99,235,0.3)] hover:shadow-[0_0_30px_rgba(37,99,235,0.5)] active:scale-[0.98] font-orbitron tracking-wider mt-4"
                            >
                                TORNA ALLA HOME
                            </button>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    );
};
