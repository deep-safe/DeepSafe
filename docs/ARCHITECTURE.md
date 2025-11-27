# 🧩 Architecture & Database

This document provides a technical deep dive into the **Deepsafe** platform. It covers the technology stack, project structure, and database schema.

## 🛠️ Tech Stack

- **Framework**: [Next.js 14](https://nextjs.org/) (App Router) - Server-side rendering and API routes.
- **Styling**: [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS with a custom "Cyber" theme configuration.
- **Database & Auth**: [Supabase](https://supabase.com/) - PostgreSQL database, Authentication, and Storage.
- **State Management**: [Zustand](https://github.com/pmndrs/zustand) - Lightweight client-side state (Lives, XP, Streaks).
- **Payments**: [Stripe](https://stripe.com/) - Payment processing for subscriptions and one-time purchases.
- **Icons**: [Lucide React](https://lucide.dev/) - Consistent, clean iconography.

## 📂 Directory Structure

```
src/
├── app/                    # Next.js App Router
│   ├── admin/              # Admin Panel (Protected)
│   ├── api/                # Backend API Routes (Checkout, Webhooks)
│   ├── dashboard/          # Main Italy Map view
│   ├── login/              # Auth Pages
│   ├── profile/            # User Profile, Stats, and Badges
│   ├── shop/               # Black Market (Monetization)
│   ├── training/           # Dynamic Training Interface
│   └── page.tsx            # Landing Page
├── components/
│   ├── dashboard/          # Map Components (ItalyMapSVG, ProvincePath)
│   ├── gamification/       # Game UI (Badges, StreakModal)
│   ├── layout/             # Global layout (BottomNav, Header)
│   ├── shop/               # Shop Components (MysteryBox)
│   └── ui/                 # Reusable atoms (Buttons, Cards)
├── data/                   # Static Data (Provinces, Quizzes)
├── hooks/                  # Custom Hooks (useDailyStreak, useHaptic)
├── lib/                    # Utilities (cn, formatters)
├── store/                  # Zustand stores (useUserStore)
└── types/                  # TypeScript definitions (Supabase generated)
```

## 🗄️ Database Schema (Supabase)

The application is built on PostgreSQL. Here are the core tables:

### `profiles`
The central user record, linked 1:1 with `auth.users`.
- `id` (UUID): Primary Key.
- `username` (Text): Display name.
- `xp` (Int): Total experience points.
- `current_hearts` (Int): Current lives (Max 5).
- `is_premium` (Bool): "Deepsafe Elite" status.
- `streak_freezes` (Int): Number of freezes owned.
- `highest_streak` (Int): Current daily streak count.
- `last_login` (Text): ISO Date string (YYYY-MM-DD) of the last login.
- `unlocked_provinces` (Array): List of unlocked province IDs.
- `province_scores` (JSONB): Record of scores per province.
- `earned_badges` (JSONB): List of earned badges with timestamps.
- `inventory` (JSONB): List of owned items.

### `missions`
Defines the dynamic content for each province.
- `id` (UUID): Primary Key.
- `province_id` (Text): Link to Province ID (e.g., 'MI').
- `title` (Text): Mission title.
- `content` (Text): Markdown content for the lesson.
- `xp_reward` (Int): XP gained on completion.
- `level` (Enum): Difficulty level.

### `shop_items`
Defines items available in the Black Market.
- `id` (Text): Primary Key (e.g., 'streak_freeze').
- `name` (Text): Display name.
- `cost` (Int): Price in NeuroCredits.
- `effect_type` (Text): Logic handler (e.g., 'refill_lives').

### `badges`
Defines available achievements.
- `id` (Text): Primary Key.
- `name` (Text): Badge name.
- `condition` (Text): Description of how to unlock.

## 🔐 Security

- **RLS (Row Level Security)**: Enabled on all tables. Users can only read/write their own data. Public data (like Leaderboards) is exposed via specific policies.
- **Middleware**: `middleware.ts` protects private routes (`/dashboard`, `/profile`) and redirects unauthenticated users to `/login`.
- **Secure Webhooks**: Stripe webhooks use the `SUPABASE_SERVICE_ROLE_KEY` to bypass RLS for administrative updates (e.g., granting Premium status) but verify the Stripe signature to prevent spoofing.
