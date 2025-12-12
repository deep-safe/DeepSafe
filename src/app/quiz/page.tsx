'use client';

import { useState, useEffect } from 'react';
import { useParams, useRouter, useSearchParams } from 'next/navigation';
import { ArrowLeft, Check, X, AlertTriangle } from 'lucide-react';
import { Quiz } from '@/lib/mockData';
import { useUserStore } from '@/store/useUserStore';
import { cn } from '@/lib/utils';
import Link from 'next/link';
import { supabase } from '@/lib/supabase/client';
import { Database } from '@/types/supabase';
import { VisualQuizCard } from '@/components/gamification/VisualQuizCard';
import { QuizActionPanel } from '@/components/gamification/QuizActionPanel';
import { SystemFailureModal } from '@/components/gamification/SystemFailureModal';
import { PerfectScoreModal } from '@/components/gamification/PerfectScoreModal';
import { motion, AnimatePresence } from 'framer-motion';
import posthog from 'posthog-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://placeholder.supabase.co';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'placeholder';
// Client is already initialized

import { submitDuelScore } from '@/lib/challenges';


export default function QuizPage() {
    const router = useRouter();
    const searchParams = useSearchParams();
    const id = searchParams.get('id');
    const mode = searchParams.get('mode');
    const challengeId = searchParams.get('challengeId');
    const lives = useUserStore(state => state.lives);
    const decrementLives = useUserStore(state => state.decrementLives);
    const incrementStreak = useUserStore(state => state.incrementStreak);
    const refillLives = useUserStore(state => state.refillLives);
    const setInfiniteLives = useUserStore(state => state.setInfiniteLives);

    const [quiz, setQuiz] = useState<Quiz | null>(null);
    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const [selectedOption, setSelectedOption] = useState<number | null>(null);
    const [isAnswered, setIsAnswered] = useState(false);
    const [isCorrect, setIsCorrect] = useState(false);
    const [score, setScore] = useState(0);
    const [showShopModal, setShowShopModal] = useState(false);
    const [showReward, setShowReward] = useState(false);
    const [showPerfectScoreModal, setShowPerfectScoreModal] = useState(false);
    const [newBadgeId, setNewBadgeId] = useState<string | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const checkAuthAndFetch = async () => {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                router.push('/login');
                return;
            }

            try {
                setLoading(true);
                // 1. Fetch Level Info
                const { data: levelData, error: levelError } = await supabase
                    .from('levels')
                    .select('*')
                    .eq('id', id as string)
                    .single();

                if (levelError) throw levelError;

                // 2. Fetch Questions
                const { data: questionsData, error: questionsError } = await supabase
                    .from('questions')
                    .select('*')
                    .eq('level_id', id as string);

                if (questionsError) throw questionsError;

                // 3. Construct Quiz Object
                const fetchedQuiz: Quiz = {
                    id: levelData.id,
                    title: levelData.title,
                    description: 'Missione attiva', // Could fetch from modules if needed
                    completed: false,
                    locked: false,
                    questions: questionsData.map((q: any) => ({
                        id: q.id,
                        type: q.type,
                        text: q.text,
                        imageUrl: q.image_url,
                        hotspots: q.hotspots,
                        options: q.options,
                        correctAnswer: q.correct_index,
                        explanation: q.explanation || ''
                    }))
                };

                setQuiz(fetchedQuiz);
            } catch (error) {
                console.error('Error fetching quiz:', error);
            } finally {
                setLoading(false);
            }
        };

        if (id) {
            checkAuthAndFetch();
        }
    }, [id, router]);

    if (!quiz) return <div className="p-4 text-cyber-blue animate-pulse">Inizializzazione Sistema...</div>;

    // Shop Modal
    if (showShopModal) {
        return (
            <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4">
                <div className="glass-panel p-6 rounded-2xl max-w-sm w-full text-center space-y-4 animate-in zoom-in duration-200 border-cyber-red/50">
                    <div className="w-16 h-16 bg-cyber-red/20 rounded-full flex items-center justify-center mx-auto text-2xl animate-pulse">
                        💔
                    </div>
                    <h2 className="text-xl font-bold font-orbitron text-cyber-red text-glow-danger">Errore di Sistema</h2>
                    <p className="text-zinc-400">Esaurimento risorse critiche. Ricarica richiesta.</p>
                    <div className="flex flex-col gap-2">
                        <Link href="/shop" className="w-full py-3 bg-cyber-blue text-cyber-dark rounded-xl font-bold hover:bg-cyber-green transition-colors">
                            Accedi al Deposito
                        </Link>
                        <button
                            onClick={() => router.push('/')}
                            className="w-full py-3 text-zinc-500 font-bold hover:text-white"
                        >
                            Annulla Missione
                        </button>
                    </div>
                </div>
            </div>
        );
    }

    if (lives <= 0 && !showShopModal) {
        return (
            <SystemFailureModal
                onRefill={() => {
                    // Demo: Refill lives immediately
                    refillLives();
                    alert("RICARICA EMERGENZA RIUSCITA! -0.99€ (Demo)");
                }}
                onPremium={() => {
                    // Demo: Activate premium
                    setInfiniteLives(true);
                    alert("POTERE ILLIMITATO ACQUISITO! -4.99€ (Demo)");
                }}
            />
        );
    }

    const currentQuestion = quiz.questions[currentQuestionIndex];
    const isLastQuestion = currentQuestionIndex === quiz.questions.length - 1;

    // Safety check: if no questions or invalid index, show error
    if (!currentQuestion) {
        return (
            <div className="p-8 text-center space-y-4">
                <AlertTriangle className="w-16 h-16 text-cyber-red mx-auto" />
                <h2 className="text-xl font-bold text-cyber-red">Errore Sistema</h2>
                <p className="text-cyber-gray">Nessuna domanda disponibile per questo livello.</p>
                <Link
                    href="/dashboard"
                    className="inline-block px-6 py-3 bg-cyber-blue text-cyber-dark rounded-xl font-bold hover:bg-cyber-green transition-colors"
                >
                    Torna alla Dashboard
                </Link>
            </div>
        );
    }

    if (showPerfectScoreModal) {
        return (
            <PerfectScoreModal
                score={score + (isCorrect ? 1 : 0)}
                totalQuestions={quiz.questions.length}
                onRetry={() => {
                    // Reload the page is the simplest way to retry for now
                    window.location.reload();
                }}
                onExit={() => {
                    router.push('/dashboard');
                }}
            />
        );
    }

    const handleAnswer = async (optionIndex: number) => {
        if (selectedOption !== null) return; // Prevent multiple clicks
        setSelectedOption(optionIndex);

        const currentQ = quiz.questions[currentQuestionIndex];
        const isCorrectAnswer = optionIndex === currentQ.correctAnswer;

        setIsCorrect(isCorrectAnswer);
        setIsAnswered(true);

        if (isCorrectAnswer) {
            setScore(score + 1);
        } else {
            decrementLives();

            // Sync with backend if logged in
            const { data: { user } } = await supabase.auth.getUser();
            if (user) {
                const { error } = await supabase.rpc('decrement_hearts');
                if (error) console.error('❌ Error decrementing hearts:', JSON.stringify(error, null, 2));
            }

            if (lives <= 1) {
                posthog.capture('quiz_failed', {
                    quiz_id: id,
                    question_index: currentQuestionIndex
                });
                setShowShopModal(true);
            }
        }
    };

    const handleNext = async () => {
        if (isLastQuestion) {
            // Recalculate final score including current question
            // Logic explanation: score state is updated in handleAnswer.
            // Since we are in the same render cycle as the button click, and handleAnswer might have caused a re-render...
            // Actually, handleAnswer calls setScore. React batches updates.
            // If user clicked Answer, re-render happened with new score.
            // Then user clicks Next.
            // So 'score' variable here SHOULD be up to date.

            const totalQuestions = quiz.questions.length;
            const finalScore = score; // Trusting state

            // Check for perfect score (100%)
            if (finalScore === totalQuestions) {

                // Calculate percentage
                const finalPercentage = Math.round((finalScore / totalQuestions) * 100);
                setPercentage(finalPercentage);

                incrementStreak();
                setShowReward(true);

                // Call the complete_level via Store (Handles Emeralds/Rubies logic)
                try {
                    const { data: { user } } = await supabase.auth.getUser();

                    const completeLevel = useUserStore.getState().completeLevel;
                    const checkBadges = useUserStore.getState().checkBadges;

                    if (user) {
                        // -- DUEL MODE LOGIC --
                        if (mode === 'duel' && challengeId) {
                            submitDuelScore(challengeId, user.id, finalScore)
                                .then(() => { })
                                .catch(err => console.error('❌ Error submitting duel score:', err));

                            posthog.capture('duel_completed', {
                                challenge_id: challengeId,
                                score: finalScore,
                                won: finalScore > (totalQuestions / 2),
                                quiz_id: id,
                                user_id: user.id
                            });
                        }

                        // Track Quiz Completion
                        posthog.capture('quiz_completed', {
                            quiz_id: id,
                            score: finalScore,
                            perfect_score: true,
                            mode: mode || 'solo'
                        });

                        // 1. Complete Level (Store Action)
                        // This handles: DB RPC, Emerald/Ruby increment, Profile Refresh
                        const success = await completeLevel(id as string, finalScore);

                        if (!success) {
                            console.error('❌ Error completing level via store.');
                            // Fallback: Insert directly into user_progress
                            await supabase.from('user_progress').upsert({
                                user_id: user.id,
                                quiz_id: id as string,
                                score: finalScore,
                                status: 'completed',
                                completed_at: new Date().toISOString()
                            }, { onConflict: 'user_id, quiz_id' });
                        } else {


                            // 2. Check for new badges
                            const { newBadges } = await checkBadges(true);
                            if (newBadges && newBadges.length > 0) {

                                setNewBadgeId(newBadges[0]);
                            }
                        }
                    }

                    // No need to manually refresh profile here, store action does it.


                } catch (error) {
                    console.error('❌ Unexpected error completing level:', error);
                }
            } else {
                // ** IMPERFECT SCORE LOGIC **
                setShowPerfectScoreModal(true);
            }
        } else {
            setCurrentQuestionIndex(prev => prev + 1);
            setSelectedOption(null);
            setIsAnswered(false);
            setIsCorrect(false);
        }
    };

    const [percentage, setPercentage] = useState(0);

    const handleAnswerAndScore = (optionIndex: number) => {
        handleAnswer(optionIndex);
    };

    if (showReward) {
        return (
            <div className="flex flex-col items-center justify-center h-[60vh] space-y-6 text-center animate-in fade-in zoom-in duration-300">
                <div className="w-24 h-24 bg-cyber-purple/20 rounded-full flex items-center justify-center shadow-[0_0_30px_rgba(176,38,255,0.5)] border border-cyber-purple">
                    <span className="text-4xl animate-bounce">🏆</span>
                </div>
                <div className="space-y-2">
                    <h2 className="text-3xl font-bold text-cyber-purple font-orbitron text-glow">Missione Compiuta</h2>
                    <p className="text-xl font-medium text-cyber-blue">
                        Accuratezza: <span className={percentage === 100 ? "text-green-400" : "text-yellow-400"}>{percentage}%</span>
                    </p>

                    {newBadgeId && (
                        <div className="mt-4 p-3 bg-yellow-500/20 border border-yellow-500/50 rounded-xl animate-pulse">
                            <p className="text-yellow-400 font-bold">NUOVO BADGE SBLOCCATO!</p>
                        </div>
                    )}
                </div>
                <button
                    onClick={() => {
                        // Force Hard Refresh to ensure Dashboard gets fresh data
                        // Pass newBadgeId param if present
                        const redirectUrl = newBadgeId
                            ? `/dashboard?newBadge=${newBadgeId}`
                            : '/dashboard';
                        window.location.href = redirectUrl;
                    }}
                    className="px-8 py-3 bg-cyber-blue text-cyber-dark rounded-full font-bold text-lg shadow-[0_0_15px_rgba(69,162,158,0.5)] hover:bg-cyber-green transition-all hover:scale-105"
                >
                    Ritorna alla Base
                </button>
            </div>
        );
    }

    return (
        <div className="space-y-6 relative min-h-screen pb-80"> {/* Increased padding for larger Action Panel */}
            {/* HUD Header */}
            {/* HUD Header */}
            <div className="flex items-center justify-between gap-4 glass-panel p-4 rounded-2xl border border-white/10 shadow-lg relative overflow-hidden z-10">
                <Link href="/" className="p-3 hover:bg-white/10 rounded-xl transition-all border border-transparent hover:border-white/20 group shrink-0">
                    <ArrowLeft className="w-5 h-5 text-cyber-blue group-hover:text-white transition-colors" />
                </Link>

                <div className="flex-1 flex flex-col gap-2">
                    <div className="flex justify-between items-end px-1">
                        <span className="text-[10px] font-bold tracking-widest text-cyber-gray uppercase">Sincronizzazione Sistema</span>
                        <span className="text-sm font-bold font-orbitron text-cyber-blue text-glow">
                            {currentQuestionIndex + 1} <span className="text-cyber-gray text-xs">/ {quiz.questions.length}</span>
                        </span>
                    </div>

                    {/* Progress Bar Container */}
                    <div className="h-3 bg-black/50 rounded-full overflow-hidden border border-white/10 relative">
                        {/* Background pattern */}
                        <div className="absolute inset-0 opacity-20 bg-[repeating-linear-gradient(45deg,transparent,transparent_5px,#000_5px,#000_10px)]" />

                        {/* Fill */}
                        <motion.div
                            className="absolute top-0 left-0 h-full bg-gradient-to-r from-cyber-blue to-cyber-purple shadow-[0_0_15px_rgba(69,162,158,0.6)]"
                            initial={{ width: 0 }}
                            animate={{ width: `${((currentQuestionIndex + 1) / quiz.questions.length) * 100}%` }}
                            transition={{ duration: 0.5, ease: "circOut" }}
                        >
                            {/* Leading Edge Shine */}
                            <div className="absolute right-0 top-0 bottom-0 w-[2px] bg-white/80 shadow-[0_0_10px_white]" />
                        </motion.div>
                    </div>
                </div>
            </div>

            {/* Question Card */}
            <AnimatePresence mode='wait'>
                <motion.div
                    key={currentQuestionIndex}
                    initial={{ opacity: 0, x: 20 }}
                    animate={{ opacity: 1, x: 0 }}
                    exit={{ opacity: 0, x: -20 }}
                    className="space-y-6"
                >
                    <h2 className="text-xl font-bold leading-snug font-orbitron text-white drop-shadow-md">
                        {currentQuestion.text}
                    </h2>

                    {currentQuestion.type === 'image_verification' ? (
                        <div className="relative overflow-hidden rounded-xl border border-cyber-blue/30 group">
                            {/* Scanning Animation Overlay */}
                            <div className="absolute inset-0 pointer-events-none z-20 animate-scan bg-gradient-to-b from-transparent via-cyber-blue/20 to-transparent h-[20%]" />

                            <VisualQuizCard
                                imageUrl={currentQuestion.imageUrl || ''}
                                correctAnswer={currentQuestion.correctAnswer}
                                hotspots={currentQuestion.hotspots}
                                onAnswer={handleAnswer}
                                disabled={isAnswered}
                            />
                        </div>
                    ) : (
                        <div className="space-y-3">
                            {currentQuestion.options.map((option, index) => {
                                let stateStyles = "border-cyber-gray/50 bg-cyber-dark/40 hover:border-cyber-blue/50 hover:bg-cyber-blue/10";
                                let icon = null;

                                if (isAnswered) {
                                    if (index === currentQuestion.correctAnswer) {
                                        stateStyles = "border-cyber-green bg-cyber-green/20 text-cyber-green shadow-[0_0_15px_rgba(102,252,241,0.2)]";
                                        icon = <Check className="w-5 h-5" />;
                                    } else if (index === selectedOption) {
                                        stateStyles = "border-cyber-red bg-cyber-red/20 text-cyber-red animate-glitch";
                                        icon = <X className="w-5 h-5" />;
                                    } else {
                                        stateStyles = "opacity-30 grayscale border-transparent";
                                    }
                                }

                                return (
                                    <button
                                        key={index}
                                        onClick={() => handleAnswer(index)}
                                        disabled={isAnswered}
                                        className={cn(
                                            "w-full p-4 text-left rounded-xl border-2 transition-all duration-200 flex items-center justify-between group glass-card relative overflow-hidden",
                                            stateStyles
                                        )}
                                    >
                                        <span className="font-medium relative z-10">{option}</span>
                                        {icon}
                                        {/* Hover Effect for Unanswered */}
                                        {!isAnswered && (
                                            <div className="absolute inset-0 bg-cyber-blue/5 opacity-0 group-hover:opacity-100 transition-opacity" />
                                        )}
                                    </button>
                                );
                            })}
                        </div>
                    )}
                </motion.div>
            </AnimatePresence>

            {/* Action Panel */}
            <AnimatePresence>
                {isAnswered && (
                    <QuizActionPanel
                        isCorrect={isCorrect}
                        correctAnswerText={currentQuestion.options[currentQuestion.correctAnswer]}
                        explanation={currentQuestion.explanation}
                        onNext={handleNext}
                        isLastQuestion={isLastQuestion}
                    />
                )}
            </AnimatePresence>
        </div>
    );
}
