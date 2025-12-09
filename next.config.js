const withPWA = require('next-pwa')({
    dest: 'public',
    register: true,
    skipWaiting: true,
    disable: process.env.NODE_ENV === 'development',
    importScripts: [`${process.env.NEXT_PUBLIC_BASE_PATH || ''}/custom-sw.js`],
});

/** @type {import('next').NextConfig} */
const nextConfig = {
    output: 'export',
    basePath: process.env.NEXT_PUBLIC_BASE_PATH || '',
    reactCompiler: true,
    // Silence Turbopack error when using webpack plugins (like next-pwa)
    turbopack: {},
    images: {
        unoptimized: true, // Required for static export
    },
};

module.exports = withPWA(nextConfig);
