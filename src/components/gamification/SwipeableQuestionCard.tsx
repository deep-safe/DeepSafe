import React, { useState, useRef } from 'react';
import { motion, useMotionValue, useTransform, PanInfo, AnimatePresence } from 'framer-motion';
import { Check, X, ArrowLeft, ArrowRight } from 'lucide-react';
import { cn } from '@/lib/utils';
import { useHaptics } from '@/hooks/useHaptics';
import { NotificationType } from '@capacitor/haptics';

interface SwipeableQuestionCardProps {
    questionText: string;
    options: string[]; // Assumes [Option 0 (Left/False), Option 1 (Right/True)]
    onAnswer: (index: number) => void;
    disabled?: boolean;
}

export function SwipeableQuestionCard({ questionText, options, onAnswer, disabled }: SwipeableQuestionCardProps) {
    const [exitX, setExitX] = useState<number | null>(null);
    const x = useMotionValue(0);
    const rotate = useTransform(x, [-200, 200], [-25, 25]);
    const opacity = useTransform(x, [-200, -100, 0, 100, 200], [0.5, 1, 1, 1, 0.5]);

    // Background colors based on swipe direction
    const bgLeft = useTransform(x, [-150, 0], ["rgba(239, 68, 68, 0.2)", "rgba(0,0,0,0)"]); // Red tint
    const bgRight = useTransform(x, [0, 150], ["rgba(0,0,0,0)", "rgba(34, 197, 94, 0.2)"]); // Green tint

    const { impact, notification } = useHaptics();

    const handleDragEnd = async (event: any, info: PanInfo) => {
        if (disabled) return;

        const threshold = 100;

        if (info.offset.x > threshold) {
            // Swiped Right -> Option 1
            setExitX(200);
            await impact();
            onAnswer(1);
        } else if (info.offset.x < -threshold) {
            // Swiped Left -> Option 0
            setExitX(-200);
            await impact();
            onAnswer(0);
        }
    };

    return (
        <div className="relative w-full h-[400px] flex items-center justify-center perspective-1000">
            {/* Background Hints */}
            <div className="absolute inset-0 flex justify-between items-center px-8 pointer-events-none">
                <div className="flex flex-col items-center gap-2 opacity-30">
                    <div className="w-16 h-16 rounded-full border-4 border-red-500 flex items-center justify-center">
                        <X className="w-8 h-8 text-red-500" />
                    </div>
                    <span className="text-red-500 font-bold">{options[0]}</span>
                </div>
                <div className="flex flex-col items-center gap-2 opacity-30">
                    <div className="w-16 h-16 rounded-full border-4 border-green-500 flex items-center justify-center">
                        <Check className="w-8 h-8 text-green-500" />
                    </div>
                    <span className="text-green-500 font-bold">{options[1]}</span>
                </div>
            </div>

            <AnimatePresence>
                {exitX === null && (
                    <motion.div
                        style={{ x, rotate, opacity }}
                        drag={disabled ? false : "x"}
                        dragConstraints={{ left: 0, right: 0 }}
                        dragElastic={0.7}
                        onDragEnd={handleDragEnd}
                        className="absolute w-full max-w-sm aspect-[3/4] bg-zinc-900 border border-white/10 rounded-3xl shadow-2xl overflow-hidden cursor-grab active:cursor-grabbing touch-none"
                        initial={{ scale: 0.9, opacity: 0, y: 50 }}
                        animate={{ scale: 1, opacity: 1, y: 0 }}
                        exit={{ x: exitX || 0, opacity: 0, transition: { duration: 0.2 } }}
                        whileTap={{ scale: 1.05 }}
                    >
                        {/* Dynamic Background Tints */}
                        <motion.div style={{ backgroundColor: bgLeft }} className="absolute inset-0 z-0 pointer-events-none" />
                        <motion.div style={{ backgroundColor: bgRight }} className="absolute inset-0 z-0 pointer-events-none" />

                        {/* Card Content */}
                        <div className="relative z-10 h-full flex flex-col p-8">
                            <div className="flex-1 flex items-center justify-center">
                                <h3 className="text-2xl font-bold text-center font-orbitron text-white leading-relaxed">
                                    {questionText}
                                </h3>
                            </div>

                            {/* Swipe Indicators */}
                            <div className="flex justify-between items-center text-sm font-bold tracking-widest uppercase text-white/50 mt-auto">
                                <div className="flex items-center gap-2">
                                    <ArrowLeft className="w-4 h-4" />
                                    {options[0]}
                                </div>
                                <div className="flex items-center gap-2">
                                    {options[1]}
                                    <ArrowRight className="w-4 h-4" />
                                </div>
                            </div>
                        </div>

                        {/* Overlay Labels (Like Tinder) */}
                        <motion.div
                            style={{ opacity: useTransform(x, [50, 150], [0, 1]) }}
                            className="absolute top-8 left-8 border-4 border-green-500 rounded-lg px-4 py-2 -rotate-12 z-20"
                        >
                            <span className="text-green-500 font-bold text-2xl uppercase">{options[1]}</span>
                        </motion.div>

                        <motion.div
                            style={{ opacity: useTransform(x, [-150, -50], [1, 0]) }}
                            className="absolute top-8 right-8 border-4 border-red-500 rounded-lg px-4 py-2 rotate-12 z-20"
                        >
                            <span className="text-red-500 font-bold text-2xl uppercase">{options[0]}</span>
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
