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
