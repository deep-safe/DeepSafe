'use client'

import posthog from 'posthog-js'
import { PostHogProvider as PHProvider } from 'posthog-js/react'
import { useEffect } from 'react'

export function PostHogProvider({ children }: { children: React.ReactNode }) {
    // PostHog initialization commented out - uncomment and add NEXT_PUBLIC_POSTHOG_KEY to .env.local to enable analytics
    useEffect(() => {
        posthog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY || '', {
            api_host: process.env.NEXT_PUBLIC_POSTHOG_HOST || 'https://us.i.posthog.com',
            person_profiles: 'always', // or 'always' to create profiles for anonymous users as well
            capture_pageview: false, // Disable automatic pageview capture, as we capture manually
        })
    }, [])

    return <PHProvider client={posthog}>{children}</PHProvider>
}
