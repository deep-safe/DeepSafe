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
}

const ProvincePath: React.FC<ProvincePathProps> = ({
    province,
    onProvinceClick,
    onProvinceHover,
    isRegionMode,
    isRegionHovered
}) => {
    const { status, path } = province;

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
                className={cn(
                    "stroke-1 transition-all duration-300",
                    // Base Styles
                    isLocked && "fill-slate-900/80 stroke-slate-700",
                    isUnlocked && "fill-cyan-900/40 stroke-cyan-400 stroke-2",
                    isSafe && "fill-amber-700/60 stroke-amber-500",

                    // Region Highlight (Level 1)
                    !isRegionMode && isRegionHovered && "fill-cyan-500/20 stroke-cyan-300 stroke-[2px] brightness-125",

                    // Region Mode Hover (Level 2) handled by whileHover/CSS
                    isRegionMode && "hover:fill-cyan-500/30"
                )}
                animate={isUnlocked ? {
                    fillOpacity: [0.3, 0.6, 0.3],
                    strokeOpacity: [0.5, 1, 0.5],
                } : {}}
                transition={isUnlocked ? pulseTransition : {}}
            />
        </motion.g>
    );
};

export default ProvincePath;
