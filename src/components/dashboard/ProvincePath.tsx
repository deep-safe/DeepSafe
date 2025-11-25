import React from 'react';
import { motion } from 'framer-motion';
import { Province, ProvinceStatus } from '@/data/provincesData';
import { cn } from '@/lib/utils';

interface ProvincePathProps {
    province: Province;
    onProvinceClick: (province: Province) => void;
}

const ProvincePath: React.FC<ProvincePathProps> = ({ province, onProvinceClick }) => {
    const { id, status, path } = province;

    const isLocked = status === 'locked';
    const isUnlocked = status === 'unlocked';
    const isSafe = status === 'safe';

    // Animation variants
    const variants = {
        initial: { opacity: 0, scale: 0.9 },
        animate: { opacity: 1, scale: 1, transition: { duration: 0.5 } },
        hover: {
            scale: 1.02,
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
            onClick={() => onProvinceClick(province)}
            className="cursor-pointer"
        >
            <motion.path
                d={path}
                className={cn(
                    "stroke-1 transition-colors duration-300",
                    isLocked && "fill-slate-900/80 stroke-slate-700 hover:fill-slate-800",
                    isUnlocked && "fill-cyan-900/40 stroke-cyan-400 stroke-2",
                    isSafe && "fill-amber-700/60 stroke-amber-500"
                )}
                animate={isUnlocked ? {
                    fillOpacity: [0.3, 0.6, 0.3],
                    strokeOpacity: [0.5, 1, 0.5],
                } : {}}
                transition={isUnlocked ? pulseTransition : {}}
            />

            {/* Label (Optional - simplified for now) */}
            {/* You might want to calculate centroid for text placement in a real app */}
        </motion.g>
    );
};

export default ProvincePath;
