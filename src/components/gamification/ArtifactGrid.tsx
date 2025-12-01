import React from 'react';
import { Trophy } from 'lucide-react';
import { BadgeCard, Badge } from '@/components/gamification/BadgeCard';

interface ArtifactGridProps {
    badges: Badge[];
    onSelectBadge: (badge: Badge) => void;
}

export function ArtifactGrid({ badges, onSelectBadge }: ArtifactGridProps) {
    return (
        <section className="space-y-4">
            <div className="flex items-center gap-2 text-cyber-purple mb-2">
                <Trophy className="w-5 h-5" />
                <h2 className="font-bold font-orbitron tracking-wide text-sm">COLLEZIONE BADGE</h2>
            </div>

            {/* Standard Grid Layout - Cyberpunk Inventory */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mx-auto pb-12 w-full">
                {badges.map((badge) => (
                    <div key={badge.id} className="w-full">
                        <BadgeCard badge={badge} onClick={onSelectBadge} />
                    </div>
                ))}
            </div>
        </section>
    );
}
