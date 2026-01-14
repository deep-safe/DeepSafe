# Shop Updates (2025-12-24)

## Price Rebalancing
- **Reduced Prices**:
    - Small Pack (500 NC): €1.99 (was €4.99)
    - Medium Pack (1200 NC): €3.99 (was €9.99)
    - Large Pack (2500 NC): €7.99 (was €19.99)
- **Frontend**: Updated `src/app/shop/page.tsx` to display the new prices.
- **Backend Setup**: Updated `TO_SIMO_DO.md` with instructions to create these new products in Stripe.

## Previous Fixes
- **Mystery Box Cost**: Fixed the mystery box logic to correctly deduct 150 NC.

# Website Transformation (2025-12-27)
- **Landing Page Refactor**: Updated `src/app/page.tsx` to serve as the homepage.
    - Removed Waitlist logic.
    - Replaced Countdown.
- **New Site Structure**:
    - **`src/components/site/SiteNavbar.tsx`**: Shared navigation component.
    - **`src/components/site/SiteFooter.tsx`**: Shared footer component.
    - **`/chi-siamo`**: About Us page featuring founders Mattioli & Suarato.
    - **`/prezzi`**: Pricing page with Free, Pro, and Elite tiers.
    - **`/links`**: Resources page.

## Analytics & SEO
- **Google Analytics**: Integrated Tracking ID `G-HJWJBEW0ZS` via `next/script` in `src/app/layout.tsx`.
- **Google Verification**: Added Google Site Verification tag `8qmREYvq02YN2lDjMscR2l6ysUa6ZfMPd3nHhzsA29k`.

## Feedback System (2025-12-27)
- **Incentive**: Added visualization of "1 Month Free PRO" reward for constructive feedback.
- **UI Changes**:
    - **Profile Page**: Added teaser text below the "Send Feedback" button.
    - **Feedback Modal**: Added a "Special Reward" banner with details.

# Admin Panel Updates (2026-01-07)
- **User Email Display**: Replaced User ID with Email in the Admin Panel user list.
- **Secure API**: Implemented `/api/admin/users` to securely fetch email addresses from `auth.users` using the Service Role.
- **Search**: Enhanced search functionality to support searching by email address.

# Shop Price Optimization (2026-01-14)
## Coin Pack Rebalancing
- **Obiettivo**: Rendere le monete più convenienti e fornire vantaggi effettivi agli utenti.
- **Modifiche ai Prezzi**:
    - **Starter Pack**: 1000 NC a €0.99 (era 500 NC a €1.99) - **+100% monete, -50% prezzo**
    - **Pacchetto POPOLARE**: 2500 NC a €1.49 (era 1200 NC a €3.99) - **Bonus +68%**
    - **Pacchetto MIGLIOR VALORE**: 6000 NC a €3.99 (era 2500 NC a €7.99) - **Bonus +50%**
- **File Modificato**: `src/app/shop/page.tsx` (righe 323-360)
- **Verifica Build**: ✅ Compilato con successo, 34 pagine generate correttamente
- **Note**: I prezzi Stripe dovranno essere aggiornati separatamente nel dashboard quando la funzionalità sarà attivata.

## Mystery Box Price Increase
- **Obiettivo**: Rendere la Cassa Crittografata più speciale e meno facilmente ottenibile.
- **Modifica**: Prezzo aumentato da **150 NC a 500 NC** (+233%)
- **File Modificati**: 
    - `src/app/shop/page.tsx` (righe 230, 407)
    - `src/lib/supabase/02_mystery_box_fix.sql` (righe 18, 71)
- **Script SQL**: Creato `sql_updates/update_mystery_box_price.sql` per aggiornare il database esistente
- **Verifica Build**: ✅ Compilato con successo

# Email Notifica Regalo (2026-01-14)

## Obiettivo
Implementare l'invio automatico di email quando viene inviato un regalo agli utenti dal pannello admin, per notificarli immediatamente e invitarli a controllare l'app.

## Implementazione

### Backend - Database
- **Migration SQL**: `supabase/migrations/20250114_add_gift_email_notification.sql`
  - Abilita l'estensione `pg_net` per chiamate HTTP da PostgreSQL
  - Crea la funzione `send_gift_notification_email()` che:
    - Recupera l'email dell'utente da `auth.users`
    - Recupera il username da `profiles`
    - Costruisce un'email HTML professionale con template personalizzato
    - Invia l'email tramite Resend API usando `pg_net.http_post()`
    - Gestisce gli errori senza bloccare l'invio del regalo
  - Modifica la funzione `send_gift()` per chiamare automaticamente `send_gift_notification_email()`
  - Aggiunge la colonna `icon_url` alla tabella `gifts` se non esiste

### Email Template
Template HTML professionale con:
- **Design**: Stile dark mode coerente con l'identità DeepSafe
- **Responsive**: Ottimizzato per desktop e mobile
- **Contenuto Dinamico**:
  - Nome utente personalizzato
  - Descrizione del regalo (crediti, vite, avatar)
  - Messaggio personalizzato dai founder
  - CTA button per aprire l'app
- **Branding**: Logo, colori gradient cyan/blue, emoji regalo 🎁

### Servizio Email
- **Provider**: Resend ([resend.com](https://resend.com))
- **Piano**: Gratuito - 3,000 email/mese, 100 email/giorno
- **Invio**: Asincrono tramite `pg_net`, non blocca la creazione del regalo
- **Gestione Errori**: Se l'email fallisce, il regalo viene comunque creato e l'errore viene loggato

### Configurazione Richiesta
1. Creare account su Resend
2. Ottenere API Key da Resend dashboard
3. Configurare la API Key in Supabase:
   ```sql
   ALTER DATABASE postgres SET app.settings.resend_api_key = 're_YOUR_API_KEY';
   SELECT pg_reload_conf();
   ```
4. Eseguire la migration `20250114_add_gift_email_notification.sql`

### File Correlati
- **Migration**: `supabase/migrations/20250114_add_gift_email_notification.sql`
- **Guida Setup**: `RESEND_SETUP_GUIDE.md` - Guida dettagliata per configurare Resend
- **Componente Admin**: `src/components/admin/GiftModal.tsx` (nessuna modifica richiesta)
- **Funzione Regalo**: Modificata `send_gift()` in PostgreSQL

### Funzionalità
- ✅ Invio automatico email quando un admin invia un regalo
- ✅ Template HTML professionale e responsive
- ✅ Supporto per tutti i tipi di regalo (crediti, vite, avatar)
- ✅ Invio asincrono (non blocca l'UI)
- ✅ Gestione errori robusta
- ✅ Personalizzazione messaggio per ogni regalo
- ✅ Log degli errori per debugging

### Testing
Per testare l'invio email:
1. Configurare Resend come descritto in `RESEND_SETUP_GUIDE.md`
2. Accedere al pannello admin (`/admin`)
3. Selezionare un utente (preferibilmente il proprio account)
4. Inviare un regalo qualsiasi
5. Verificare la ricezione dell'email
6. Controllare i log Resend per conferma invio

### Note Tecniche
- Le email sono inviate **dopo** la creazione del regalo nel database
- Se l'utente non ha email, viene loggato un WARNING ma il regalo viene creato
- L'invio email usa `PERFORM` (non `SELECT`) per esecuzione asincrona
- La API key è configurata a livello database per sicurezza
- Il template email supporta personalizzazione completa del messaggio

