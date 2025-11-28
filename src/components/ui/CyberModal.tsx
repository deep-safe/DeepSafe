'use client';

import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X } from 'lucide-react';
import { cn } from '@/lib/utils';

interface CyberModalProps {
    isOpen: boolean;
    onClose: () => void;
    title?: React.ReactNode;
    children: React.ReactNode;
    icon?: React.ReactNode;
    color?: 'cyan' | 'purple' | 'orange' | 'red' | 'green';
    className?: string;
    showCloseButton?: boolean;
}

export function CyberModal({
    isOpen,
    onClose,
    title,
    children,
    icon,
    color = 'cyan',
    className,
    showCloseButton = true
}: CyberModalProps) {
    if (!isOpen) return null;

    const colorStyles = {
        cyan: {
            border: 'border-cyan-500/50',
            shadow: 'shadow-[0_0_50px_rgba(6,182,212,0.3)]',
            glow: 'bg-cyan-500/20',
            text: 'text-cyan-400',
            gradient: 'from-cyan-500/10'
        },
        purple: {
            border: 'border-purple-500/50',
            shadow: 'shadow-[0_0_50px_rgba(168,85,247,0.3)]',
            glow: 'bg-purple-500/20',
            text: 'text-purple-400',
            gradient: 'from-purple-500/10'
        },
        orange: {
            border: 'border-orange-500/50',
            shadow: 'shadow-[0_0_50px_rgba(249,115,22,0.3)]',
            glow: 'bg-orange-500/20',
            text: 'text-orange-400',
            gradient: 'from-orange-500/10'
        },
        red: {
            border: 'border-red-500/50',
            shadow: 'shadow-[0_0_50px_rgba(239,68,68,0.3)]',
            glow: 'bg-red-500/20',
            text: 'text-red-400',
            gradient: 'from-red-500/10'
        },
        green: {
            border: 'border-green-500/50',
            shadow: 'shadow-[0_0_50px_rgba(34,197,94,0.3)]',
            glow: 'bg-green-500/20',
            text: 'text-green-400',
            gradient: 'from-green-500/10'
        }
    };

    const styles = colorStyles[color];

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            <AnimatePresence>
                {isOpen && (
                    <>
                        {/* Backdrop */}
                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/80 backdrop-blur-xl"
                            onClick={onClose}
                        />

                        {/* Modal Card */}
                        <motion.div
                            initial={{ scale: 0.5, opacity: 0, y: 50 }}
                            animate={{
                                scale: 1,
                                opacity: 1,
                                y: 0,
                                transition: { type: "spring", stiffness: 300, damping: 20 }
                            }}
                            exit={{ scale: 0.8, opacity: 0, y: 50 }}
                            className={cn(
                                "relative w-full max-w-sm bg-slate-900/90 border rounded-2xl p-1 overflow-hidden",
                                styles.border,
                                styles.shadow,
                                className
                            )}
                            onClick={e => e.stopPropagation()}
                        >
                            {/* Background Effects */}
                            <div className={cn("absolute inset-0 bg-gradient-to-b to-transparent pointer-events-none", styles.gradient)} />
                            <div className={cn("absolute top-0 left-1/2 -translate-x-1/2 w-32 h-32 blur-[50px] rounded-full pointer-events-none", styles.glow)} />

                            {/* Scanline */}
                            <div className="absolute top-0 left-0 w-full h-1 bg-white/10 animate-scan pointer-events-none" />

                            {/* Content Container */}
                            <div className="relative z-10 bg-black/40 backdrop-blur-sm rounded-xl p-6 h-full">

                                {/* Close Button */}
                                {showCloseButton && (
                                    <button
                                        onClick={onClose}
                                        className="absolute top-4 right-4 text-slate-400 hover:text-white transition-colors z-20"
                                    >
                                        <X className="w-5 h-5" />
                                    </button>
                                )}

                                {/* Header (Icon + Title) */}
                                {(icon || title) && (
                                    <div className="flex flex-col items-center text-center space-y-4 mb-6">
                                        {icon && (
                                            <div className="relative">
                                                <motion.div
                                                    animate={{
                                                        scale: [1, 1.1, 1],
                                                        filter: [
                                                            `drop-shadow(0 0 10px ${styles.text})`, // Simplified glow
                                                            `drop-shadow(0 0 20px ${styles.text})`,
                                                            `drop-shadow(0 0 10px ${styles.text})`
                                                        ]
                                                    }}
                                                    transition={{ duration: 2, repeat: Infinity, ease: "easeInOut" }}
                                                    className={cn("w-16 h-16 rounded-full bg-slate-800 border-2 flex items-center justify-center", styles.border)}
                                                >
                                                    <div className={cn("w-8 h-8", styles.text)}>
                                                        {icon}
                                                    </div>
                                                </motion.div>
                                            </div>
                                        )}

                                        {title && (
                                            <h2 className={cn("text-xl font-orbitron font-bold tracking-wider uppercase", styles.text)}>
                                                {title}
                                            </h2>
                                        )}
                                    </div>
                                )}

                                {/* Body */}
                                <div className="relative">
                                    {children}
                                </div>
                            </div>
                        </motion.div>
                    </>
                )}
            </AnimatePresence>
        </div>
    );
}
