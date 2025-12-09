import { create } from 'zustand';
import { persist } from 'zustand/middleware';

type ConsentStatus = 'accepted' | 'rejected' | 'undecided';

interface ConsentState {
    consent: ConsentStatus;
    setConsent: (status: ConsentStatus) => void;
    hasHydrated: boolean;
    setHasHydrated: (state: boolean) => void;
}

export const useConsentStore = create<ConsentState>()(
    persist(
        (set) => ({
            consent: 'undecided',
            setConsent: (status) => set({ consent: status }),
            hasHydrated: false,
            setHasHydrated: (state) => set({ hasHydrated: state }),
        }),
        {
            name: 'cookie-consent-storage',
            onRehydrateStorage: () => (state) => {
                state?.setHasHydrated(true);
            },
        }
    )
);
