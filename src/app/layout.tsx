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
    default: "DeepSafe - Cyber Security Gamified for Youth",
    template: "%s | DeepSafe"
  },
  description: "Il mondo digitale è sotto attacco. Hacker, deepfake e blackout minacciano il nostro paese. Hai le skills per salvarlo? Unisciti a DeepSafe.",
  keywords: ["cyber security", "gamification", "educazione digitale", "sicurezza informatica", "giovani", "italia", "deepfake", "hacker"],
  authors: [{ name: "DeepSafe Team" }],
  creator: "DeepSafe",
  publisher: "DeepSafe",
  openGraph: {
    type: "website",
    locale: "it_IT",
    url: "https://deepsafe.app",
    title: "DeepSafe - Cyber Security Gamified for Youth",
    description: "Il mondo digitale è sotto attacco. Hacker, deepfake e blackout minacciano il nostro paese. Hai le skills per salvarlo?",
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
    title: "DeepSafe - Cyber Security Gamified for Youth",
    description: "Il mondo digitale è sotto attacco. Hai le skills per salvarlo?",
    images: ["/landing/assets/og-youth.jpg"],
  },
  manifest: `${process.env.NEXT_PUBLIC_BASE_PATH || ''}/manifest.json`,
  appleWebApp: {
    capable: true,
    statusBarStyle: "black-translucent",
    title: "Deepsafe",
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
