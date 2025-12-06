import type { Metadata, Viewport } from "next";
import { Inter, Orbitron } from "next/font/google";
import "./globals.css";
import { LayoutWrapper } from "@/components/layout/LayoutWrapper";

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
  metadataBase: new URL('https://deepsafe.app'), // Replace with actual domain
  title: {
    default: "DeepSafe - Educazione Digitale Gamificata",
    template: "%s | DeepSafe"
  },
  description: "Impara a navigare in sicurezza e proteggi la tua vita digitale attraverso il gioco.",
  keywords: ["educazione digitale", "sicurezza informatica", "gamification", "giovani", "scuola", "cittadinanza digitale", "italia"],
  authors: [{ name: "DeepSafe Team" }],
  creator: "DeepSafe",
  publisher: "DeepSafe",
  icons: {
    icon: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/icon.png`,
    apple: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/icon.png`,
  },
  openGraph: {
    type: "website",
    locale: "it_IT",
    url: "https://deepsafe.app",
    title: "DeepSafe - Educazione Digitale Gamificata",
    description: "Impara a navigare in sicurezza e proteggi la tua vita digitale attraverso il gioco.",
    siteName: "DeepSafe",
    images: [
      {
        url: "/landing/assets/og-youth.jpg", // Ensure this image exists or use a placeholder
        width: 1200,
        height: 630,
        alt: "DeepSafe Youth Preview",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "DeepSafe - La Cybersicurezza Gamificata per Giovani",
    description: "Il mondo digitale è sotto attacco. Hai le skills per salvarlo?",
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
