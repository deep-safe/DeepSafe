import type { Metadata } from "next";

export const metadata: Metadata = {
    title: "DeepSafe - Navigare Sicuri a Ogni Età",
    description: "Internet semplice e sicuro. Impara a difenderti dalle truffe online con DeepSafe. Facile, intuitivo, per tutti.",
    openGraph: {
        title: "DeepSafe - Navigare Sicuri a Ogni Età",
        description: "Internet semplice e sicuro. Impara a difenderti dalle truffe online con DeepSafe.",
        images: [
            {
                url: "/landing/assets/og-senior.jpg",
                width: 1200,
                height: 630,
                alt: "DeepSafe Senior Preview",
            },
        ],
    },
    twitter: {
        card: "summary_large_image",
        title: "DeepSafe - Navigare Sicuri a Ogni Età",
        description: "Internet semplice e sicuro. Impara a difenderti dalle truffe online.",
        images: ["/landing/assets/og-senior.jpg"],
    },
};

export default function SeniorLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
