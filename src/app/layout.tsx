import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { BottomNav } from "@/components/layout/BottomNav";
import { Header } from "@/components/layout/Header";
import { cn } from "@/lib/utils";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Deepsafe",
  description: "Learn AI Safety the fun way.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={cn(inter.className, "bg-zinc-50 dark:bg-zinc-950 text-zinc-900 dark:text-zinc-100 antialiased")}>
        <div className="min-h-screen flex flex-col max-w-md mx-auto bg-white dark:bg-zinc-950 shadow-2xl min-h-[100dvh]">
          <Header />
          <main className="flex-1 pt-16 pb-20 px-4 overflow-y-auto scrollbar-hide">
            {children}
          </main>
          <BottomNav />
        </div>
      </body>
    </html>
  );
}
