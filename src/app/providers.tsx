'use client'

import posthog from 'posthog-js'
import { PostHogProvider as PHProvider } from 'posthog-js/react'
import { useEffect } from 'react'
import { useConsentStore } from '@/store/useConsentStore'

export function PostHogProvider({ children }: { children: React.ReactNode }) {
    const { consent } = useConsentStore()

    useEffect(() => {
        if (consent === 'accepted') {
            posthog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY || '', {
                api_host: process.env.NEXT_PUBLIC_POSTHOG_HOST || 'https://us.i.posthog.com',
                person_profiles: 'always',
                capture_pageview: false,
                persistence: 'localStorage',
            })
        } else if (consent === 'rejected') {
            // Ensure we stop capturing if user rejects later
            if (posthog.has_opted_in_capturing()) {
                posthog.opt_out_capturing()
            }
        }
    }, [consent])

    return <PHProvider client={posthog}>{children}</PHProvider>
}
