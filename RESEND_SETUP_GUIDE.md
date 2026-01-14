# Guida Configurazione Resend per Email Regalo

## Passaggi per configurare Resend

### 1. Crea un account Resend

1. Vai su [resend.com](https://resend.com)
2. Registrati con la tua email
3. Verifica l'account

### 2. Ottieni la API Key

1. Vai nella dashboard di Resend
2. Clicca su "API Keys" nel menu laterale
3. Clicca su "Create API Key"
4. Dai un nome (es. "DeepSafe Production")
5. Seleziona i permessi: "Sending access"
6. Copia la chiave API (inizia con `re_`)

### 3. Configura il dominio (Opzionale ma consigliato)

**Opzione A: Usa il dominio di test di Resend**
- Resend fornisce `onboarding@resend.dev` per il testing
- Limite: 100 email/giorno
- Non serve configurazione DNS

**Opzione B: Configura il tuo dominio personalizzato**
1. Nella dashboard Resend, vai su "Domains"
2. Clicca "Add Domain"
3. Inserisci il tuo dominio (es. `deepsafe.app`)
4. Aggiungi i record DNS forniti da Resend:
   - Record SPF (TXT)
   - Record DKIM (TXT)
   - Record DMARC (TXT)
5. Aspetta la verifica (può richiedere qualche minuto)

### 4. Aggiungi la API Key a Supabase

**Metodo 1: Usando Supabase Dashboard (Consigliato per produzione)**

1. Vai su Supabase Dashboard > Project Settings > Database
2. Clicca su "Custom PostgreSQL config"
3. Aggiungi una nuova configurazione:
   ```
   app.settings.resend_api_key = 're_your_api_key_here'
   ```
4. Salva e riavvia il database

**Metodo 2: Usando SQL Editor (Più semplice per testing)**

Esegui questo comando nel SQL Editor di Supabase:

```sql
-- Set della API key come configurazione PostgreSQL
ALTER DATABASE postgres SET app.settings.resend_api_key = 're_your_api_key_here';

-- Ricarica la configurazione
SELECT pg_reload_conf();
```

**Metodo 3: Usando Supabase Vault (Più sicuro)**

```sql
-- Inserisci la secret nel vault
INSERT INTO vault.secrets (name, secret)
VALUES ('resend_api_key', 're_your_api_key_here');

-- Poi modifica la funzione per usare il vault invece di current_setting
```

### 5. Esegui la Migration

1. Apri il SQL Editor di Supabase
2. Copia tutto il contenuto del file `20250114_add_gift_email_notification.sql`
3. Incolla ed esegui
4. Verifica che non ci siano errori

### 6. Test di invio

Dopo aver eseguito la migration, prova a inviare un regalo dal pannello admin:
1. Vai su `/admin`
2. Seleziona un utente (il tuo account per testare)
3. Invia un regalo
4. Controlla la tua email

### 7. Monitoraggio

- Controlla i log di Resend nella dashboard per vedere le email inviate
- Nel piano gratuito hai 3,000 email/mese e 100 email/giorno
- Monitora l'uso nella dashboard Resend

## Troubleshooting

### L'email non arriva

1. Controlla i log di Resend per vedere se l'email è stata inviata
2. Controlla la cartella spam
3. Verifica che la API key sia corretta
4. Controlla i log di Supabase per errori

### Errore "API key not found"

Assicurati di aver configurato correttamente la API key in Supabase come descritto nel punto 4.

### Errore "Invalid domain"

Se usi un dominio personalizzato, assicurati che sia verificato in Resend. Altrimenti usa `onboarding@resend.dev` per il testing.

## Note importanti

- Le email sono inviate in modo **asincrono** tramite `pg_net`, quindi non bloccano l'invio del regalo
- Se l'invio email fallisce, il regalo viene comunque creato
- Gli errori vengono loggati come WARNING nei log di Supabase

## Link utili

- [Resend Documentation](https://resend.com/docs)
- [Resend Email API](https://resend.com/docs/api-reference/emails/send-email)
- [Supabase pg_net Extension](https://supabase.com/docs/guides/database/extensions/pg_net)
