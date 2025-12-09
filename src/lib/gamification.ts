// XP Logic Removed - Replaced with Badge Counters

export function calculateRewards(quiz: any, baseStreak: number) {
    return {
        badgeId: quiz.badge_reward_id || null
    };
}
