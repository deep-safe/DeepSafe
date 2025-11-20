export const XP_PER_QUIZ = 10;
export const XP_BONUS_PER_STREAK = 5;

export function calculateXp(baseXp: number, streak: number): number {
    // Simple multiplier: 10% bonus for every 5 days of streak, capped at 50%
    const multiplier = 1 + Math.min(0.5, Math.floor(streak / 5) * 0.1);
    return Math.floor(baseXp * multiplier);
}

export function checkStreak(lastLoginDate: Date, currentStreak: number): number {
    const now = new Date();
    const diffTime = Math.abs(now.getTime() - lastLoginDate.getTime());
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 1) {
        return currentStreak + 1;
    } else if (diffDays > 1) {
        return 0; // Streak broken
    }

    return currentStreak; // Same day, no change
}
