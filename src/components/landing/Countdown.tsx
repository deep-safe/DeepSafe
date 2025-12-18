import React, { useState, useEffect } from 'react';

interface CountdownProps {
    targetDate: string;
    variant?: 'cyberpunk' | 'senior' | 'adult';
}

const Countdown: React.FC<CountdownProps> = ({ targetDate, variant = 'cyberpunk' }) => {
    const calculateTimeLeft = () => {
        const difference = +new Date(targetDate) - +new Date();
        let timeLeft = {
            days: 0,
            hours: 0,
            minutes: 0,
            seconds: 0
        };

        if (difference > 0) {
            timeLeft = {
                days: Math.floor(difference / (1000 * 60 * 60 * 24)),
                hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
                minutes: Math.floor((difference / 1000 / 60) % 60),
                seconds: Math.floor((difference / 1000) % 60)
            };
        }

        return timeLeft;
    };

    const [timeLeft, setTimeLeft] = useState(calculateTimeLeft());
    const [mounted, setMounted] = useState(false);

    useEffect(() => {
        setMounted(true);
        const timer = setInterval(() => {
            setTimeLeft(calculateTimeLeft());
        }, 1000);

        return () => clearInterval(timer);
    }, [targetDate]);

    if (!mounted) {
        return null; // Avoid hydration mismatch
    }

    const { days, hours, minutes, seconds } = timeLeft;

    // Theme Configurations
    const themes = {
        cyberpunk: {
            container: "",
            card: "bg-black/20 backdrop-blur-md border border-[#00f3ff]/10",
            number: "text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.6)]",
            label: "text-[#00f3ff] opacity-80",
            accent: "border-[#00f3ff]",
            cornerOpacity: "opacity-60",
        },
        senior: {
            container: "",
            card: "bg-white shadow-lg border border-emerald-100",
            number: "text-emerald-700", // Darker for readability on white
            label: "text-emerald-600 font-bold tracking-widest",
            accent: "border-emerald-400",
            cornerOpacity: "opacity-40",
        },
        adult: {
            container: "",
            card: "bg-white shadow-lg border border-indigo-100",
            number: "text-indigo-700",
            label: "text-indigo-600 font-bold tracking-widest",
            accent: "border-indigo-400",
            cornerOpacity: "opacity-40",
        }
    };

    const theme = themes[variant];

    return (
        <div className="flex flex-wrap justify-center gap-8 md:gap-16 py-4 animate-fade-in-up w-full">
            {[
                { value: days, label: 'Giorni' },
                { value: hours, label: 'Ore' },
                { value: minutes, label: 'Minuti' },
                { value: seconds, label: 'Secondi' }
            ].map((item, index) => (
                <div key={index} className="countdown-item relative flex flex-col items-center group">
                    {/* Tech Accents (Corners) */}
                    <div className={`absolute -top-2 -left-2 w-3 h-3 border-t-2 border-l-2 ${theme.accent} rounded-tl ${theme.cornerOpacity} group-hover:opacity-100 transition-opacity`}></div>
                    <div className={`absolute -top-2 -right-2 w-3 h-3 border-t-2 border-r-2 ${theme.accent} rounded-tr ${theme.cornerOpacity} group-hover:opacity-100 transition-opacity`}></div>
                    <div className={`absolute -bottom-2 -left-2 w-3 h-3 border-b-2 border-l-2 ${theme.accent} rounded-bl ${theme.cornerOpacity} group-hover:opacity-100 transition-opacity`}></div>
                    <div className={`absolute -bottom-2 -right-2 w-3 h-3 border-b-2 border-r-2 ${theme.accent} rounded-br ${theme.cornerOpacity} group-hover:opacity-100 transition-opacity`}></div>

                    <div className={`relative px-6 py-5 rounded-lg ${theme.card} min-w-[120px] flex justify-center`}>
                        <span className={`text-5xl md:text-7xl font-bold font-['Orbitron'] tabular-nums tracking-wider ${theme.number}`}>
                            {item.value < 10 ? `0${item.value}` : item.value}
                        </span>
                    </div>
                    <span className={`text-xs md:text-sm uppercase mt-4 font-['Outfit'] ${theme.label}`}>
                        {item.label}
                    </span>
                </div>
            ))}
        </div>
    );
};

export default Countdown;
