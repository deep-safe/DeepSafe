import { NextRequest, NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase/admin';

export async function DELETE(req: NextRequest) {
    const { searchParams } = new URL(req.url);
    const userId = searchParams.get('userId');

    if (!userId) {
        return NextResponse.json({ error: 'User ID is required' }, { status: 400 });
    }

    try {
        console.log(`[Admin] Deleting user: ${userId}`);

        // 1. Delete from auth.users (this should cascade to public.profiles if set up correctly, 
        // usually it does via foreign key on delete cascade)
        const { data, error } = await supabaseAdmin.auth.admin.deleteUser(userId);

        if (error) {
            console.error('[Admin] Delete auth user error:', error);
            return NextResponse.json({ error: error.message }, { status: 500 });
        }

        // 2. Ideally, profiles delete automatically. If not, we might need to delete manually, 
        // but 'on delete cascade' is standard. We'll assume cascade.
        // If you need to ensure profile is gone:
        // await supabaseAdmin.from('profiles').delete().eq('id', userId);

        return NextResponse.json({ success: true, message: 'User deleted successfully' });
    } catch (err: any) {
        console.error('[Admin] Unexpected error:', err);
        return NextResponse.json({ error: err.message || 'Internal Server Error' }, { status: 500 });
    }
}
