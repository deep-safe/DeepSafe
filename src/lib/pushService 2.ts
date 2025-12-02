import webpush from 'web-push';

const publicVapidKey = process.env.NEXT_PUBLIC_VAPID_PUBLIC_KEY!;
const privateVapidKey = process.env.VAPID_PRIVATE_KEY!;

if (!publicVapidKey || !privateVapidKey) {
    console.warn('VAPID keys are missing. Push notifications will not work.');
} else {
    webpush.setVapidDetails(
        'mailto:support@deepsafe.app', // Replace with real email
        publicVapidKey,
        privateVapidKey
    );
}

export interface PushPayload {
    title: string;
    body: string;
    url?: string;
}

export async function sendNotification(subscription: any, payload: PushPayload) {
    try {
        await webpush.sendNotification(subscription, JSON.stringify(payload));
        return true;
    } catch (error) {
        console.error('Error sending push notification:', error);
        return false;
    }
}
