'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { X, MapPin, ArrowRight, Lock } from 'lucide-react';
import { Province } from '@/data/provincesData';

interface ProvinceModalProps {
    province: Province;
    onClose: () => void;
    onStartMission: () => void;
}

export default function ProvinceModal({ province, onClose, onStartMission }: ProvinceModalProps) {
    const isLocked = province.status === 'locked';

    // Theme configuration based on status
    const theme = isLocked ? {
        color: 'text-cyber-red',
        borderColor: 'border-cyber-red',
        bgColor: 'bg-cyber-red/10',
        glowColor: 'shadow-[0_0_50px_rgba(255,50,50,0.2)]',
        buttonBg: 'hover:bg-cyber-red/20',
        buttonBorder: 'hover:border-white',
        buttonShadow: 'shadow-[0_0_20px_rgba(255,50,50,0.5)] hover:shadow-[0_0_50px_rgba(255,50,50,0.8)]',
        icon: <Lock className="w-6 h-6" />,
        title: 'ACCESSO NEGATO',
        description: `Il settore ${province.name} è attualmente bloccato. Completa le missioni nei settori adiacenti per ottenere i codici di accesso.`,
        buttonText: 'CHIUDI',
        securityLevel: 'ESTREMO'
    } : {
        color: 'text-cyber-blue',
        borderColor: 'border-cyber-blue',
        bgColor: 'bg-cyber-blue/10',
        glowColor: 'shadow-[0_0_50px_rgba(102,252,241,0.2)]',
        buttonBg: 'hover:bg-cyber-blue/20',
        buttonBorder: 'hover:border-white',
        buttonShadow: 'shadow-[0_0_20px_rgba(102,252,241,0.5)] hover:shadow-[0_0_50px_rgba(102,252,241,0.8)]',
        icon: <MapPin className="w-6 h-6" />,
        title: province.name,
        description: `Rilevata attività anomala nel settore ${province.name}. Protocolli di sicurezza compromessi. Richiesto intervento immediato per ripristinare il firewall regionale.`,
        buttonText: 'VAI ALLA MISSIONE',
        securityLevel: 'CRITICO'
    };

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            {/* Backdrop */}
            <motion.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                onClick={onClose}
                className="absolute inset-0 bg-black/80 backdrop-blur-sm"
            />

            {/* Modal Content */}
            <motion.div
                initial={{ scale: 0.9, opacity: 0, y: 20 }}
                animate={{ scale: 1, opacity: 1, y: 0 }}
                exit={{ scale: 0.9, opacity: 0, y: 20 }}
                className={`relative w-full max-w-md bg-cyber-dark border ${theme.borderColor}/30 rounded-2xl overflow-hidden ${theme.glowColor}`}
            >
                {/* Decorative Header Line */}
                <div className={`absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-${isLocked ? 'cyber-red' : 'cyber-blue'} to-transparent`} />

                {/* Close Button */}
                <button
                    onClick={onClose}
                    className="absolute top-4 right-4 text-cyber-gray hover:text-white transition-colors z-10"
                >
                    <X className="w-6 h-6" />
                </button>

                <div className="p-6 space-y-6">
                    {/* Header */}
                    <div className="text-center space-y-2">
                        <div className={`inline-flex items-center justify-center w-12 h-12 rounded-full ${theme.bgColor} ${theme.color} mb-2 border ${theme.borderColor}/30`}>
                            {theme.icon}
                        </div>
                        <h2 className="text-2xl font-bold font-orbitron text-white uppercase tracking-widest text-glow">
                            {theme.title}
                        </h2>
                        <div className={`text-xs font-mono ${theme.color}/60 uppercase tracking-[0.2em]`}>
                            Settore {province.id}
                        </div>
                    </div>

                    {/* Content */}
                    <div className="bg-black/40 rounded-xl p-4 border border-white/5 space-y-3">
                        <div className="flex justify-between items-center text-xs font-mono text-cyber-gray uppercase">
                            <span>Livello Sicurezza</span>
                            <span className={`${theme.color} font-bold`}>{theme.securityLevel}</span>
                        </div>
                        <p className="text-sm text-zinc-300 leading-relaxed font-sans">
                            {theme.description}
                        </p>
                    </div>

                    {/* Action Button */}
                    <button
                        onClick={isLocked ? onClose : onStartMission}
                        className={`w-full py-4 bg-black border ${theme.borderColor} text-white font-bold font-orbitron uppercase tracking-widest rounded-xl ${theme.buttonBg} ${theme.buttonBorder} hover:text-white transition-all duration-300 ${theme.buttonShadow} flex items-center justify-center gap-2 group`}
                    >
                        <span>{theme.buttonText}</span>
                        {!isLocked && <ArrowRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />}
                    </button>
                </div>

                {/* Decorative Corner Accents */}
                <div className={`absolute bottom-0 left-0 w-8 h-8 border-b-2 border-l-2 ${theme.borderColor}/30 rounded-bl-xl`} />
                <div className={`absolute bottom-0 right-0 w-8 h-8 border-b-2 border-r-2 ${theme.borderColor}/30 rounded-br-xl`} />
            </motion.div>
        </div>
    );
}
