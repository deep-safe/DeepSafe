'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Home, Map, Trophy, ShoppingBag, User } from 'lucide-react';
import { cn } from '@/lib/utils';

const navItems = [
    { href: '/learn', icon: Map, label: 'Learn' },
    { href: '/leaderboard', icon: Trophy, label: 'Rank' },
    { href: '/', icon: Home, label: 'Home' }, // Dashboard
    { href: '/shop', icon: ShoppingBag, label: 'Shop' },
    { href: '/profile', icon: User, label: 'Profile' },
];

export function BottomNav() {
    const pathname = usePathname();

    return (
        <nav className="fixed bottom-0 left-0 right-0 border-t bg-white dark:bg-zinc-950 border-zinc-200 dark:border-zinc-800 pb-safe">
            <div className="flex justify-around items-center h-16 max-w-md mx-auto">
                {navItems.map(({ href, icon: Icon, label }) => {
                    const isActive = pathname === href;
                    return (
                        <Link
                            key={href}
                            href={href}
                            className={cn(
                                "flex flex-col items-center justify-center w-full h-full space-y-1",
                                isActive
                                    ? "text-blue-600 dark:text-blue-400"
                                    : "text-zinc-500 hover:text-zinc-900 dark:text-zinc-400 dark:hover:text-zinc-100"
                            )}
                        >
                            <Icon className={cn("w-6 h-6", isActive && "fill-current")} />
                            <span className="text-[10px] font-medium uppercase tracking-wide">{label}</span>
                        </Link>
                    );
                })}
            </div>
        </nav>
    );
}
