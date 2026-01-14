import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import nodemailer from "npm:nodemailer@6.9.13";

const corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

serve(async (req) => {
    if (req.method === 'OPTIONS') {
        return new Response('ok', { headers: corsHeaders });
    }

    try {
        const { user_email, subject, html_body } = await req.json();

        const transporter = nodemailer.createTransport({
            host: "smtp.gmail.com",
            port: 465,
            secure: true, // true for 465, false for other ports
            auth: {
                user: "deepsafe.app@gmail.com",
                pass: Deno.env.get("GMAIL_APP_PASSWORD"),
            },
        });

        const info = await transporter.sendMail({
            from: '"DeepSafe" <deepsafe.app@gmail.com>',
            to: user_email,
            subject: subject,
            html: html_body,
        });

        console.log("Message sent: %s", info.messageId);

        return new Response(
            JSON.stringify({ message: "Email sent successfully", id: info.messageId }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
                status: 200,
            }
        );

    } catch (error) {
        console.error("Error sending email:", error);
        return new Response(
            JSON.stringify({ error: error.message }),
            {
                headers: { ...corsHeaders, "Content-Type": "application/json" },
                status: 400,
            }
        );
    }
});
