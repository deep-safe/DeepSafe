import { createRouteHandlerClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';

/**
 * Server-Side Auth Callback for OAuth
 * Handles the OAuth callback from Supabase after Google authentication
 */
export async function GET(request: Request) {
    const requestUrl = new URL(request.url);
    const code = requestUrl.searchParams.get('code');
    const error = requestUrl.searchParams.get('error');
    const errorDescription = requestUrl.searchParams.get('error_description');

    // Handle OAuth errors (e.g., user cancelled login)
    if (error) {
        console.error('OAuth Error:', error, errorDescription);
        return NextResponse.redirect(
            `${requestUrl.origin}/login?error=auth_failed&message=${encodeURIComponent(errorDescription || 'Authentication failed')}`
        );
    }

    // Exchange code for session
    if (code) {
        try {
            const cookieStore = cookies();
            const supabase = createRouteHandlerClient({ cookies: () => cookieStore });

            const { error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);

            if (exchangeError) {
                console.error('Session Exchange Error:', exchangeError);
                return NextResponse.redirect(
                    `${requestUrl.origin}/login?error=auth_failed&message=${encodeURIComponent(exchangeError.message)}`
                );
            }

            // Successfully authenticated - redirect to dashboard
            return NextResponse.redirect(`${requestUrl.origin}/`);

        } catch (err: any) {
            console.error('Unexpected Error:', err);
            return NextResponse.redirect(
                `${requestUrl.origin}/login?error=auth_failed&message=${encodeURIComponent(err.message || 'Unexpected error occurred')}`
            );
        }
    }

    // No code provided - redirect to login
    return NextResponse.redirect(`${requestUrl.origin}/login?error=no_code`);
}
