// XP Logic Removed - Replaced with Badge Counters
export const XP_PER_QUIZ = 0;
export const XP_BONUS_PER_STREAK = 0;

// Legacy support (to be removed once fully refactored)
export function calculateXp(baseXp: number, streak: number): number {
    return 0;
}

export function calculateRewards(quiz: any, baseStreak: number) {
    return {
        xp: 0,
        badgeId: quiz.badge_reward_id || null
    };
}
