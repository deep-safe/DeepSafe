export interface Avatar {
    id: string;
    name: string;
    description: string;
    src: string;
    rarity: 'common' | 'rare' | 'epic' | 'legendary';
    isDefault?: boolean;
}

export const AVATARS: Avatar[] = [
    {
        id: 'avatar_rookie',
        name: 'Agente Recluta',
        description: 'Identità base assegnata ai nuovi operativi.',
        src: '/avatars/rookie.png',
        rarity: 'common',
        isDefault: true
    },
    {
        id: 'avatar_ninja',
        name: 'Cyber Ninja',
        description: 'Operativo specializzato in infiltrazioni silenziose.',
        src: '/avatars/ninja.png',
        rarity: 'rare'
    },
    {
        id: 'avatar_hacker',
        name: 'Elite Hacker',
        description: 'Maestro del codice e della manipolazione dati.',
        src: '/avatars/hacker.png',
        rarity: 'epic'
    },
    {
        id: 'avatar_architect',
        name: 'Architetto',
        description: 'Entità di alto livello con accesso root al sistema.',
        src: '/avatars/architect.png',
        rarity: 'legendary'
    }
];

export const getAvatarById = (id: string | null): Avatar => {
    return AVATARS.find(a => a.id === id) || AVATARS[0];
};
