import React, { useState, useEffect } from 'react';

interface CountdownProps {
    targetDate: string;
}

const Countdown: React.FC<CountdownProps> = ({ targetDate }) => {
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

    return (
        <div className="flex flex-wrap justify-center gap-8 md:gap-16 py-4 animate-fade-in-up w-full">
            <div className="countdown-item relative flex flex-col items-center group">
                {/* Tech Accents (Corners) */}
                <div className="absolute -top-2 -left-2 w-3 h-3 border-t-2 border-l-2 border-[#00f3ff] rounded-tl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -top-2 -right-2 w-3 h-3 border-t-2 border-r-2 border-[#00f3ff] rounded-tr opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -left-2 w-3 h-3 border-b-2 border-l-2 border-[#00f3ff] rounded-bl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -right-2 w-3 h-3 border-b-2 border-r-2 border-[#00f3ff] rounded-br opacity-60 group-hover:opacity-100 transition-opacity"></div>

                <div className="relative bg-black/20 backdrop-blur-md px-6 py-5 rounded-lg border border-[#00f3ff]/10">
                    <span className="text-5xl md:text-7xl font-bold font-['Orbitron'] text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.6)] tabular-nums tracking-wider">
                        {days < 10 ? `0${days}` : days}
                    </span>
                </div>
                <span className="text-xs md:text-sm uppercase tracking-[0.3em] text-[#00f3ff] mt-4 font-['Outfit'] font-semibold opacity-80">Giorni</span>
            </div>

            <div className="countdown-item relative flex flex-col items-center group">
                {/* Tech Accents (Corners) */}
                <div className="absolute -top-2 -left-2 w-3 h-3 border-t-2 border-l-2 border-[#00f3ff] rounded-tl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -top-2 -right-2 w-3 h-3 border-t-2 border-r-2 border-[#00f3ff] rounded-tr opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -left-2 w-3 h-3 border-b-2 border-l-2 border-[#00f3ff] rounded-bl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -right-2 w-3 h-3 border-b-2 border-r-2 border-[#00f3ff] rounded-br opacity-60 group-hover:opacity-100 transition-opacity"></div>

                <div className="relative bg-black/20 backdrop-blur-md px-6 py-5 rounded-lg border border-[#00f3ff]/10">
                    <span className="text-5xl md:text-7xl font-bold font-['Orbitron'] text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.6)] tabular-nums tracking-wider">
                        {hours < 10 ? `0${hours}` : hours}
                    </span>
                </div>
                <span className="text-xs md:text-sm uppercase tracking-[0.3em] text-[#00f3ff] mt-4 font-['Outfit'] font-semibold opacity-80">Ore</span>
            </div>

            <div className="countdown-item relative flex flex-col items-center group">
                {/* Tech Accents (Corners) */}
                <div className="absolute -top-2 -left-2 w-3 h-3 border-t-2 border-l-2 border-[#00f3ff] rounded-tl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -top-2 -right-2 w-3 h-3 border-t-2 border-r-2 border-[#00f3ff] rounded-tr opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -left-2 w-3 h-3 border-b-2 border-l-2 border-[#00f3ff] rounded-bl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -right-2 w-3 h-3 border-b-2 border-r-2 border-[#00f3ff] rounded-br opacity-60 group-hover:opacity-100 transition-opacity"></div>

                <div className="relative bg-black/20 backdrop-blur-md px-6 py-5 rounded-lg border border-[#00f3ff]/10">
                    <span className="text-5xl md:text-7xl font-bold font-['Orbitron'] text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.6)] tabular-nums tracking-wider">
                        {minutes < 10 ? `0${minutes}` : minutes}
                    </span>
                </div>
                <span className="text-xs md:text-sm uppercase tracking-[0.3em] text-[#00f3ff] mt-4 font-['Outfit'] font-semibold opacity-80">Minuti</span>
            </div>

            <div className="countdown-item relative flex flex-col items-center group">
                {/* Tech Accents (Corners) */}
                <div className="absolute -top-2 -left-2 w-3 h-3 border-t-2 border-l-2 border-[#00f3ff] rounded-tl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -top-2 -right-2 w-3 h-3 border-t-2 border-r-2 border-[#00f3ff] rounded-tr opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -left-2 w-3 h-3 border-b-2 border-l-2 border-[#00f3ff] rounded-bl opacity-60 group-hover:opacity-100 transition-opacity"></div>
                <div className="absolute -bottom-2 -right-2 w-3 h-3 border-b-2 border-r-2 border-[#00f3ff] rounded-br opacity-60 group-hover:opacity-100 transition-opacity"></div>

                <div className="relative bg-black/20 backdrop-blur-md px-6 py-5 rounded-lg border border-[#00f3ff]/10">
                    <span className="text-5xl md:text-7xl font-bold font-['Orbitron'] text-white drop-shadow-[0_0_15px_rgba(0,243,255,0.6)] tabular-nums tracking-wider text-[#00f3ff]">
                        {seconds < 10 ? `0${seconds}` : seconds}
                    </span>
                </div>
                <span className="text-xs md:text-sm uppercase tracking-[0.3em] text-[#00f3ff] mt-4 font-['Outfit'] font-semibold opacity-80">Secondi</span>
            </div>
        </div>
    );
};

export default Countdown;
