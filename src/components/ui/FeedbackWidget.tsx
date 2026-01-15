'use client';

import React, { useState, useEffect } from 'react';
import { AnimatePresence, motion } from 'framer-motion';
import { ThumbsUp, ThumbsDown, X, Send, Heart } from 'lucide-react';
import { supabase } from '@/lib/supabase/client';
import { cn } from '@/lib/utils';
import { useSystemUI } from '@/context/SystemUIContext';

type FeedbackState = 'INITIAL' | 'POSITIVE' | 'NEGATIVE' | 'THANKS' | 'HIDDEN';

export const FeedbackWidget = () => {
    const [state, setState] = useState<FeedbackState>('HIDDEN');
    const [message, setMessage] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const { showToast } = useSystemUI();

    useEffect(() => {
        // Check local storage delay
        const lastFeedback = localStorage.getItem('deepsafe_feedback_date');
        const dismissed = localStorage.getItem('deepsafe_feedback_dismissed');
        const now = new Date();

        if (lastFeedback) {
            const lastDate = new Date(lastFeedback);
            const diffDays = (now.getTime() - lastDate.getTime()) / (1000 * 3600 * 24);
            if (diffDays < 30) return; // Don't show if already given in last 30 days
        }

        if (dismissed) {
            const dismissedDate = new Date(dismissed);
            const diffDays = (now.getTime() - dismissedDate.getTime()) / (1000 * 3600 * 24);
            if (diffDays < 7) return; // Don't show if dismissed in last 7 days
        }

        // Delay appearance to not be annoying immediately
        const timer = setTimeout(() => {
            setState('INITIAL');
        }, 10000); // 10 seconds after load

        return () => clearTimeout(timer);
    }, []);

    const handleDismiss = () => {
        setState('HIDDEN');
        localStorage.setItem('deepsafe_feedback_dismissed', new Date().toISOString());
    };

    const submitFeedback = async (type: 'like' | 'dislike', msg: string = '') => {
        setIsSubmitting(true);
        try {
            const deviceInfo = {
                userAgent: navigator.userAgent,
                platform: navigator.platform,
                language: navigator.language,
                screen: {
                    width: window.screen.width,
                    height: window.screen.height
                }
            };

            const { data: { user } } = await supabase.auth.getUser();

            const { error } = await supabase.from('feedback').insert({
                user_id: user?.id || 'anonymous',
                type,
                message: msg || (type === 'like' ? 'Thumbs Up' : 'Thumbs Down'),
                device_info: deviceInfo,
                status: 'new'
            });

            if (error) throw error;

            setState('THANKS');
            localStorage.setItem('deepsafe_feedback_date', new Date().toISOString());

            setTimeout(() => {
                setState('HIDDEN');
            }, 3000);

        } catch (error) {
            console.error('Error submitting feedback:', error);
            showToast('Errore nell\'invio del feedback', 'error');
            setState('HIDDEN');
        } finally {
            setIsSubmitting(false);
        }
    };

    const handleVote = (type: 'like' | 'dislike') => {
        if (type === 'like') {
            setState('POSITIVE');
            // Auto submit like
            submitFeedback('like');
        } else {
            setState('NEGATIVE');
        }
    };

    const handleTextSubmit = () => {
        if (!message.trim()) return;
        submitFeedback('dislike', message);
    };

    if (state === 'HIDDEN') return null;

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0, y: 50, scale: 0.9 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: 20, scale: 0.95 }}
                className="fixed bottom-20 md:bottom-8 right-4 md:right-8 z-50 w-[calc(100vw-2rem)] md:w-80"
            >
                <div className="bg-black/80 backdrop-blur-xl border border-white/10 rounded-2xl p-4 shadow-2xl relative overflow-hidden">
                    {/* Background Gradient */}
                    <div className="absolute inset-0 bg-cyber-blue/5 pointer-events-none" />

                    {/* Close Button */}
                    <button
                        onClick={handleDismiss}
                        className="absolute top-2 right-2 p-1 text-white/40 hover:text-white rounded-lg hover:bg-white/10 transition-colors"
                    >
                        <X className="w-4 h-4" />
                    </button>

                    <div className="relative">
                        {state === 'INITIAL' && (
                            <div className="flex flex-col gap-3">
                                <div className="flex items-center gap-3">
                                    <div className="p-2 bg-gradient-to-br from-cyber-blue to-cyber-purple rounded-xl">
                                        <Heart className="w-5 h-5 text-white fill-white" />
                                    </div>
                                    <div>
                                        <h3 className="text-sm font-bold text-white font-orbitron">Ti piace DeepSafe?</h3>
                                        <p className="text-xs text-white/60">Il tuo parere conta per noi.</p>
                                    </div>
                                </div>
                                <div className="flex gap-2 pt-1">
                                    <button
                                        onClick={() => handleVote('dislike')}
                                        className="flex-1 py-2 px-3 bg-white/5 hover:bg-white/10 rounded-lg text-white/80 hover:text-white transition-all flex justify-center items-center gap-2 text-sm font-medium group"
                                    >
                                        <ThumbsDown className="w-4 h-4 group-hover:-rotate-12 transition-transform" />
                                        No
                                    </button>
                                    <button
                                        onClick={() => handleVote('like')}
                                        className="flex-1 py-2 px-3 bg-cyber-blue/20 hover:bg-cyber-blue/30 border border-cyber-blue/30 rounded-lg text-cyber-blue hover:text-white transition-all flex justify-center items-center gap-2 text-sm font-medium group"
                                    >
                                        <ThumbsUp className="w-4 h-4 group-hover:-rotate-12 transition-transform mb-1" />
                                        Sì!
                                    </button>
                                </div>
                            </div>
                        )}

                        {state === 'POSITIVE' && (
                            <div className="text-center py-2 animate-in fade-in slide-in-from-bottom-4">
                                <div className="w-12 h-12 bg-green-500/20 rounded-full flex items-center justify-center mx-auto mb-3 text-green-400 border border-green-500/30">
                                    <ThumbsUp className="w-6 h-6 fill-green-500/50" />
                                </div>
                                <h3 className="text-white font-bold mb-1">Fantastico!</h3>
                                <p className="text-xs text-white/60 mb-3">Grazie per il supporto, stiamo lavorando sodo!</p>
                            </div>
                        )}

                        {state === 'NEGATIVE' && (
                            <div className="animate-in fade-in slide-in-from-bottom-4">
                                <h3 className="text-sm font-bold text-white mb-2">Cosa possiamo migliorare?</h3>
                                <textarea
                                    value={message}
                                    onChange={(e) => setMessage(e.target.value)}
                                    placeholder="Dicci cosa non va..."
                                    className="w-full bg-black/50 border border-white/10 rounded-lg p-2 text-sm text-white placeholder:text-white/30 focus:outline-none focus:border-cyber-blue min-h-[80px] mb-2 resize-none"
                                />
                                <button
                                    onClick={handleTextSubmit}
                                    disabled={!message.trim() || isSubmitting}
                                    className="w-full py-2 bg-cyber-blue hover:bg-cyber-blue/80 text-white rounded-lg text-sm font-bold flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed transition-colors shadow-lg shadow-cyber-blue/20"
                                >
                                    {isSubmitting ? (
                                        <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                                    ) : (
                                        <>
                                            Invia Feedback
                                            <Send className="w-3 h-3" />
                                        </>
                                    )}
                                </button>
                            </div>
                        )}

                        {state === 'THANKS' && (
                            <div className="text-center py-4 animate-in fade-in zoom-in">
                                <h3 className="text-lg font-bold bg-gradient-to-r from-cyber-blue to-cyber-purple bg-clip-text text-transparent mb-1">
                                    Grazie!
                                </h3>
                                <p className="text-sm text-white/80">Il tuo feedback è prezioso.</p>
                            </div>
                        )}
                    </div>
                </div>
            </motion.div>
        </AnimatePresence>
    );
};
