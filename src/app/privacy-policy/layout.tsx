import type { Metadata } from "next";

export const metadata: Metadata = {
    title: "Privacy Policy - DeepSafe",
    description: "Informativa sulla privacy di DeepSafe. Scopri come proteggiamo i tuoi dati personali.",
};

export default function PrivacyLayout({
    children,
}: {
    children: React.ReactNode;
}) {
    return <>{children}</>;
}
