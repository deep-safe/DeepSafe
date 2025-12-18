import React from 'react';

type LeaderboardVariant = 'youth' | 'adult' | 'senior';

interface LeaderboardSectionProps {
    variant?: LeaderboardVariant;
}

export const LeaderboardSection: React.FC<LeaderboardSectionProps> = ({ variant = 'youth' }) => {
    // Content Configuration
    const content = {
        youth: {
            title: "Domina la Classifica",
            description: "Non sei solo in questa missione. Dimostra di essere il migliore hacker etico d'Italia.",
            features: [
                "Classifica Globale: scala la vetta nazionale",
                "Classifica Amici: sfida chi conosci",
                "Guadagna rispetto e premi esclusivi"
            ],
            bgClass: "bg-[#0a0a12]",
            textClass: "text-white",
            accentClass: "text-[#00f3ff]",
            borderClass: "border-[#00f3ff]",
            shadowClass: "shadow-[0_0_20px_rgba(0,243,255,0.2)]",
            listIcon: "►",
            headingShadow: "drop-shadow-[0_0_10px_rgba(0,243,255,0.5)]",
            reverse: false
        },
        adult: {
            title: "Performance & Ranking",
            description: "Misura le tue competenze nel panorama nazionale. La cybersecurity è competitiva.",
            features: [
                "Benchmarking Nazionale: confronta il tuo punteggio",
                "Network Professionale: competi con i colleghi",
                "Monitoraggio dei progressi in tempo reale"
            ],
            bgClass: "bg-slate-50/50",
            textClass: "text-slate-900 tracking-tight",
            accentClass: "text-indigo-600",
            borderClass: "border-slate-200",
            shadowClass: "shadow-2xl ring-1 ring-slate-900/5",
            listIcon: "chart",
            headingShadow: "",
            reverse: true
        },
        senior: {
            title: "Impara e Divertiti Insieme",
            description: "Studiare è più bello in compagnia. Guarda i progressi dei tuoi amici e festeggiate insieme i traguardi.",
            features: [
                "Vedi chi dei tuoi amici è online",
                "Scambiatevi consigli e aiuti",
                "Imparare diventa un gioco di gruppo"
            ],
            bgClass: "bg-emerald-50/50",
            textClass: "text-emerald-950 font-medium",
            accentClass: "text-emerald-600",
            borderClass: "border-white/80",
            shadowClass: "shadow-2xl shadow-emerald-100/50",
            listIcon: "check",
            headingShadow: "",
            reverse: false
        }
    };

    const cfg = content[variant];

    // Helper for icons based on variant
    const renderIcon = (type: string) => {
        if (variant === 'youth') return <span className={`${cfg.accentClass} mr-3`}>{cfg.listIcon}</span>;

        if (variant === 'adult') {
            return (
                <div className="w-6 h-6 rounded-full bg-indigo-100 flex items-center justify-center mr-3 flex-shrink-0">
                    <svg className="w-3.5 h-3.5 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                    </svg>
                </div>
            );
        }

        // Senior
        return (
            <div className="w-8 h-8 rounded-full bg-emerald-100 flex items-center justify-center mr-4 flex-shrink-0">
                <span className="text-emerald-600 text-lg font-bold">✓</span>
            </div>
        );
    };

    return (
        <section className={`section py-20 ${cfg.bgClass} overflow-hidden`}>
            <div className="container mx-auto px-4">
                <div className={`flex flex-col ${cfg.reverse ? 'md:flex-row-reverse' : 'md:flex-row'} items-center gap-10 md:gap-16`}>

                    {/* Text Column */}
                    <div className="flex-1 min-w-[300px]">
                        <h2 className={`text-3xl md:text-4xl font-bold mb-6 uppercase tracking-wide ${cfg.textClass} ${cfg.headingShadow}`}>
                            {cfg.title}
                        </h2>
                        <p className={`mb-8 text-lg leading-relaxed ${variant === 'youth' ? 'text-gray-300' : 'text-gray-600'}`}>
                            {cfg.description}
                        </p>
                        <ul className="space-y-4">
                            {cfg.features.map((feature, idx) => (
                                <li key={idx} className={`flex items-center ${variant === 'youth' ? 'text-gray-300' : 'text-gray-700 text-lg'}`}>
                                    {renderIcon(cfg.listIcon)}
                                    {feature}
                                </li>
                            ))}
                        </ul>
                    </div>

                    {/* Image Column */}
                    <div className="flex-1 w-full min-w-[300px] flex justify-center">
                        <div className={`relative rounded-2xl overflow-hidden border-2 ${cfg.borderClass} ${cfg.shadowClass} transform hover:scale-[1.02] transition-transform duration-500 max-w-[85%] md:max-w-[400px] mx-auto`}>
                            <img
                                src={`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/landing/assets/classifica.png`}
                                alt="Leaderboard Preview"
                                className="w-full h-auto block"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </section>
    );
};

export default LeaderboardSection;
