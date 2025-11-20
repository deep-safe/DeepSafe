'use client';



import { useState, useEffect, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import { createClient } from '@supabase/supabase-js';
import { motion } from 'framer-motion';
import { Database } from '@/types/supabase';
import { Loader2, AlertCircle, CheckCircle, Shield } from 'lucide-react';
import { cn } from '@/lib/utils';

// Initialize Supabase client
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder';
const supabase = createClient<Database>(supabaseUrl, supabaseKey);

function LoginContent() {
    const [loading, setLoading] = useState(false);
    const [mounted, setMounted] = useState(false);
    const searchParams = useSearchParams();
    const error = searchParams.get('error');
    const errorMessage = searchParams.get('message');

    // Ensure client-side rendering for particles
    useEffect(() => {
        setMounted(true);
    }, []);

    const handleGoogleLogin = async () => {
        console.log('🔵 Google login button clicked');
        console.log('🔵 Redirect will be to:', `${window.location.origin}/auth/callback`);

        setLoading(true);
        try {
            console.log('🔵 Initiating OAuth with Supabase...');
            const { data, error } = await supabase.auth.signInWithOAuth({
                provider: 'google',
                options: {
                    redirectTo: `${window.location.origin}/auth/callback`,
                    queryParams: {
                        access_type: 'offline',
                        prompt: 'consent',
                    },
                },
            });

            console.log('🔵 OAuth response:', { data, error });

            if (error) {
                console.error('❌ OAuth initiation error:', error);
                throw error;
            }

            console.log('✅ OAuth initiated successfully, should redirect to Google...');
        } catch (err: any) {
            console.error('❌ Login error:', err);
            alert(err.message || 'Failed to initiate login');
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen relative flex items-center justify-center overflow-hidden bg-cyber-dark">
            {/* Animated Grid Background */}
            <div className="absolute inset-0 bg-[linear-gradient(rgba(69,162,158,0.03)_1px,transparent_1px),linear-gradient(90deg,rgba(69,162,158,0.03)_1px,transparent_1px)] bg-[size:60px_60px] animate-pulse-slow pointer-events-none" />

            {/* Floating Particles - Only render on client */}
            {mounted && (
                <div className="absolute inset-0 overflow-hidden pointer-events-none">
                    {[...Array(20)].map((_, i) => (
                        <motion.div
                            key={i}
                            className="absolute w-1 h-1 bg-cyber-blue rounded-full"
                            initial={{
                                x: Math.random() * window.innerWidth,
                                y: Math.random() * window.innerHeight,
                                opacity: 0,
                            }}
                            animate={{
                                y: [null, Math.random() * window.innerHeight],
                                opacity: [0, 0.5, 0],
                            }}
                            transition={{
                                duration: Math.random() * 10 + 10,
                                repeat: Infinity,
                                delay: Math.random() * 5,
                            }}
                        />
                    ))}
                </div>
            )}

            {/* Radial Gradient Glow */}
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(69,162,158,0.1)_0%,transparent_70%)] pointer-events-none" />

            {/* Main Login Card */}
            <motion.div
                initial={{ opacity: 0, y: 40, scale: 0.95 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                transition={{ duration: 0.6, ease: 'easeOut' }}
                className="relative z-10 w-full max-w-md mx-4"
            >
                {/* Outer Glow */}
                <div className="absolute inset-0 bg-cyber-blue/10 blur-3xl rounded-3xl" />

                {/* Glass Card */}
                <div className="relative glass-panel border-2 border-cyber-blue/30 rounded-3xl p-8 space-y-8 shadow-[0_0_60px_rgba(69,162,158,0.2)]">
                    {/* Logo Section */}
                    <div className="text-center space-y-3">
                        {/* Logo Icon */}
                        <motion.div
                            initial={{ scale: 0, rotate: -180 }}
                            animate={{ scale: 1, rotate: 0 }}
                            transition={{ duration: 0.8, ease: 'easeOut', delay: 0.2 }}
                            className="flex justify-center mb-4"
                        >
                            <div className="relative">
                                {/* Pulsing rings */}
                                <motion.div
                                    className="absolute inset-0 rounded-full border-2 border-cyber-blue"
                                    animate={{
                                        scale: [1, 1.3, 1],
                                        opacity: [0.5, 0, 0.5],
                                    }}
                                    transition={{ duration: 2, repeat: Infinity }}
                                />
                                <motion.div
                                    className="absolute inset-0 rounded-full border-2 border-cyber-blue"
                                    animate={{
                                        scale: [1, 1.5, 1],
                                        opacity: [0.3, 0, 0.3],
                                    }}
                                    transition={{ duration: 2, repeat: Infinity, delay: 0.5 }}
                                />
                                {/* Shield Icon */}
                                <div className="relative w-20 h-20 bg-cyber-blue/20 rounded-full flex items-center justify-center border-2 border-cyber-blue shadow-[0_0_30px_rgba(69,162,158,0.4)]">
                                    <Shield className="w-10 h-10 text-cyber-blue" />
                                </div>
                            </div>
                        </motion.div>

                        {/* Title */}
                        <motion.h1
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.6, delay: 0.4 }}
                            className="text-5xl font-bold font-orbitron tracking-tight"
                            style={{
                                background: 'linear-gradient(to right, #66FCF1, #45A29E)',
                                WebkitBackgroundClip: 'text',
                                WebkitTextFillColor: 'transparent',
                                filter: 'drop-shadow(0 0 20px rgba(102, 252, 241, 0.5))',
                            }}
                        >
                            DEEPSAFE
                        </motion.h1>

                        {/* Subtitle */}
                        <motion.p
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 0.6, delay: 0.6 }}
                            className="text-cyber-blue font-mono text-sm tracking-widest uppercase"
                        >
                            &gt; Initialize Protocol...
                        </motion.p>
                    </div>

                    {/* Error Alert */}
                    {error && (
                        <motion.div
                            initial={{ opacity: 0, height: 0 }}
                            animate={{ opacity: 1, height: 'auto' }}
                            className="bg-cyber-red/10 border border-cyber-red/50 rounded-xl p-4 flex gap-3"
                        >
                            <AlertCircle className="w-5 h-5 text-cyber-red flex-shrink-0 mt-0.5" />
                            <div className="space-y-1">
                                <p className="text-sm font-bold text-cyber-red font-orbitron">
                                    ACCESS DENIED
                                </p>
                                <p className="text-xs text-zinc-400">
                                    {errorMessage || 'Authentication failed. Please try again.'}
                                </p>
                            </div>
                        </motion.div>
                    )}

                    {/* Google Holo-Button */}
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.6, delay: 0.8 }}
                    >
                        <button
                            onClick={handleGoogleLogin}
                            disabled={loading}
                            className={cn(
                                "w-full py-4 rounded-xl font-bold flex items-center justify-center gap-3 transition-all duration-300 relative group overflow-hidden",
                                "border-2 border-white/50 bg-transparent backdrop-blur-sm",
                                "hover:border-cyber-blue hover:shadow-[0_0_30px_rgba(69,162,158,0.6)] hover:bg-cyber-blue/10",
                                "disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:border-white/50 disabled:hover:shadow-none"
                            )}
                        >
                            {loading ? (
                                <>
                                    <Loader2 className="w-6 h-6 animate-spin text-cyber-blue" />
                                    <span className="text-cyber-blue font-mono tracking-widest text-sm">
                                        CONNECTING TO GOOGLE...
                                    </span>
                                </>
                            ) : (
                                <>
                                    {/* Google Logo */}
                                    <svg className="w-6 h-6" viewBox="0 0 24 24">
                                        <path
                                            fill="#4285F4"
                                            d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                                        />
                                        <path
                                            fill="#34A853"
                                            d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                                        />
                                        <path
                                            fill="#FBBC05"
                                            d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                                        />
                                        <path
                                            fill="#EA4335"
                                            d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                                        />
                                    </svg>
                                    <span className="text-white group-hover:text-cyber-blue transition-colors font-orbitron tracking-wide text-sm">
                                        AUTHENTICATE VIA GOOGLE
                                    </span>
                                </>
                            )}

                            {/* Animated scan line effect */}
                            <div className="absolute inset-0 bg-gradient-to-r from-transparent via-white/20 to-transparent -translate-x-full group-hover:translate-x-full transition-transform duration-1000 pointer-events-none" />
                        </button>
                    </motion.div>

                    {/* System Status */}
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ duration: 0.6, delay: 1 }}
                        className="pt-4 border-t border-cyber-blue/20"
                    >
                        <div className="flex items-center justify-center gap-2 text-xs">
                            <CheckCircle className="w-4 h-4 text-cyber-green" />
                            <span className="text-cyber-green font-mono tracking-wider">
                                SECURE CONNECTION: ESTABLISHED
                            </span>
                        </div>
                        <p className="text-center text-cyber-gray font-mono text-[10px] mt-2 tracking-widest">
                            [ ENCRYPTION: AES-256 | PROTOCOL: HTTPS ]
                        </p>
                    </motion.div>
                </div>
            </motion.div>

            {/* Bottom Decorative Line */}
            <div className="absolute bottom-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-cyber-blue to-transparent opacity-50" />
        </div>
    );
}

export default function LoginPage() {
    return (
        <Suspense fallback={
            <div className="min-h-screen flex items-center justify-center bg-cyber-dark">
                <Loader2 className="w-8 h-8 animate-spin text-cyber-blue" />
            </div>
        }>
            <LoginContent />
        </Suspense>
    );
}
