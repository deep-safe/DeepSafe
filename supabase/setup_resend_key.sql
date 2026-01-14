-- Quick setup: Insert Resend API key into Supabase Vault
-- Run this BEFORE running the main migration

INSERT INTO vault.secrets (name, secret)
VALUES ('resend_api_key', 're_GchQY2NA_AoVtrFNgKqax723Dr3ZcdDBC')
ON CONFLICT (name) DO UPDATE SET secret = 're_GchQY2NA_AoVtrFNgKqax723Dr3ZcdDBC';
