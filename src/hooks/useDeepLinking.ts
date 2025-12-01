import { useEffect } from 'react';
import { App, URLOpenListenerEvent } from '@capacitor/app';
import { useRouter } from 'next/navigation';

export const useDeepLinking = () => {
    const router = useRouter();

    useEffect(() => {
        const handleUrlOpen = (event: URLOpenListenerEvent) => {
            const url = new URL(event.url);

            // Handle Custom Scheme (deepsafe://)
            if (url.protocol === 'deepsafe:') {
                // Remove the protocol and treat the rest as a path
                // e.g. deepsafe://quiz?id=1 -> /quiz?id=1
                // e.g. deepsafe://dashboard -> /dashboard
                const path = url.pathname + url.search;
                // If pathname is empty (e.g. deepsafe://?id=1), use /
                const targetPath = path || '/';

                // Navigate to the path
                // We use replace to avoid building up history stack with deep link entries
                router.replace(targetPath);
            }

            // Handle Universal Links (https://deepsafe.app)
            // Capacitor automatically handles the domain verification part if configured,
            // but we need to route the path internally.
            if (url.protocol === 'https:' && url.hostname === 'deepsafe.app') {
                const path = url.pathname + url.search;
                router.replace(path);
            }
        };

        App.addListener('appUrlOpen', handleUrlOpen);

        return () => {
            App.removeAllListeners();
        };
    }, [router]);
};
