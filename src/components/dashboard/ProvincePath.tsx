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
}

const ProvincePath: React.FC<ProvincePathProps> = ({
    province,
    onProvinceClick,
    onProvinceHover,
    isRegionMode,
    isRegionHovered,
    isProvinceHighlighted
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
        if (isProvinceHighlighted) return isMastered ? 'rgba(251, 191, 36, 0.4)' : 'rgba(6, 182, 212, 0.3)'; // Gold or Cyan highlight
        if (isRegionHovered) return isMastered ? 'rgba(251, 191, 36, 0.3)' : 'rgba(6, 182, 212, 0.2)'; // Region highlight
        if (isRegionMode) return 'rgba(30, 41, 59, 0.8)'; // Dim others in region mode

        // Default State Colors
        if (isMastered) return 'rgba(251, 191, 36, 0.2)'; // Gold
        if (isPassed) return 'rgba(6, 182, 212, 0.2)'; // Cyan
        if (isUnlocked) return 'rgba(59, 130, 246, 0.15)'; // Blue/Slate for unlocked but not passed

        return 'rgba(0, 0, 0, 0.95)'; // Locked - Pitch Black / Void
    };

    const getStrokeColor = () => {
        if (isProvinceHighlighted) return isMastered ? '#fbbf24' : '#22d3ee';
        if (isRegionHovered) return isMastered ? '#f59e0b' : '#06b6d4';

        if (isMastered) return '#fbbf24'; // Amber-400
        if (isPassed) return '#22d3ee'; // Cyan-400
        if (isUnlocked) return '#3b82f6'; // Blue-500

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
        if (isPassed && isProvinceHighlighted) return 'drop-shadow(0 0 2px #22d3ee)';
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
                    // Remove old fill classes as we use inline styles for dynamic control
                )}
                animate={isUnlocked ? {
                    fillOpacity: isMastered ? [0.2, 0.4, 0.2] : [0.2, 0.3, 0.2],
                    strokeOpacity: [0.6, 1, 0.6],
                } : {}}
                transition={isUnlocked ? pulseTransition : {}}
            />
        </motion.g>
    );
};

export default ProvincePath;
