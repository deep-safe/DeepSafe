

### Test 2: Condivisione Codice (Mobile)
1. Apri l'app su un dispositivo mobile
2. Vai su `/profile`
3. Clicca "Condividi" nella sezione "Invita Amici"
4. Verifica che si apra il menu di condivisione nativo

### Test 3: Riscatto Codice durante Registrazione ✅
**IMPLEMENTATO!** Il campo "Codice Amico" è ora presente nel form di registrazione.

Per testare:
1. Vai su `/login` e clicca "REGISTRATI"
2. Compila Username, Email, Password
3. Nel campo "**Codice Amico (Opzionale)**" inserisci un codice valido (es: ABC123)
4. Registrati normalmente
5. Il codice verrà automatically riscattato dopo la creazione account
6. Verifica che entrambi gli utenti (referrer e nuovo) abbiano ricevuto +10 cuori

**Nota**: Il riscatto codice è automatico e non-bloccante. Se il codice è invalido, la registrazione procede comunque ma viene loggato un warning in console.

### Test 4: Attivazione PRO
1. Inserisci manualmente dei mesi guadagnati (per test):
```sql
UPDATE profiles SET pro_months_earned = 3 WHERE id = 'TUO_USER_ID';
```
2. Vai su `/profile`
3. Nella sezione "Status PRO" dovresti vedere:
   - Progress bar: 3/12
   - Pulsante "ATTIVA PRO (3 MESI)"
4. Clicca il pulsante
5. Verifica che:
   - Appaia il badge "PRO ATTIVO"
   - La data di scadenza sia corretta (oggi + 3 mesi)
   - Il pulsante scompaia

### Test 5: Scadenza PRO
1. Imposta manualmente una data di scadenza passata:
```sql
UPDATE profiles SET pro_expires_at = '2026-01-01', is_premium = true WHERE id = 'TUO_USER_ID';
```
2. Esegui la funzione di controllo scadenza:
```sql
SELECT check_pro_expiration();
```
3. Verifica che `is_premium` diventi `false`

## 3. Implementare UI per Inserimento Codice Invito (TODO FUTURO)

Al momento gli utenti non possono ancora inserire un codice invito dall'interfaccia. Devi decidere dove implementare questa funzionalità:

**Opzione 1: Modale al primo accesso**
- Mostra una modale dopo la registrazione
- Chiedi "Hai un codice invito?"
- Input field + pulsante "Riscatta"

**Opzione 2: Sezione nel profilo**
- Aggiungi una sezione "Hai un codice invito?" nel profilo
- Visibile solo se l'utente non ha mai riscattato un codice

**Opzione 3: Pagina dedicata**
- Crea `/redeem` page
- Input field centrato + design accattivante

## 4. Monitorare i Referral

Per vedere quanti referral sono stati effettuati:

```sql
-- Conta totale referral
SELECT COUNT(*) FROM referrals;

-- Referral per utente
SELECT 
    p.username,
    COUNT(r.id) as referral_count,
    p.pro_months_earned
FROM profiles p
LEFT JOIN referrals r ON r.referrer_id = p.id
GROUP BY p.id
ORDER BY referral_count DESC;

-- Utenti con PRO attivo tramite referral
SELECT 
    username,
    pro_months_earned,
    pro_activated_at,
    pro_expires_at
FROM profiles
WHERE is_premium = true AND pro_months_earned > 0;
```

## 5. Eventuale Personalizzazione

Se vuoi modificare qualche parametro:

### Cambiare il limite massimo di referral (default: 12)
Modifica la migration SQL alla linea del CHECK constraint:
```sql
ALTER TABLE profiles ADD COLUMN pro_months_earned INTEGER DEFAULT 0 
    CHECK (pro_months_earned >= 0 AND pro_months_earned <= 12);  -- Cambia qui
```

### Cambiare i cuori bonus (default: +10)
Modifica nella funzione `redeem_code`:
```sql
UPDATE profiles SET current_hearts = LEAST(5, current_hearts + 10)  -- Cambia qui
```

### Cambiare i mesi Pro per referral (default: 1 mese)
Modifica nella funzione `redeem_code`:
```sql
UPDATE profiles SET pro_months_earned = LEAST(12, pro_months_earned + 1)  -- Cambia qui
```

---

## 6. Feedback Integration (NUOVO - 2026-01-15)

**Cosa fa**: Esegui anche la migration `20250115_feedback_pro_reward.sql` che integra il sistema feedback con il sistema Pro.

**Risultato**: Quando un utente invia il primo feedback, guadagna automaticamente +1 mese PRO (massimo 12 totali).

### Test after migration:
1. Login con account di test
2. Vai in profilo → "Invia Feedback"
3. Invia un feedback qualsiasi
4. Verifica che ProStatusCard mostri +1 mese guadagnato

### Verifica SQL:
```sql
-- Utenti che hanno ricevuto Pro da feedback
SELECT username, pro_months_earned, has_submitted_feedback
WHERE has_submitted_feedback = true;
```

Monitora analytics referral

## 7. Setup Controllo Automatico Scadenza PRO (NUOVO - 2026-01-15)

Oltre alla logica di business, abbiamo implementato un controllo automatico della scadenza PRO.

### 1. Verifica pg_cron (Manuale)
Vai nella dashboard di Supabase -> Database -> Extensions.
Cerca `pg_cron` e assicurati che sia abilitato. La migration prova ad abilitarlo, ma potrebbe richiedere permessi superiori.
Se la migration fallisce su `CREATE EXTENSION`, abilitalo manualmente dalla dashboard.

### 2. Monitorare Job schedulato
Per verificare che il job sia schedulato correttamente:
```sql
SELECT * FROM cron.job;
```
Dovresti vedere un job chiamato `daily_pro_check`.

### 3. Verifica Lazy Check
Il controllo avviene anche ogni volta che l'utente apre il profilo (`get_referral_stats`).
Per testarlo, imposta una data di scadenza nel passato e ricarica il profilo: è immediato.


## 8. Admin Referral Analytics (NUOVO - 2026-01-15)

È stata aggiunta una dashboard dedicata per monitorare i referral.

### 1. Applicare Migrazione
Esegui lo script SQL:
`supabase/migrations/20260115_admin_referral_analytics.sql`

Questo creerà la funzione `get_admin_referral_stats`.

### 2. Accesso
1. Vai su `/admin` (devi essere admin e aver sbloccato con codice).
2. Clicca sul nuovo pulsante "REFERRALS".
3. Verifica che i grafici e la classifica (leaderboard) si carichino correttamente.
