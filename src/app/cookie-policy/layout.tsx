import type { Metadata } from "next";

export const metadata: Metadata = {
    title: "Cookie Policy - DeepSafe",
    description: "Informativa sui cookie di DeepSafe. Scopri come utilizziamo i cookie per migliorare la tua esperienza.",
};

export default function CookieLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
