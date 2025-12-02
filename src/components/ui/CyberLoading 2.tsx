'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { Loader2, Shield } from 'lucide-react';
import { cn } from '@/lib/utils';

interface CyberLoadingProps {
    message?: string;
    fullScreen?: boolean;
}

export function CyberLoading({ message = "CARICAMENTO SISTEMA...", fullScreen = true }: CyberLoadingProps) {
    return (
        <div className={cn(
            "flex flex-col items-center justify-center bg-slate-950 relative overflow-hidden",
            fullScreen ? "fixed inset-0 z-50" : "w-full h-64 rounded-xl border border-slate-800"
        )}>
            {/* Background Effects */}
            <div className="absolute inset-0 opacity-20 pointer-events-none"
                style={{
                    backgroundImage: `linear-gradient(rgba(6,182,212,0.1) 1px, transparent 1px), linear-gradient(90deg, rgba(6,182,212,0.1) 1px, transparent 1px)`,
                    backgroundSize: '40px 40px'
                }}
            />

            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-64 h-64 bg-cyan-500/10 blur-[80px] rounded-full pointer-events-none" />

            {/* Content */}
            <div className="relative z-10 flex flex-col items-center gap-6">
                <div className="relative">
                    {/* Rotating Rings */}
                    <motion.div
                        animate={{ rotate: 360 }}
                        transition={{ duration: 3, repeat: Infinity, ease: "linear" }}
                        className="w-20 h-20 rounded-full border-t-2 border-l-2 border-cyan-500/50"
                    />
                    <motion.div
                        animate={{ rotate: -360 }}
                        transition={{ duration: 5, repeat: Infinity, ease: "linear" }}
                        className="absolute inset-2 rounded-full border-b-2 border-r-2 border-purple-500/50"
                    />

                    {/* Center Icon */}
                    <div className="absolute inset-0 flex items-center justify-center">
                        <Shield className="w-8 h-8 text-cyan-400 animate-pulse" />
                    </div>
                </div>

                <div className="flex flex-col items-center gap-2">
                    <h3 className="text-xl font-bold font-orbitron text-white tracking-widest animate-pulse">
                        {message}
                    </h3>
                    <div className="flex gap-1">
                        {[0, 1, 2].map((i) => (
                            <motion.div
                                key={i}
                                animate={{ opacity: [0.3, 1, 0.3] }}
                                transition={{ duration: 1.5, repeat: Infinity, delay: i * 0.2 }}
                                className="w-2 h-2 rounded-full bg-cyan-500"
                            />
                        ))}
                    </div>
                </div>
            </div>

            {/* Scanline */}
            <div className="absolute top-0 left-0 w-full h-1 bg-cyan-500/20 animate-scan pointer-events-none" />
        </div>
    );
}
