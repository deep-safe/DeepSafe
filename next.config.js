const withPWA = require('next-pwa')({
    dest: 'public',
    register: true,
    skipWaiting: true,
    disable: process.env.NODE_ENV === 'development',
    importScripts: ['/custom-sw.js'],
});

/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'export',
    reactCompiler: true,
    // Silence Turbopack error when using webpack plugins (like next-pwa)
    turbopack: {},
    images: {
        unoptimized: true, // Required for static export
    },
};

module.exports = withPWA(nextConfig);
