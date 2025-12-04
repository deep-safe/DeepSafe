import type { Metadata } from "next";

export const metadata: Metadata = {
    title: "Termini e Condizioni - DeepSafe",
    description: "Termini di servizio e condizioni d'uso per l'applicazione DeepSafe.",
};

export default function TermsLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
