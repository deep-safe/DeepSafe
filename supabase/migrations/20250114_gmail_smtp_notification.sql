-- Migration: Gift Email Notification with Gmail SMTP
-- Created: 2026-01-14
-- Description: Sends email notifications via Gmail SMTP when gifts are sent

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS pg_net;

-- Create function to send gift notification email via Gmail SMTP
CREATE OR REPLACE FUNCTION send_gift_notification_email(
    p_user_id UUID,
    p_gift_type TEXT,
    p_gift_amount INTEGER,
    p_gift_message TEXT
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_user_email TEXT;
    v_username TEXT;
    v_email_body TEXT;
    v_email_subject TEXT;
    v_gift_description TEXT;
    v_gmail_password TEXT;
BEGIN
    -- Get user email from auth.users
    SELECT email INTO v_user_email
    FROM auth.users
    WHERE id = p_user_id;

    -- Get username from profiles
    SELECT username INTO v_username
    FROM profiles
    WHERE id = p_user_id;

    -- If no email found, log and exit
    IF v_user_email IS NULL THEN
        RAISE WARNING 'No email found for user %', p_user_id;
        RETURN;
    END IF;

    -- Gmail App Password (INSERISCI QUI LA TUA APP PASSWORD)
    -- Sostituisci 'your_app_password_here' con la tua App Password Gmail
    v_gmail_password := 'your_app_password_here';

    -- Build gift description
    CASE p_gift_type
        WHEN 'credits' THEN
            v_gift_description := p_gift_amount || ' Crediti NC';
        WHEN 'hearts' THEN
            v_gift_description := p_gift_amount || ' Vite ❤️';
        WHEN 'avatar' THEN
            v_gift_description := 'un Avatar Esclusivo 👤';
        ELSE
            v_gift_description := 'un regalo speciale';
    END CASE;

    v_email_subject := '🎁 Hai ricevuto un regalo su DeepSafe!';

    -- Build HTML email body
    v_email_body := '<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regalo DeepSafe</title>
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, ''Segoe UI'', Roboto, ''Helvetica Neue'', Arial, sans-serif; background-color: #0f172a;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #0f172a;">
        <tr>
            <td align="center" style="padding: 40px 20px;">
                <table width="600" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); border-radius: 16px; overflow: hidden; box-shadow: 0 20px 60px rgba(6, 182, 212, 0.3); border: 1px solid rgba(6, 182, 212, 0.2);">
                    <tr>
                        <td align="center" style="padding: 40px 40px 20px; background: linear-gradient(135deg, #06b6d4 0%, #3b82f6 100%);">
                            <div style="font-size: 64px; margin-bottom: 10px;">🎁</div>
                            <h1 style="margin: 0; color: #ffffff; font-size: 32px; font-weight: bold; text-shadow: 0 2px 4px rgba(0,0,0,0.2);">HAI UN REGALO!</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 40px; color: #e2e8f0;">
                            <p style="font-size: 18px; line-height: 1.6; margin: 0 0 20px; color: #f1f5f9;">Ciao ' || COALESCE(v_username, 'Agente') || ',</p>
                            <p style="font-size: 16px; line-height: 1.6; margin: 0 0 20px; color: #cbd5e1;">Abbiamo una <strong style="color: #06b6d4;">sorpresa speciale</strong> per te! I Founder di DeepSafe ti hanno inviato un regalo esclusivo.</p>
                            <div style="background: rgba(6, 182, 212, 0.1); border-left: 4px solid #06b6d4; padding: 20px; margin: 30px 0; border-radius: 8px;">
                                <p style="margin: 0; font-size: 14px; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px;">IL TUO REGALO</p>
                                <p style="margin: 10px 0 0; font-size: 24px; font-weight: bold; color: #06b6d4;">' || v_gift_description || '</p>
                            </div>
                            <div style="background: rgba(251, 191, 36, 0.1); border: 1px solid rgba(251, 191, 36, 0.3); padding: 16px; margin: 30px 0; border-radius: 8px;">
                                <p style="margin: 0; font-size: 15px; color: #fbbf24; line-height: 1.5;">💬 <em>"' || p_gift_message || '"</em></p>
                            </div>
                            <p style="font-size: 16px; line-height: 1.6; margin: 30px 0 20px; color: #cbd5e1;">Apri l''app DeepSafe per scoprire tutti i dettagli e riscattare il tuo regalo!</p>
                            <table width="100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="center" style="padding: 10px 0;">
                                        <a href="https://deep-safe.github.io/DeepSafe/dashboard" style="display: inline-block; padding: 16px 40px; background: linear-gradient(135deg, #06b6d4 0%, #3b82f6 100%); color: #ffffff; text-decoration: none; border-radius: 12px; font-weight: bold; font-size: 16px; text-transform: uppercase; letter-spacing: 1px; box-shadow: 0 10px 30px rgba(6, 182, 212, 0.4);">🚀 APRI L''APP</a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 30px 40px; background-color: #0f172a; border-top: 1px solid rgba(6, 182, 212, 0.2);">
                            <p style="margin: 0 0 10px; font-size: 14px; color: #64748b; text-align: center;">DeepSafe - La tua piattaforma di formazione sulla cybersecurity</p>
                            <p style="margin: 0; font-size: 12px; color: #475569; text-align: center;">Questo è un messaggio automatico. Non rispondere a questa email.</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>';

    -- Send email via Gmail SMTP using Supabase Edge Function or external service
    -- Note: pg_net doesn't support SMTP directly, we use an HTTP relay service
    -- For now, we'll use a simple HTTP-to-SMTP bridge or Supabase Edge Function
    
    -- Using smtpjs.com as a relay (free tier available)
    -- Alternative: Create a Supabase Edge Function
    BEGIN
        PERFORM net.http_post(
            url := 'https://api.smtp2go.com/v3/email/send',
            headers := jsonb_build_object(
                'Content-Type', 'application/json',
                'X-Smtp2go-Api-Key', 'api-YOURKEY' -- Placeholder
            ),
            body := jsonb_build_object(
                'sender', 'deepsafe.app@gmail.com',
                'recipients', jsonb_build_array(v_user_email),
                'subject', v_email_subject,
                'html_body', v_email_body
            )
        );

        RAISE NOTICE 'Gift notification email sent to %', v_user_email;
    EXCEPTION WHEN OTHERS THEN
        RAISE WARNING 'Failed to send gift notification email to %: %', v_user_email, SQLERRM;
    END;

END;
$$;

-- Drop old send_gift function
DROP FUNCTION IF EXISTS send_gift(UUID, TEXT, INTEGER, TEXT, TEXT);

-- Create/update send_gift function
CREATE OR REPLACE FUNCTION send_gift(
    target_user_id UUID, 
    gift_type TEXT, 
    gift_amount INTEGER, 
    gift_message TEXT,
    gift_item_id TEXT DEFAULT NULL,
    gift_icon_url TEXT DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_is_admin BOOLEAN;
    v_gift_id UUID;
BEGIN
    SELECT is_admin INTO v_is_admin FROM profiles WHERE id = auth.uid();
    IF v_is_admin IS NOT TRUE THEN
        RAISE EXCEPTION 'Access Denied: Only admins can send gifts.';
    END IF;

    INSERT INTO gifts (user_id, type, amount, message, item_id, icon_url)
    VALUES (target_user_id, gift_type, gift_amount, gift_message, gift_item_id, gift_icon_url)
    RETURNING id INTO v_gift_id;

    PERFORM send_gift_notification_email(target_user_id, gift_type, gift_amount, gift_message);

    RETURN v_gift_id;
END;
$$;

-- Add icon_url column if not exists
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'gifts' AND column_name = 'icon_url'
    ) THEN
        ALTER TABLE gifts ADD COLUMN icon_url TEXT;
    END IF;
END $$;

COMMENT ON FUNCTION send_gift_notification_email IS 'Sends email notification via Gmail SMTP when user receives a gift';
COMMENT ON FUNCTION send_gift IS 'Admin function to send gifts with automatic email notification';
