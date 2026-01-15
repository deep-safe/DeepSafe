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

# Sistema Multi-Casse Crittografate (2026-01-15)

## Obiettivo
Implementare 3 livelli di rarità per le casse crittografate nello shop, con prezzi diversi e probabilità variabili di ottenere ricompense migliori.

## Sistema Implementato

### 3 Tipologie di Casse
1. **Cassa Crittografata Base** (🎁)
   - **Prezzo**: 300 NC (ridotto dalla vecchia cassa singola a 500 NC)
   - **Probabilità**: Alta per ricompense comuni, bassa per ricompense rare

2. **Cassa Crittografata Rara** (💎)
   - **Prezzo**: 800 NC
   - **Probabilità**: Equilibrata tra ricompense comuni e rare
   - **Badge**: "POPOLARE"

3. **Cassa Crittografata Leggendaria** (⭐)
   - **Prezzo**: 2000 NC
   - **Probabilità**: Alta per ricompense rare ed epiche
   - **Badge**: "MIGLIORE VALORE"
   - **Effetto**: Glow dorato animato

### Pool di Ricompense
Tutte le casse condividono lo stesso pool di ricompense, ma con probabilità diverse:
- **Avatar Recluta** (Common) - ID: `avatar_rookie`
- **Avatar Cyber Ninja** (Rare) - ID: `avatar_ninja`
- **Avatar Elite Hacker** (Epic) - ID: `avatar_hacker`
- **Avatar Architetto** (Legendary) - ID: `avatar_architect`
- **100 NeuroCredits**
- **500 NeuroCredits**

### Distribuzione Probabilità (Pesi)

#### Cassa Base
- avatar_rookie: 50 (molto comune)
- credits 100: 60 (molto comune)
- avatar_ninja: 15 (raro)
- avatar_hacker: 5 (molto raro)
- credits 500: 5 (molto raro)
- avatar_architect: 1 (leggendario)

#### Cassa Rara
- avatar_rookie: 30 (comune)
- credits 100: 30 (comune)
- avatar_ninja: 40 (frequente)
- avatar_hacker: 20 (raro)
- credits 500: 15 (raro)
- avatar_architect: 5 (leggendario)

#### Cassa Leggendaria
- avatar_rookie: 10 (raro)
- credits 100: 10 (raro)
- avatar_ninja: 30 (frequente)
- avatar_hacker: 40 (molto frequente)
- credits 500: 30 (molto frequente)
- avatar_architect: 20 (frequente)

## Modifiche Database

### Migration SQL
- **File**: `supabase/migrations/20250115_add_multiple_mystery_boxes.sql`
- **Azioni**:
  1. Nasconde la vecchia `mystery_box` (mantiene storico, `is_visible = false`)
  2. Crea 3 nuove voci in `shop_items`: `mystery_box_basic`, `mystery_box_rare`, `mystery_box_legendary`
  3. Popola `mystery_box_loot` con loot tables specifiche per ogni cassa (18 righe totali)
  4. Nessuna modifica alla funzione `purchase_item` (già supporta box multipli dinamicamente)

### Tabelle Modificate
- **`shop_items`**: +3 righe nuove, 1 riga nascosta
- **`mystery_box_loot`**: +18 righe (6 per tipo di cassa)

## Modifiche Frontend

### File Modificati
1. **`src/app/shop/page.tsx`**
   - **Rimossa**: Sezione hardcoded per singola cassa (linee 391-412)
   - **Aggiunta**: Sezione dinamica con griglia 3 colonne per le casse
   - **Rimossa**: Funzione `handleMysteryBoxSection()` (obsoleta)
   - **Logica**: Le casse vengono caricate da database, filtrate per `effect_type = 'mystery_box'`, ordinate per costo

### Design UI
Ogni cassa ha stile personalizzato basato sulla rarità:

| Elemento | Base | Rara | Leggendaria |
|----------|------|------|-------------|
| Bordo | `border-purple-500/30` | `border-cyan-500/30` | `border-yellow-500/30` |
| Sfondo | `from-purple-950/20` | `from-cyan-950/20` | `from-yellow-950/20` |
| Bottone | `bg-purple-600` | `bg-cyan-600` | `bg-gradient-to-r from-yellow-600 to-yellow-500` |
| Ombra | Purple glow | Cyan glow | Gold glow + pulse |
| Badge | - | "POPOLARE" (cyan) | "MIGLIORE VALORE" (gold) |

### Responsive Design
- **Desktop**: Griglia a 3 colonne
- **Mobile**: Griglia a 1 colonna (stack verticale)
- **Hover**: Effetto scale-up leggero su desktop

## Funzionalità Mantenute
- ✅ Modal di decrittazione con animazioni
- ✅ Sistema di probabilità con pesi (weighted random)
- ✅ Gestione duplicati avatar (rimborso 50 NC)
- ✅ Feedback visivo durante acquisto
- ✅ Verifica crediti insufficienti
- ✅ Auth guard per utenti non loggati

## Testing Consigliato
1. **Database**: Verificare creazione corretta delle 3 casse e loot tables in Supabase
2. **UI**: Testare visualizzazione responsive su desktop e mobile
3. **Funzionale**: Acquistare ogni tipo di cassa e verificare distribuzione ricompense
4. **Edge Cases**: Testare con crediti insufficienti, avatar duplicati

## Note Tecniche
- Il sistema usa **weighted random selection**: somma dei pesi → numero random → scansione cumulativa
- La funzione `purchase_item` è generica e funziona con qualsiasi `box_id`
- La vecchia cassa resta nel database per non rompere gli storico acquisti precedenti
- I prezzi sono facilmente modificabili dalla tabella `shop_items` senza toccare il codice

## File Coinvolti
- ✅ `supabase/migrations/20250115_add_multiple_mystery_boxes.sql` (NEW)
- ✅ `src/app/shop/page.tsx` (MODIFIED)
- ✅ `TO_SIMO_DO.md` (UPDATED)
- ✅ `DOCUMENTATION.md` (UPDATED)

# Fix Persistenza Loot Table Shop Manager (2026-01-15)

## Problema
Nel pannello amministratore dello shop (`/admin/shop`), quando si configurava la loot table di una Cassa Crittografata usando il pulsante "CONFIGURE LOOT TABLE", i dati sembravano salvarsi correttamente ma dopo un refresh della pagina tutte le configurazioni venivano perse.

## Causa Radice
Il bug era nel componente `LootManagerModal.tsx` alla linea 24. Il problema riguardava la sincronizzazione dello stato locale del modal con i dati passati dal componente padre:

```typescript
// PRIMA (BUGGY)
const [loot, setLoot] = useState<LootItem[]>(initialLoot);
```

Il problema è che `useState` inizializza lo stato solo al **primo render del componente**. Quando il modal veniva riaperto dopo aver caricato i dati dal database, lo stato locale non si aggiornava con i nuovi dati passati tramite la prop `initialLoot`.

**Flusso del bug**:
1. ✅ Utente apre item mystery box esistente
2. ✅ Parent component carica loot dal database (`mystery_box_loot`)
3. ✅ Utente clicca "CONFIGURE LOOT TABLE"
4. ❌ Modal si apre con lo stato locale STALE (vecchi dati)
5. ✅ Utente modifica/aggiunge loot, clicca "SAVE CONFIGURATION"
6. ✅ Modal chiama `onSave(loot)` che aggiorna il parent
7. ✅ Parent salva correttamente in database via `handleSave()`
8. ❌ Al refresh: dati caricati dal DB OK, ma modal non sincronizza lo stato locale

## Soluzione Implementata

Aggiunto un `useEffect` hook per sincronizzare lo stato locale del modal ogni volta che:
- La prop `initialLoot` cambia (nuovi dati dal database)
- Il modal viene aperto (`isOpen` diventa `true`)

```typescript
// DOPO (FIXED)
import React, { useState, useEffect } from 'react';

// ...

useEffect(() => {
    if (isOpen) {
        setLoot(initialLoot);
    }
}, [initialLoot, isOpen]);
```

Questo garantisce che ogni volta che il modal si apre, lo stato locale viene aggiornato con i dati più recenti caricati dal database.

## File Modificati

### `src/components/admin/shop/LootManagerModal.tsx`
- **Linea 1**: Aggiunto import di `useEffect` da React
- **Linee 31-36**: Aggiunto `useEffect` hook per sincronizzazione stato

```diff
- import React, { useState } from 'react';
+ import React, { useState, useEffect } from 'react';

  export function LootManagerModal({ isOpen, onClose, boxId, initialLoot, onSave }: LootManagerModalProps) {
      const [loot, setLoot] = useState<LootItem[]>(initialLoot);
      // ...
      
+     // Sync local state with initialLoot prop when it changes or modal opens
+     useEffect(() => {
+         if (isOpen) {
+             setLoot(initialLoot);
+         }
+     }, [initialLoot, isOpen]);
```

## Funzionalità Ripristinate
- ✅ Configurazione loot table persiste dopo salvataggio
- ✅ Dati vengono correttamente caricati dal database al refresh
- ✅ Modal mostra sempre i dati aggiornati quando viene aperto
- ✅ Modifica loot esistenti funziona correttamente
- ✅ Aggiunta/rimozione item nel loot manager funziona come previsto

## Testing
Per verificare la fix:
1. Aprire `/admin/shop`
2. Modificare un mystery box esistente o crearne uno nuovo con `effect_type = 'mystery_box'`
3. Cliccare "CONFIGURE LOOT TABLE"
4. Aggiungere 2-3 ricompense con pesi e descrizioni diverse
5. Cliccare "SAVE CONFIGURATION" → "SAVE ITEM"
6. Refreshare la pagina (F5 o Cmd+R)
7. Riaprire lo stesso item e cliccare "CONFIGURE LOOT TABLE"
8. **Risultato Atteso**: Tutte le ricompense configurate sono visibili
9. **Risultato Prima del Fix**: Loot table era vuota

## Impatto
- **Complessità**: Bassa (aggiunta di 6 righe di codice)
- **Rischio**: Minimo (fix standard di React state sync)
- **Ambito**: Solo `LootManagerModal` component
- **Breaking Changes**: Nessuno

