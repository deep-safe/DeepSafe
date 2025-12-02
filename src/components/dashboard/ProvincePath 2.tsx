import React from 'react';
import { motion } from 'framer-motion';
import { Province } from '@/data/provincesData';
import { cn } from '@/lib/utils';

interface ProvincePathProps {
    province: Province;
    onProvinceClick: (province: Province) => void;
    onProvinceHover?: (province: Province | null) => void;
    isRegionMode: boolean;
    isRegionHovered: boolean;
    isProvinceHighlighted: boolean;
    mapTier: 'level_1' | 'level_2' | 'level_3';
}

const ProvincePath: React.FC<ProvincePathProps> = ({
    province,
    onProvinceClick,
    onProvinceHover,
    isRegionMode,
    isRegionHovered,
    isProvinceHighlighted,
    mapTier
}) => {
    const { status, path, userScore = 0, maxScore = 10 } = province;

    // Mastery Logic
    const percentage = maxScore > 0 ? (userScore / maxScore) * 100 : 0;
    const isMastered = percentage === 100;
    const isPassed = percentage >= 60;

    const isLocked = status === 'locked';
    const isUnlocked = status === 'unlocked';
    const isSafe = status === 'safe';

    // In Region Mode (Level 2), we use standard individual highlighting
    // In Italy Mode (Level 1), we highlight if the Region is hovered
    const shouldHighlight = isRegionMode ? false : isRegionHovered;

    // Animation variants
    const variants = {
        initial: { opacity: 0, scale: 0.9 },
        animate: { opacity: 1, scale: 1, transition: { duration: 0.5 } },
        hover: {
            scale: isRegionMode ? 1.02 : 1, // Only scale individually in Region Mode
            filter: isLocked ? 'brightness(0.8)' : 'brightness(1.2)',
            transition: { duration: 0.2 }
        },
        tap: { scale: 0.98 }
    };

    // Pulsing animation for unlocked/active provinces
    const pulseTransition = {
        duration: 2,
        repeat: Infinity,
        ease: "easeInOut" as const
    };

    const getFillColor = () => {
        // Base Colors based on Tier
        const colors = {
            level_1: { highlight: 'rgba(6, 182, 212, 0.3)', region: 'rgba(6, 182, 212, 0.2)', mastered: 'rgba(16, 185, 129, 0.3)', passed: 'rgba(6, 182, 212, 0.2)', unlocked: 'rgba(59, 130, 246, 0.15)' },
            level_2: { highlight: 'rgba(249, 115, 22, 0.4)', region: 'rgba(249, 115, 22, 0.3)', mastered: 'rgba(245, 158, 11, 0.3)', passed: 'rgba(249, 115, 22, 0.2)', unlocked: 'rgba(234, 88, 12, 0.15)' },
            level_3: { highlight: 'rgba(234, 179, 8, 0.4)', region: 'rgba(234, 179, 8, 0.3)', mastered: 'rgba(250, 204, 21, 0.3)', passed: 'rgba(234, 179, 8, 0.2)', unlocked: 'rgba(202, 138, 4, 0.15)' }
        };

        // Fallback to level_1 if mapTier is invalid (e.g. cached 'green')
        const theme = colors[mapTier] || colors['level_1'];

        if (isProvinceHighlighted) return isMastered ? theme.mastered : theme.highlight;
        if (isRegionHovered) return isMastered ? theme.mastered : theme.region;
        if (isRegionMode) return 'rgba(30, 41, 59, 0.8)'; // Dim others in region mode

        // Default State Colors
        if (isMastered) return theme.mastered;
        if (isPassed) return theme.passed;
        if (isUnlocked) return theme.unlocked;

        return 'rgba(0, 0, 0, 0.95)'; // Locked - Pitch Black / Void
    };

    const getStrokeColor = () => {
        const colors = {
            level_1: { highlight: '#22d3ee', region: '#06b6d4', mastered: '#10b981', passed: '#22d3ee', unlocked: '#3b82f6' },
            level_2: { highlight: '#f97316', region: '#ea580c', mastered: '#f59e0b', passed: '#f97316', unlocked: '#ea580c' },
            level_3: { highlight: '#eab308', region: '#ca8a04', mastered: '#facc15', passed: '#eab308', unlocked: '#ca8a04' }
        };

        // Fallback to level_1 if mapTier is invalid
        const theme = colors[mapTier] || colors['level_1'];

        if (isProvinceHighlighted) return isMastered ? theme.mastered : theme.highlight;
        if (isRegionHovered) return isMastered ? theme.mastered : theme.region;

        if (isMastered) return theme.mastered;
        if (isPassed) return theme.passed;
        if (isUnlocked) return theme.unlocked;

        return '#334155'; // Slate-700
    };

    const getStrokeWidth = () => {
        if (isProvinceHighlighted) return 2;
        if (isRegionHovered) return 1.5;
        if (isMastered) return 1.5; // Emphasize mastered
        return 0.5;
    };

    // Dynamic Filter for Neon Glow
    const getFilter = () => {
        if (isMastered) return 'url(#glow)';
        const glowColors = {
            level_1: '#22d3ee',
            level_2: '#f97316',
            level_3: '#eab308'
        };
        // Fallback to level_1 color if invalid
        const glowColor = glowColors[mapTier] || glowColors['level_1'];

        if (isPassed && isProvinceHighlighted) return `drop-shadow(0 0 2px ${glowColor})`;
        return undefined;
    };

    return (
        <motion.g
            initial="initial"
            animate="animate"
            whileHover="hover"
            whileTap="tap"
            onClick={(e) => {
                e.stopPropagation();
                onProvinceClick(province);
            }}
            onMouseEnter={() => onProvinceHover && onProvinceHover(province)}
            onMouseLeave={() => onProvinceHover && onProvinceHover(null)}
            className="cursor-pointer"
        >
            <motion.path
                d={path}
                fill={getFillColor()}
                stroke={getStrokeColor()}
                strokeWidth={getStrokeWidth()}
                style={{ filter: getFilter() }}
                className={cn(
                    "transition-all duration-300",
                    isLocked && "fill-slate-900/80",
                    isUnlocked && !isMastered && "animate-map-pulse",
                    isUnlocked && isMastered && "animate-map-pulse-mastered"
                )}
            />
        </motion.g>
    );
};

export default ProvincePath;
