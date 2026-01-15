import type { Metadata, Viewport } from "next";
import { Inter, Orbitron } from "next/font/google";
import "./globals.css";
import { LayoutWrapper } from "@/components/layout/LayoutWrapper";
import Script from "next/script";

const inter = Inter({ subsets: ["latin"], variable: '--font-inter' });
const orbitron = Orbitron({ subsets: ["latin"], variable: '--font-orbitron' });



export const viewport: Viewport = {
  themeColor: "#0f172a",
  width: "device-width",
  initialScale: 1,
  maximumScale: 1,
  userScalable: false,
  viewportFit: "cover",
};

export const metadata: Metadata = {
  metadataBase: new URL('https://deepsafe.app'),
  title: {
    default: "DeepSafe - Impara la Sicurezza Digitale Giocando (Gratis)",
    template: "%s | DeepSafe"
  },
  description: "Il Duolingo della vita digitale. La piattaforma italiana per le competenze digitali. Impara cybersecurity, privacy e fake news giocando 5 minuti al giorno.",
  keywords: ["competenze digitali", "scuola digitale", "cybersecurity gratis", "impara sicurezza informatica", "duolingo sicurezza", "gioco educativo", "cittadinanza digitale", "italia", "formazione phishing"],
  authors: [{ name: "DeepSafe Team" }],
  creator: "DeepSafe",
  publisher: "DeepSafe",
  icons: {
    icon: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/new-logo.png`,
    apple: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/new-logo.png`,
  },
  openGraph: {
    type: "website",
    locale: "it_IT",
    url: "https://deepsafe.app",
    title: "DeepSafe - Il Tuo Coach di Vita Digitale",
    description: "Trasforma la sicurezza informatica in un gioco. Sfida i tuoi amici, scala la classifica e proteggi il tuo futuro digitale con lezioni da 5 minuti.",
    siteName: "DeepSafe",
    images: [
      {
        url: "/landing/assets/og-youth.jpg",
        width: 1200,
        height: 630,
        alt: "DeepSafe App Preview",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "DeepSafe - Competenze Digitali per Tutti",
    description: "Impara a difenderti online giocando. Il modo più semplice per capire la cybersecurity.",
    images: ["/landing/assets/og-youth.jpg"],
  },
  manifest: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/manifest.json`,
  appleWebApp: {
    capable: true,
    statusBarStyle: "black-translucent",
    title: "DeepSafe",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    google: "8qmREYvq02YN2lDjMscR2l6ysUa6ZfMPd3nHhzsA29k",
  },
};

const jsonLd = {
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "DeepSafe",
  "applicationCategory": "EducationalApplication",
  "operatingSystem": "Web, iOS, Android",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "EUR"
  },
  "description": "Piattaforma gamificata per l'apprendimento della sicurezza informatica e delle competenze digitali.",
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "ratingCount": "1250"
  },
  "featureList": "Gamification, Corsi Cybersecurity, Quiz Interattivi, Leaderboard, Sfide Giornaliere"
};


import { SystemUIProvider } from "@/context/SystemUIContext";
import { SoundProvider } from "@/context/SoundContext";

import { PostHogProvider } from "./providers";
import { MobileConfig } from "@/components/layout/MobileConfig";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${inter.variable} ${orbitron.variable} antialiased bg-cyber-dark`}
      >
        {/* Google Analytics */}
        <Script
          src="https://www.googletagmanager.com/gtag/js?id=G-HJWJBEW0ZS"
          strategy="afterInteractive"
        />
        <Script id="google-analytics" strategy="afterInteractive">
          {`
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'G-HJWJBEW0ZS');
          `}
        </Script>

        {/* Schema.org Educational JSON-LD */}
        <Script id="json-ld" type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

        <PostHogProvider>
          <SystemUIProvider>
            <SoundProvider>
              <LayoutWrapper>
                <MobileConfig />
                {children}
              </LayoutWrapper>
            </SoundProvider>
          </SystemUIProvider>
        </PostHogProvider>
      </body>
    </html>
  );
}
