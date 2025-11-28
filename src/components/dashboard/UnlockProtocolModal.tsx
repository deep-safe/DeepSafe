import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Lock, Unlock, ShieldCheck, MapPin, Coins, AlertTriangle, Terminal, Cpu, ShieldAlert } from 'lucide-react';
import { useUserStore } from '@/store/useUserStore';
import { useSound } from '@/context/SoundContext';

interface UnlockProtocolModalProps {
    isOpen: boolean;
    targetName: string;
    targetType: 'REGION' | 'SECTOR';
    cost: number;
    onUnlock: () => void;
    onClose: () => void;
}

export const UnlockProtocolModal: React.FC<UnlockProtocolModalProps> = ({
    isOpen,
    targetName,
    targetType,
    cost,
    onUnlock,
    onClose
}) => {
    const credits = useUserStore(state => state.credits);
    const canAfford = credits >= cost;
    const { playSound } = useSound();

    const [status, setStatus] = useState<'IDLE' | 'DECRYPTING' | 'ACCESS_GRANTED' | 'DENIED'>('IDLE');
    const [progress, setProgress] = useState(0);
    const [scrambleText, setScrambleText] = useState('');

    // Reset state on open
    useEffect(() => {
        if (isOpen) {
            setStatus('IDLE');
            setProgress(0);
            setScrambleText('');
        }
    }, [isOpen]);

    // Scramble effect during decryption
    useEffect(() => {
        if (status === 'DECRYPTING') {
            const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&';
            const interval = setInterval(() => {
                let text = '';
                for (let i = 0; i < 12; i++) {
                    text += chars.charAt(Math.floor(Math.random() * chars.length));
                }
                setScrambleText(text);
            }, 50);
            return () => clearInterval(interval);
        }
    }, [status]);

    const handleUnlockClick = async () => {
        if (!canAfford) {
            setStatus('DENIED');
            playSound('error');
            setTimeout(() => setStatus('IDLE'), 2000);
            return;
        }

        setStatus('DECRYPTING');
        playSound('click'); // Or a specific 'hacking' sound if available

        // Simulate decryption process
        const duration = 2000; // 2 seconds
        const steps = 20;
        const stepTime = duration / steps;

        let currentStep = 0;
        const timer = setInterval(() => {
            currentStep++;
            setProgress((currentStep / steps) * 100);

            if (currentStep >= steps) {
                clearInterval(timer);
                setStatus('ACCESS_GRANTED');
                playSound('success');
                setTimeout(() => {
                    onUnlock();
                }, 1000); // Wait 1s to show success state
            }
        }, stepTime);
    };

    if (!isOpen) return null;

    return (
        <AnimatePresence>
            <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-md">
                <motion.div
                    initial={{ opacity: 0, scale: 0.9, y: 20 }}
                    animate={{ opacity: 1, scale: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.9, y: 20 }}
                    className="relative w-full max-w-md bg-slate-950/90 border border-cyan-500/30 rounded-xl overflow-hidden shadow-[0_0_50px_rgba(6,182,212,0.15)]"
                >
                    {/* Scanline Overlay */}
                    <div
                        className="absolute inset-0 pointer-events-none opacity-10 z-0"
                        style={{
                            backgroundImage: 'linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.06), rgba(0, 255, 0, 0.02), rgba(0, 0, 255, 0.06))',
                            backgroundSize: '100% 2px, 3px 100%'
                        }}
                    />

                    {/* Top Accent Line */}
                    <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-cyan-500 to-transparent opacity-50" />

                    {/* Header */}
                    <div className="relative z-10 bg-slate-900/50 p-4 border-b border-cyan-500/20 flex items-center justify-between">
                        <div className="flex items-center gap-3">
                            <div className="p-1.5 rounded bg-cyan-500/10 border border-cyan-500/30">
                                <Terminal className="w-4 h-4 text-cyan-400" />
                            </div>
                            <div>
                                <h3 className="font-orbitron font-bold text-cyan-100 tracking-wider text-sm">SECURITY PROTOCOL</h3>
                                <div className="flex items-center gap-2">
                                    <span className="w-1.5 h-1.5 rounded-full bg-red-500 animate-pulse" />
                                    <span className="text-[10px] font-mono text-cyan-500/70">ENCRYPTION: LEVEL 5</span>
                                </div>
                            </div>
                        </div>
                        <div className="font-mono text-xs text-cyan-500/50">v2.4.0</div>
                    </div>

                    {/* Content */}
                    <div className="relative z-10 p-8 flex flex-col items-center text-center">

                        {/* Central Icon Animation */}
                        <div className="relative mb-8">
                            <AnimatePresence mode="wait">
                                {status === 'DECRYPTING' ? (
                                    <motion.div
                                        key="decrypting"
                                        initial={{ scale: 0.8, opacity: 0 }}
                                        animate={{ scale: 1, opacity: 1 }}
                                        exit={{ scale: 0.8, opacity: 0 }}
                                        className="relative w-24 h-24 flex items-center justify-center"
                                    >
                                        <div className="absolute inset-0 border-4 border-cyan-500/20 rounded-full border-t-cyan-400 animate-spin" />
                                        <div className="absolute inset-2 border-4 border-cyan-500/20 rounded-full border-b-cyan-400 animate-spin-reverse" />
                                        <Cpu className="w-10 h-10 text-cyan-400 animate-pulse" />
                                    </motion.div>
                                ) : status === 'ACCESS_GRANTED' ? (
                                    <motion.div
                                        key="granted"
                                        initial={{ scale: 0.8, opacity: 0 }}
                                        animate={{ scale: 1.1, opacity: 1 }}
                                        className="relative w-24 h-24 flex items-center justify-center"
                                    >
                                        <div className="absolute inset-0 bg-emerald-500/20 rounded-full blur-xl" />
                                        <ShieldCheck className="w-16 h-16 text-emerald-400 drop-shadow-[0_0_10px_rgba(52,211,153,0.5)]" />
                                    </motion.div>
                                ) : (
                                    <motion.div
                                        key="idle"
                                        initial={{ scale: 0.8, opacity: 0 }}
                                        animate={{ scale: 1, opacity: 1 }}
                                        exit={{ scale: 0.8, opacity: 0 }}
                                        className="relative w-24 h-24 flex items-center justify-center group"
                                    >
                                        <div className="absolute inset-0 bg-red-500/5 rounded-full blur-xl group-hover:bg-red-500/10 transition-all" />
                                        <div className="absolute inset-0 border border-red-500/20 rounded-full group-hover:border-red-500/40 transition-all" />
                                        <Lock className="w-10 h-10 text-red-400 drop-shadow-[0_0_10px_rgba(248,113,113,0.3)]" />

                                        {/* Orbiting particles */}
                                        <div className="absolute inset-0 animate-spin-slow">
                                            <div className="absolute top-0 left-1/2 w-1 h-1 bg-red-500 rounded-full shadow-[0_0_5px_red]" />
                                        </div>
                                    </motion.div>
                                )}
                            </AnimatePresence>
                        </div>

                        {/* Text Status */}
                        <div className="mb-8 space-y-2 h-20">
                            <h2 className="text-2xl font-orbitron font-bold text-white tracking-wide">
                                {status === 'DECRYPTING' ? (
                                    <span className="font-mono text-cyan-400">{scrambleText}</span>
                                ) : status === 'ACCESS_GRANTED' ? (
                                    <span className="text-emerald-400 drop-shadow-[0_0_10px_rgba(52,211,153,0.5)]">ACCESS GRANTED</span>
                                ) : (
                                    targetName.toUpperCase()
                                )}
                            </h2>
                            <p className="text-slate-400 text-sm font-mono">
                                {status === 'DECRYPTING' ? 'BYPASSING SECURITY FIREWALL...' :
                                    status === 'ACCESS_GRANTED' ? 'SYSTEM UNLOCKED. WELCOME COMMANDER.' :
                                        `LOCKED ${targetType} DETECTED. AUTHORIZATION REQUIRED.`}
                            </p>
                        </div>

                        {/* Cost & Balance Grid */}
                        <div className="w-full grid grid-cols-2 gap-4 mb-8">
                            <div className="bg-slate-900/50 p-3 rounded border border-slate-800 flex flex-col items-center">
                                <span className="text-[10px] text-slate-500 font-mono uppercase mb-1">PROTOCOL COST</span>
                                <span className="font-mono font-bold text-yellow-400 flex items-center gap-1.5 text-lg">
                                    {cost > 0 ? cost.toLocaleString() : 'FREE'} <Coins className="w-3.5 h-3.5" />
                                </span>
                            </div>
                            <div className={`bg-slate-900/50 p-3 rounded border flex flex-col items-center transition-colors ${canAfford ? 'border-slate-800' : 'border-red-500/30 bg-red-950/10'
                                }`}>
                                <span className="text-[10px] text-slate-500 font-mono uppercase mb-1">AVAILABLE CREDITS</span>
                                <span className={`font-mono font-bold flex items-center gap-1.5 text-lg ${canAfford ? 'text-emerald-400' : 'text-red-400'}`}>
                                    {credits.toLocaleString()} <Coins className="w-3.5 h-3.5" />
                                </span>
                            </div>
                        </div>

                        {/* Progress Bar (Visible only during decryption) */}
                        {status === 'DECRYPTING' && (
                            <div className="w-full h-1 bg-slate-800 rounded-full mb-6 overflow-hidden">
                                <motion.div
                                    className="h-full bg-cyan-400 shadow-[0_0_10px_cyan]"
                                    initial={{ width: 0 }}
                                    animate={{ width: `${progress}%` }}
                                    transition={{ ease: "linear" }}
                                />
                            </div>
                        )}

                        {/* Action Buttons */}
                        <div className="flex gap-3 w-full">
                            <button
                                onClick={onClose}
                                disabled={status === 'DECRYPTING' || status === 'ACCESS_GRANTED'}
                                className="flex-1 py-3.5 rounded bg-slate-900/50 hover:bg-slate-800 border border-slate-700 text-slate-400 font-mono text-xs font-bold tracking-wider transition-colors disabled:opacity-50"
                            >
                                ABORT
                            </button>
                            <button
                                onClick={handleUnlockClick}
                                disabled={!canAfford || status === 'DECRYPTING' || status === 'ACCESS_GRANTED'}
                                className={`flex-[2] py-3.5 rounded font-orbitron text-xs font-bold tracking-widest transition-all flex items-center justify-center gap-2 shadow-lg relative overflow-hidden group ${canAfford
                                    ? 'bg-cyan-600/20 border border-cyan-500/50 text-cyan-300 hover:bg-cyan-500/30 hover:shadow-[0_0_20px_rgba(6,182,212,0.3)]'
                                    : 'bg-red-950/20 border border-red-500/30 text-red-400 cursor-not-allowed'
                                    }`}
                            >
                                {status === 'DECRYPTING' ? (
                                    <span className="animate-pulse">DECRYPTING...</span>
                                ) : status === 'ACCESS_GRANTED' ? (
                                    <span>UNLOCKED</span>
                                ) : !canAfford ? (
                                    <>
                                        <AlertTriangle className="w-3 h-3" />
                                        <span>INSUFFICIENT FUNDS</span>
                                    </>
                                ) : (
                                    <>
                                        <Unlock className="w-3 h-3 group-hover:rotate-12 transition-transform" />
                                        <span>INITIATE DECRYPTION</span>
                                    </>
                                )}
                            </button>
                        </div>
                    </div>
                </motion.div>
            </div>
        </AnimatePresence>
    );
};
