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
