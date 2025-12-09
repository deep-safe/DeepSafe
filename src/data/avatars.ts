export interface Avatar {
    id: string;
    name: string;
    description: string;
    src: string;
    rarity: 'common' | 'rare' | 'epic' | 'legendary';
    isDefault?: boolean;
}

const basePath = process.env.NEXT_PUBLIC_BASE_PATH || '';

export const AVATARS: Avatar[] = [
    {
        id: 'avatar_rookie',
        name: 'Agente Recluta',
        description: 'Identità base assegnata ai nuovi operativi.',
        src: `${basePath}/avatars/rookie.png`,
        rarity: 'common',
        isDefault: true
    },
    {
        id: 'avatar_ninja',
        name: 'Cyber Ninja',
        description: 'Operativo specializzato in infiltrazioni silenziose.',
        src: `${basePath}/avatars/ninja.png`,
        rarity: 'rare'
    },
    {
        id: 'avatar_hacker',
        name: 'Elite Hacker',
        description: 'Maestro del codice e della manipolazione dati.',
        src: `${basePath}/avatars/hacker.png`,
        rarity: 'epic'
    },
    {
        id: 'avatar_architect',
        name: 'Architetto',
        description: 'Entità di alto livello con accesso root al sistema.',
        src: `${basePath}/avatars/architect.png`,
        rarity: 'legendary'
    }
];

export const getAvatarById = (id: string | null): Avatar => {
    return AVATARS.find(a => a.id === id) || AVATARS[0];
};
