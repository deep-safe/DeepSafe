'use client';

import React from 'react';
import {
    LineChart,
    Line,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer,
    RadarChart,
    PolarGrid,
    PolarAngleAxis,
    PolarRadiusAxis,
    Radar,
    PieChart,
    Pie,
    Cell
} from 'recharts';

// --- Theme Colors ---
const COLORS = {
    cyan: '#06b6d4', // cyan-500
    purple: '#a855f7', // purple-500
    amber: '#f59e0b', // amber-500
    emerald: '#10b981', // emerald-500
    slate: '#64748b', // slate-500
    grid: '#334155', // slate-700 (opacity usually lower)
};

// --- Custom Tooltip ---
const CustomTooltip = ({ active, payload, label }: any) => {
    if (active && payload && payload.length) {
        return (
            <div className="bg-slate-900/90 border border-slate-700 p-3 rounded-lg shadow-xl backdrop-blur-md">
                <p className="text-slate-300 text-xs font-mono mb-1">{label}</p>
                {payload.map((entry: any, index: number) => (
                    <p key={index} className="text-sm font-bold font-orbitron" style={{ color: entry.color }}>
                        {entry.name}: {entry.value}
                    </p>
                ))}
            </div>
        );
    }
    return null;
};

// --- XP Trend Chart ---
export const XPTrendChart = ({ data }: { data: any[] }) => {
    return (
        <ResponsiveContainer width="100%" height={300}>
            <LineChart data={data} margin={{ top: 5, right: 20, bottom: 5, left: 0 }}>
                <CartesianGrid strokeDasharray="3 3" stroke={COLORS.grid} opacity={0.2} />
                <XAxis
                    dataKey="date"
                    stroke={COLORS.slate}
                    fontSize={10}
                    tickLine={false}
                    axisLine={false}
                />
                <YAxis
                    stroke={COLORS.slate}
                    fontSize={10}
                    tickLine={false}
                    axisLine={false}
                />
                <Tooltip content={<CustomTooltip />} cursor={{ stroke: COLORS.cyan, strokeWidth: 1, strokeDasharray: '5 5' }} />
                <Line
                    type="monotone"
                    dataKey="xp"
                    name="XP"
                    stroke={COLORS.cyan}
                    strokeWidth={3}
                    dot={{ r: 4, fill: '#000', stroke: COLORS.cyan, strokeWidth: 2 }}
                    activeDot={{ r: 6, fill: COLORS.cyan }}
                />
            </LineChart>
        </ResponsiveContainer>
    );
};

// --- Skills Radar Chart ---
export const SkillsRadarChart = ({ data }: { data: any[] }) => {
    return (
        <ResponsiveContainer width="100%" height={300}>
            <RadarChart cx="50%" cy="50%" outerRadius="70%" data={data}>
                <PolarGrid stroke={COLORS.grid} opacity={0.4} />
                <PolarAngleAxis
                    dataKey="subject"
                    tick={{ fill: COLORS.slate, fontSize: 10, fontFamily: 'monospace' }}
                />
                <PolarRadiusAxis angle={30} domain={[0, 100]} tick={false} axisLine={false} />
                <Radar
                    name="Skills"
                    dataKey="A"
                    stroke={COLORS.purple}
                    strokeWidth={2}
                    fill={COLORS.purple}
                    fillOpacity={0.3}
                />
                <Tooltip content={<CustomTooltip />} />
            </RadarChart>
        </ResponsiveContainer>
    );
};

// --- Mission Distribution Pie Chart ---
const PIE_COLORS = [COLORS.cyan, COLORS.purple, COLORS.amber, COLORS.emerald];

export const MissionPieChart = ({ data }: { data: any[] }) => {
    return (
        <ResponsiveContainer width="100%" height={300}>
            <PieChart>
                <Pie
                    data={data}
                    cx="50%"
                    cy="50%"
                    innerRadius={60}
                    outerRadius={80}
                    paddingAngle={5}
                    dataKey="value"
                    stroke="none"
                >
                    {data.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={PIE_COLORS[index % PIE_COLORS.length]} />
                    ))}
                </Pie>
                <Tooltip content={<CustomTooltip />} />
            </PieChart>
        </ResponsiveContainer>
    );
};
