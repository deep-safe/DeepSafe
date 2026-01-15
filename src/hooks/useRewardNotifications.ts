import { useState, useEffect } from 'react';
import { supabase } from '@/lib/supabase/client';

export interface RewardNotification {
    id: string;
    type: string;
    title: string;
    message: string;
    data: {
        amount: number;
        period: string;
        awarded_at: string;
    };
    created_at: string;
}

export function useRewardNotifications() {
    const [notification, setNotification] = useState<RewardNotification | null>(null);
    const [loading, setLoading] = useState(true);

    const checkNotifications = async () => {
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                setLoading(false);
                return;
            }

            // Fetch oldest unread reward notification
            // We prioritize showing them one by one if they stacked up
            const { data, error } = await supabase
                .from('user_notifications' as any)
                .select('*')
                .eq('user_id', user.id)
                .eq('read', false)
                .in('type', ['weekly_reward', 'monthly_reward'])
                .order('created_at', { ascending: true })
                .limit(1)
                .single();

            if (error && error.code !== 'PGRST116') { // PGRST116 is 'Row not found' which is fine
                console.error('Error checking notifications:', error);
            }

            if (data) {
                setNotification(data as unknown as RewardNotification);
            }
        } catch (err) {
            console.error('Unexpected error checking notifications:', err);
        } finally {
            setLoading(false);
        }
    };

    const markAsRead = async (notificationId: string) => {
        try {
            const { error } = await supabase
                .from('user_notifications' as any)
                .update({ read: true } as any)
                .eq('id', notificationId);

            if (error) throw error;

            setNotification(null);

            // Check if there are more (optional, or just wait for next reload)
            // checkNotifications(); 
        } catch (err) {
            console.error('Error marking notification as read:', err);
        }
    };

    useEffect(() => {
        checkNotifications();
    }, []);

    return {
        notification,
        loading,
        markAsRead,
        checkNotifications // Expose to manually trigger check
    };
}
