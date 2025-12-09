
import { useEffect } from 'react';
import { useUserStore } from '@/store/useUserStore';

export const useHeartRefill = () => {
    const checkRefill = useUserStore(state => state.checkRefill);

    useEffect(() => {
        // Run immediately on mount
        checkRefill();

        // Run every 60 seconds (conservative check)
        // The store logic handles the precise math, so calling it often is cheap.
        const intervalId = setInterval(() => {
            checkRefill();
        }, 60 * 1000);

        return () => clearInterval(intervalId);
    }, [checkRefill]);
};
