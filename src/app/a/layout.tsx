import type { Metadata } from "next";

export const metadata: Metadata = {
    title: "DeepSafe Professional - Secure Your Digital Future",
    description: "Proteggi la tua carriera e i tuoi dati. DeepSafe Professional offre formazione avanzata di cybersecurity per professionisti.",
    openGraph: {
        title: "DeepSafe Professional - Secure Your Digital Future",
        description: "Proteggi la tua carriera e i tuoi dati. DeepSafe Professional offre formazione avanzata di cybersecurity per professionisti.",
        images: [
            {
                url: "/landing/assets/og-adult.jpg",
                width: 1200,
                height: 630,
                alt: "DeepSafe Professional Preview",
            },
        ],
    },
    twitter: {
        card: "summary_large_image",
        title: "DeepSafe Professional - Secure Your Digital Future",
        description: "Proteggi la tua carriera e i tuoi dati.",
        images: ["/landing/assets/og-adult.jpg"],
    },
};

export default function AdultLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
