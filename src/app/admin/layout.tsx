'use client';

import React, { useState, useEffect } from 'react';
import { Shield, Lock, ChevronRight, AlertTriangle, LogIn } from 'lucide-react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase/client';
import { Database } from '@/types/supabase';

// Initialize Supabase Client
// Client is already initialized

export default function AdminLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    const [isUnlocked, setIsUnlocked] = useState(false);
    const [password, setPassword] = useState('');
    const [error, setError] = useState(false);
    const [isLoading, setIsLoading] = useState(true);

    // Auth State
    const [authStatus, setAuthStatus] = useState<'loading' | 'unauthenticated' | 'unauthorized' | 'authorized'>('loading');
    const [userEmail, setUserEmail] = useState<string | null>(null);

    const router = useRouter();

    useEffect(() => {
        checkAuth();
    }, []);

    const checkAuth = async () => {
        setIsLoading(true);
        setAuthStatus('loading');

        // 1. Check Session
        const { data: { user } } = await supabase.auth.getUser();

        if (!user) {
            setAuthStatus('unauthenticated');
            setIsLoading(false);
            return;
        }

        setUserEmail(user.email || 'Unknown User');

        // 2. Check Admin Role
        const { data: profile } = await supabase
            .from('profiles')
            .select('is_admin')
            .eq('id', user.id)
            .single();

        if (!profile?.is_admin) {
            setAuthStatus('unauthorized');
            setIsLoading(false);
            return;
        }

        setAuthStatus('authorized');

        // 3. Check Lock Screen State
        const unlocked = sessionStorage.getItem('admin_unlocked');
        if (unlocked === 'true') {
            setIsUnlocked(true);
        }
        setIsLoading(false);
    };

    const handleUnlock = (e: React.FormEvent) => {
        e.preventDefault();
        const adminPassword = process.env.NEXT_PUBLIC_ADMIN_PASSWORD;

        if (!adminPassword) {
            alert('ERRORE SICUREZZA: Password Admin non configurata nel sistema (.env).');
            return;
        }

        if (password === adminPassword) {
            sessionStorage.setItem('admin_unlocked', 'true');
            setIsUnlocked(true);
            setError(false);
        } else {
            setError(true);
            setPassword('');
        }
    };

    const handleExit = () => {
        router.push('/');
    };

    if (isLoading || authStatus === 'loading') {
        return <div className="min-h-screen bg-black flex items-center justify-center text-cyan-500 font-mono animate-pulse">VERIFYING SECURITY CLEARANCE...</div>;
    }

    // SCENARIO 1: Not Logged In
    if (authStatus === 'unauthenticated') {
        return (
            <div className="min-h-screen bg-slate-950 flex items-center justify-center p-4 font-sans">
                <div className="max-w-md w-full bg-slate-900 border border-red-900/30 rounded-2xl p-8 shadow-2xl shadow-red-900/10">
                    <div className="flex justify-center mb-6">
                        <div className="w-16 h-16 bg-red-900/20 rounded-full flex items-center justify-center border border-red-500/30">
                            <LogIn className="w-8 h-8 text-red-500" />
                        </div>
                    </div>
                    <h1 className="text-2xl font-bold text-white text-center font-orbitron mb-2">AUTHENTICATION REQUIRED</h1>
                    <p className="text-slate-400 text-center text-sm mb-6 font-mono">
                        You must be logged in to access the Admin Console.
                    </p>
                    <div className="bg-slate-950 p-4 rounded border border-slate-800 mb-6 text-xs font-mono text-red-400">
                        ERROR: NO_ACTIVE_SESSION
                    </div>
                    <button
                        onClick={() => router.push('/login')}
                        className="w-full bg-slate-800 hover:bg-slate-700 text-white font-bold py-3 rounded-lg transition-all flex items-center justify-center gap-2"
                    >
                        GO TO LOGIN
                    </button>
                    <div className="mt-4 text-center">
                        <button onClick={handleExit} className="text-slate-500 hover:text-slate-300 text-xs font-mono">
                            ← RETURN TO HOME
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    // SCENARIO 2: Logged In but Not Admin
    if (authStatus === 'unauthorized') {
        return (
            <div className="min-h-screen bg-slate-950 flex items-center justify-center p-4 font-sans">
                <div className="max-w-md w-full bg-slate-900 border border-red-500/50 rounded-2xl p-8 shadow-2xl shadow-red-900/20">
                    <div className="flex justify-center mb-6">
                        <div className="w-16 h-16 bg-red-900/20 rounded-full flex items-center justify-center border border-red-500">
                            <AlertTriangle className="w-8 h-8 text-red-500" />
                        </div>
                    </div>
                    <h1 className="text-2xl font-bold text-white text-center font-orbitron mb-2">ACCESS DENIED</h1>
                    <p className="text-slate-400 text-center text-sm mb-6 font-mono">
                        Your account <span className="text-white font-bold">({userEmail})</span> is not enabled for admin access.
                    </p>
                    <div className="bg-slate-950 p-4 rounded border border-slate-800 mb-6 text-xs font-mono text-red-400">
                        ERROR: INSUFFICIENT_PRIVILEGES
                        <br />
                        REQUIRED_ROLE: ADMIN
                    </div>
                    <button
                        onClick={handleExit}
                        className="w-full bg-red-600 hover:bg-red-500 text-white font-bold py-3 rounded-lg transition-all shadow-lg shadow-red-900/20"
                    >
                        RETURN TO DASHBOARD
                    </button>
                </div>
            </div>
        );
    }

    // SCENARIO 3: Admin, but Locked (Enter Code)
    if (!isUnlocked) {
        return (
            <div className="min-h-screen bg-slate-950 flex items-center justify-center p-4 font-sans">
                <div className="max-w-md w-full bg-slate-900 border border-slate-800 rounded-2xl p-8 shadow-2xl shadow-cyan-900/20">
                    <div className="flex justify-center mb-6">
                        <div className="w-16 h-16 bg-slate-800 rounded-full flex items-center justify-center border border-slate-700">
                            <Shield className="w-8 h-8 text-cyan-500" />
                        </div>
                    </div>

                    <h1 className="text-2xl font-bold text-white text-center font-orbitron mb-2">RESTRICTED ACCESS</h1>
                    <p className="text-slate-400 text-center text-sm mb-2 font-mono">
                        Welcome, <span className="text-cyan-400">{userEmail}</span>.
                    </p>
                    <p className="text-slate-500 text-center text-xs mb-8 font-mono">
                        Please confirm your identity with the access code.
                    </p>

                    <form onSubmit={handleUnlock} className="space-y-4">
                        <div>
                            <div className="relative">
                                <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-500" />
                                <input
                                    type="password"
                                    value={password}
                                    onChange={(e) => {
                                        setPassword(e.target.value);
                                        setError(false);
                                    }}
                                    placeholder="Enter Access Code"
                                    className="w-full bg-slate-950 border border-slate-700 rounded-lg pl-10 pr-4 py-3 text-white focus:border-cyan-500 focus:ring-1 focus:ring-cyan-500 outline-none transition-all font-mono"
                                    autoFocus
                                />
                            </div>
                            {error && (
                                <p className="text-red-500 text-xs mt-2 font-mono text-center">
                                    ACCESS DENIED: Invalid credentials.
                                </p>
                            )}
                        </div>

                        <button
                            type="submit"
                            className="w-full bg-cyan-600 hover:bg-cyan-500 text-white font-bold py-3 rounded-lg transition-all shadow-lg shadow-cyan-900/20 flex items-center justify-center gap-2 group"
                        >
                            AUTHENTICATE
                            <ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                        </button>
                    </form>

                    <div className="mt-6 text-center">
                        <button
                            onClick={handleExit}
                            className="text-slate-500 hover:text-slate-300 text-xs font-mono transition-colors"
                        >
                            ← RETURN TO APPLICATION
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    return <>{children}</>;
}
