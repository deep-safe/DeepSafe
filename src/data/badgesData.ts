export interface BadgeDefinition {
    id: string;
    name: string;
    description: string;
    icon: string;
    category: 'Region' | 'Streak' | 'XP' | 'Special';
    xpReward: number; // NC Reward
    rarity: 'common' | 'rare' | 'legendary';
    condition: {
        type: 'region_master' | 'streak_milestone' | 'xp_milestone' | 'first_mission' | 'single_province_master';
        value?: string | number; // Region name or numeric threshold
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
        xpReward: 50,
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
        xpReward: 100,
        rarity: 'common',
        condition: { type: 'streak_milestone', value: 3 }
    },
    {
        id: 'streak_7',
        name: 'Settimana di Fuoco',
        description: 'Raggiungi una serie di 7 giorni.',
        icon: '🧨',
        category: 'Streak',
        xpReward: 250,
        rarity: 'rare',
        condition: { type: 'streak_milestone', value: 7 }
    },
    {
        id: 'streak_30',
        name: 'Leggenda Immortale',
        description: 'Raggiungi una serie di 30 giorni.',
        icon: '👑',
        category: 'Streak',
        xpReward: 1000,
        rarity: 'legendary',
        condition: { type: 'streak_milestone', value: 30 }
    },

    // --- XP Badges ---
    {
        id: 'xp_1000',
        name: 'White Hat',
        description: 'Guadagna 1.000 NC totali.',
        icon: '🎩',
        category: 'XP', // Keep category ID for now, but UI shows NC
        xpReward: 200,
        rarity: 'common',
        condition: { type: 'xp_milestone', value: 1000 }
    },
    {
        id: 'xp_5000',
        name: 'Cyber Sentinel',
        description: 'Guadagna 5.000 NC totali.',
        icon: '🛡️',
        category: 'XP',
        xpReward: 500,
        rarity: 'rare',
        condition: { type: 'xp_milestone', value: 5000 }
    },

    // --- Region Badges ---
    {
        id: 'master_region_generic',
        name: 'Conquistatore Regionale',
        description: 'Completa tutte le province di una regione.',
        icon: '🗺️',
        category: 'Region',
        xpReward: 500, // Increased reward since it's a major milestone
        rarity: 'legendary',
        condition: { type: 'region_master' }
    }
];
