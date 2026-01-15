'use client';

import { useState } from 'react';
import { Copy, Check, Share2 } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Capacitor } from '@capacitor/core';

interface InviteCodeCardProps {
    referralCode: string;
}

export function InviteCodeCard({ referralCode }: InviteCodeCardProps) {
    const [copied, setCopied] = useState(false);

    const handleCopy = async () => {
        try {
            await navigator.clipboard.writeText(referralCode);
            setCopied(true);
            setTimeout(() => setCopied(false), 2000);
        } catch (err) {
            console.error('Failed to copy:', err);
        }
    };

    const handleShare = async () => {
        const shareData = {
            title: 'Unisciti a DeepSafe!',
            text: `Impara l'AI Safety e sfidami su DeepSafe! Usa il mio codice invito: ${referralCode}`,
            url: window.location.origin,
        };

        try {
            if (Capacitor.isNativePlatform() && navigator.share) {
                await navigator.share(shareData);
            } else if (navigator.share) {
                await navigator.share(shareData);
            } else {
                // Fallback to copy
                await handleCopy();
            }
        } catch (err) {
            if (err instanceof Error && err.name !== 'AbortError') {
                console.error('Error sharing:', err);
            }
        }
    };

    return (
        <div className="bg-gradient-to-br from-cyber-dark via-black to-cyber-dark border border-cyber-blue/30 rounded-2xl p-6 relative overflow-hidden">
            {/* Background Effects */}
            <div className="absolute top-0 right-0 w-32 h-32 bg-cyber-blue/10 blur-[60px] rounded-full pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-32 h-32 bg-cyber-purple/10 blur-[60px] rounded-full pointer-events-none" />

            {/* Scanner Line */}
            <div className="absolute top-0 left-0 w-full h-[1px] bg-gradient-to-r from-transparent via-cyber-blue to-transparent opacity-50 animate-scan pointer-events-none" />

            <div className="relative z-10 space-y-4">
                {/* Header */}
                <div className="text-center space-y-2">
                    <h3 className="text-lg font-bold font-orbitron text-white uppercase tracking-widest text-glow">
                        Invita Amici
                    </h3>
                    <p className="text-sm text-zinc-400 font-mono">
                        Condividi il tuo codice e guadagna <span className="text-amber-400 font-bold">1 mese PRO</span> per ogni amico!
                    </p>
                </div>

                {/* Code Display */}
                <div className="relative group">
                    <div className="absolute -inset-0.5 bg-gradient-to-r from-cyber-blue to-cyber-purple rounded-lg blur opacity-30 group-hover:opacity-60 transition duration-300" />
                    <div className="relative bg-black/80 border border-cyber-blue/50 rounded-lg p-4 flex items-center justify-center">
                        <span className="text-3xl font-bold font-mono text-cyber-blue tracking-[0.5em] text-glow select-all">
                            {referralCode}
                        </span>
                    </div>
                </div>

                {/* Action Buttons */}
                <div className="grid grid-cols-2 gap-3">
                    {/* Copy Button */}
                    <button
                        onClick={handleCopy}
                        className="relative group px-4 py-3 rounded-lg border border-cyber-blue/30 bg-cyber-blue/10 hover:bg-cyber-blue hover:text-cyber-dark transition-all duration-300 flex items-center justify-center gap-2"
                    >
                        <div className="absolute inset-0 bg-cyber-blue/20 rounded-lg blur opacity-0 group-hover:opacity-100 transition duration-300" />
                        <AnimatePresence mode="wait">
                            {copied ? (
                                <motion.div
                                    key="check"
                                    initial={{ scale: 0 }}
                                    animate={{ scale: 1 }}
                                    exit={{ scale: 0 }}
                                    className="flex items-center gap-2"
                                >
                                    <Check className="w-5 h-5 text-green-400" />
                                    <span className="text-sm font-bold font-orbitron uppercase">Copiato!</span>
                                </motion.div>
                            ) : (
                                <motion.div
                                    key="copy"
                                    initial={{ scale: 0 }}
                                    animate={{ scale: 1 }}
                                    exit={{ scale: 0 }}
                                    className="flex items-center gap-2"
                                >
                                    <Copy className="w-5 h-5 text-cyber-blue group-hover:text-cyber-dark" />
                                    <span className="text-sm font-bold font-orbitron uppercase text-cyber-blue group-hover:text-cyber-dark">Copia</span>
                                </motion.div>
                            )}
                        </AnimatePresence>
                    </button>

                    {/* Share Button */}
                    <button
                        onClick={handleShare}
                        className="relative group px-4 py-3 rounded-lg border border-cyber-purple/30 bg-cyber-purple/10 hover:bg-cyber-purple hover:text-white transition-all duration-300 flex items-center justify-center gap-2"
                    >
                        <div className="absolute inset-0 bg-cyber-purple/20 rounded-lg blur opacity-0 group-hover:opacity-100 transition duration-300" />
                        <Share2 className="w-5 h-5 text-cyber-purple group-hover:text-white relative z-10" />
                        <span className="text-sm font-bold font-orbitron uppercase text-cyber-purple group-hover:text-white relative z-10">Condividi</span>
                    </button>
                </div>

                {/* Info */}
                <div className="text-center pt-2 border-t border-cyber-gray/20">
                    <p className="text-xs text-zinc-500 font-mono">
                        Massimo <span className="text-amber-400 font-bold">12 inviti</span> = <span className="text-amber-400 font-bold">1 anno PRO</span>
                    </p>
                </div>
            </div>
        </div>
    );
}
