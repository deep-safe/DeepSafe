export interface BadgeDefinition {
    id: string;
    name: string;
    description: string;
    icon: string;
    category: 'Region' | 'Streak' | 'Special';
    rarity: 'common' | 'rare' | 'legendary';
    condition: {
        type: 'streak_milestone' | 'first_mission';
        value?: string | number;
    };
}

export const BADGES_DATA: BadgeDefinition[] = [
    // --- Special Badges ---
    {
        id: 'first_blood',
        name: 'Primo Sangue',
        description: 'Completa la tua prima missione.',
        icon: '🩸',
        category: 'Special',
        rarity: 'common',
        condition: { type: 'first_mission' }
    },

    // --- Streak Badges ---
    {
        id: 'streak_3',
        name: 'Fuoco di Paglia',
        description: 'Raggiungi una serie di 3 giorni.',
        icon: '🔥',
        category: 'Streak',
        rarity: 'common',
        condition: { type: 'streak_milestone', value: 3 }
    },
    {
        id: 'streak_7',
        name: 'Settimana di Fuoco',
        description: 'Raggiungi una serie di 7 giorni.',
        icon: '🧨',
        category: 'Streak',
        rarity: 'rare',
        condition: { type: 'streak_milestone', value: 7 }
    },
    {
        id: 'streak_30',
        name: 'Leggenda Immortale',
        description: 'Raggiungi una serie di 30 giorni.',
        icon: '👑',
        category: 'Streak',
        rarity: 'legendary',
        condition: { type: 'streak_milestone', value: 30 }
    }
];
