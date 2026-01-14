-- Migration: Call Edge Function for Gift Emails
-- Created: 2026-01-14

-- Aggiorna la funzione per chiamare la Edge Function invece di Resend
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
    v_function_url TEXT;
    v_anon_key TEXT;
BEGIN
    -- Configurazione (Sostituisci con il tuo URL del progetto Supabase)
    -- Esempio: https://<project_ref>.supabase.co/functions/v1/send-gift-email
    -- Lo puoi trovare nella dashboard sotto Edge Functions :)
    
    -- TRUCCO: Ottieni l'URL del progetto dalle variabili interne o impostalo manualmente qui sotto
    -- Sostituisci questo URL con quello che trovi nella dashboard di Supabase!
    v_function_url := current_setting('app.settings.edge_function_url', true);
    
        v_function_url := 'https://rxbvbxrobuaebrvcrcrg.supabase.co/functions/v1/send-gift-email';

    -- Ottieni la anon key (serve per chiamare la funzione)
    v_anon_key := current_setting('app.settings.anon_key', true);
    -- Fallback se non trovata (copia la tua anon key qui se serve)
    IF v_anon_key IS NULL THEN
       v_anon_key := 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ4YnZieHJvYnVhZWJydmNyY3JnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2Njg4NjYsImV4cCI6MjA3OTI0NDg2Nn0.5U91aLDfkW9QIKq_0UoE8MG1kr7WABU81mVSTGimjdc';
    END IF;

    -- Get user email
    SELECT email INTO v_user_email FROM auth.users WHERE id = p_user_id;
    SELECT username INTO v_username FROM profiles WHERE id = p_user_id;
    
    IF v_user_email IS NULL THEN
        RAISE WARNING 'No email found for user %', p_user_id;
        RETURN;
    END IF;
    
    -- Costruisci i testi
    CASE p_gift_type
        WHEN 'credits' THEN v_gift_description := p_gift_amount || ' Crediti NC';
        WHEN 'hearts' THEN v_gift_description := p_gift_amount || ' Vite ❤️';
        WHEN 'avatar' THEN v_gift_description := 'un Avatar Esclusivo 👤';
        ELSE v_gift_description := 'un regalo speciale';
    END CASE;
    
    v_email_subject := '🎁 Hai ricevuto un regalo su DeepSafe!';
    
    -- Template HTML
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

    -- Chiamata HTTP alla Edge Function
    BEGIN
        PERFORM net.http_post(
            url := v_function_url,
            headers := jsonb_build_object(
                'Content-Type', 'application/json',
                'Authorization', 'Bearer ' || v_anon_key
            ),
            body := jsonb_build_object(
                'user_email', v_user_email,
                'subject', v_email_subject,
                'html_body', v_email_body
            )
        );
        RAISE NOTICE 'Gift notification call sent to Edge Function for %', v_user_email;
    EXCEPTION WHEN OTHERS THEN
        RAISE WARNING 'Failed to call Edge Function for %: %', v_user_email, SQLERRM;
    END;
END;
$$;
