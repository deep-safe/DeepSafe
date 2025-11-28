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
    color?: 'cyan' | 'purple' | 'orange' | 'red' | 'green' | 'yellow';
    className?: string;
    showCloseButton?: boolean;
    description?: string;
}

export function CyberModal({
    isOpen,
    onClose,
    title,
    children,
    icon,
    color = 'cyan',
    className,
    showCloseButton = true,
    description
}: CyberModalProps) {
    if (!isOpen) return null;

    const colorStyles = {
        cyan: {
            border: 'border-cyan-500/50',
            shadow: 'shadow-[0_0_50px_rgba(6,182,212,0.2)]',
            glow: 'bg-cyan-500/10',
            text: 'text-cyan-400',
            gradient: 'from-cyan-500/10',
            button: 'bg-cyan-600 hover:bg-cyan-500 text-white shadow-cyan-900/20'
        },
        purple: {
            border: 'border-purple-500/50',
            shadow: 'shadow-[0_0_50px_rgba(168,85,247,0.2)]',
            glow: 'bg-purple-500/10',
            text: 'text-purple-400',
            gradient: 'from-purple-500/10',
            button: 'bg-purple-600 hover:bg-purple-500 text-white shadow-purple-900/20'
        },
        orange: {
            border: 'border-orange-500/50',
            shadow: 'shadow-[0_0_50px_rgba(249,115,22,0.2)]',
            glow: 'bg-orange-500/10',
            text: 'text-orange-400',
            gradient: 'from-orange-500/10',
            button: 'bg-orange-600 hover:bg-orange-500 text-white shadow-orange-900/20'
        },
        red: {
            border: 'border-red-500/50',
            shadow: 'shadow-[0_0_50px_rgba(239,68,68,0.2)]',
            glow: 'bg-red-500/10',
            text: 'text-red-400',
            gradient: 'from-red-500/10',
            button: 'bg-red-600 hover:bg-red-500 text-white shadow-red-900/20'
        },
        green: {
            border: 'border-green-500/50',
            shadow: 'shadow-[0_0_50px_rgba(34,197,94,0.2)]',
            glow: 'bg-green-500/10',
            text: 'text-green-400',
            gradient: 'from-green-500/10',
            button: 'bg-green-600 hover:bg-green-500 text-white shadow-green-900/20'
        },
        yellow: {
            border: 'border-yellow-500/50',
            shadow: 'shadow-[0_0_50px_rgba(234,179,8,0.2)]',
            glow: 'bg-yellow-500/10',
            text: 'text-yellow-400',
            gradient: 'from-yellow-500/10',
            button: 'bg-yellow-600 hover:bg-yellow-500 text-black shadow-yellow-900/20'
        }
    };

    const styles = colorStyles[color];

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm">
            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9, y: 20 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        exit={{ opacity: 0, scale: 0.9, y: 20 }}
                        className={cn(
                            "relative w-full max-w-md bg-slate-950/90 border rounded-xl overflow-hidden",
                            styles.border,
                            styles.shadow,
                            className
                        )}
                        onClick={e => e.stopPropagation()}
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
                        <div className={cn("absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-current to-transparent opacity-50", styles.text)} />

                        {/* Close Button */}
                        {showCloseButton && (
                            <button
                                onClick={onClose}
                                className="absolute top-4 right-4 text-slate-500 hover:text-white transition-colors z-20"
                            >
                                <X className="w-5 h-5" />
                            </button>
                        )}

                        {/* Content Container */}
                        <div className="relative z-10 p-8 flex flex-col items-center text-center">

                            {/* Header (Icon + Title) */}
                            {(icon || title) && (
                                <div className="flex flex-col items-center space-y-6 mb-6 w-full">
                                    {icon && (
                                        <div className="relative">
                                            <motion.div
                                                initial={{ scale: 0.8, opacity: 0 }}
                                                animate={{ scale: 1, opacity: 1 }}
                                                transition={{ delay: 0.2 }}
                                                className={cn("w-20 h-20 rounded-full flex items-center justify-center relative group", styles.glow)}
                                            >
                                                <div className={cn("absolute inset-0 border rounded-full opacity-50", styles.border)} />
                                                <div className={cn("w-10 h-10", styles.text)}>
                                                    {icon}
                                                </div>
                                                <div className="absolute inset-0 animate-spin-slow">
                                                    <div className={cn("absolute top-0 left-1/2 w-1 h-1 rounded-full shadow-[0_0_5px_currentColor]", styles.text, "bg-current")} />
                                                </div>
                                            </motion.div>
                                        </div>
                                    )}

                                    <div className="space-y-2">
                                        {title && (
                                            <h2 className={cn("text-2xl font-orbitron font-bold tracking-wider uppercase", styles.text)}>
                                                {title}
                                            </h2>
                                        )}
                                        {description && (
                                            <p className="text-slate-400 text-sm font-mono">
                                                {description}
                                            </p>
                                        )}
                                    </div>
                                </div>
                            )}

                            {/* Body */}
                            <div className="w-full relative">
                                {children}
                            </div>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
