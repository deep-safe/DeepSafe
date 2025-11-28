
import * as fs from 'fs';
import * as path from 'path';

const provincesPath = path.join(process.cwd(), 'src/data/provincesData.ts');
const badgesPath = path.join(process.cwd(), 'supabase/migrations/20241128_seed_region_badges.sql');

const provincesContent = fs.readFileSync(provincesPath, 'utf8');
const badgesContent = fs.readFileSync(badgesPath, 'utf8');

// Extract regions from provincesData.ts
// Looking for: "region": "Name",
const provinceRegions = new Set<string>();
const regionRegex = /"region":\s*"([^"]+)"/g;
let match;
while ((match = regionRegex.exec(provincesContent)) !== null) {
    provinceRegions.add(match[1]);
}

// Extract regions from badges sql
// Looking for: 'region_master', 'Name'
// The SQL format is: 'region_master', 'Name'
const badgeRegions = new Set<string>();
const badgeRegex = /'region_master',\s*'((?:''|[^'])*)'/g;
while ((match = badgeRegex.exec(badgesContent)) !== null) {
    // Unescape SQL quotes ('' -> ')
    badgeRegions.add(match[1].replace(/''/g, "'"));
}

console.log('--- Comparison ---');
console.log(`Found ${provinceRegions.size} unique regions in provincesData.ts`);
console.log(`Found ${badgeRegions.size} unique regions in badges SQL`);

const sortedProvinceRegions = Array.from(provinceRegions).sort();
const sortedBadgeRegions = Array.from(badgeRegions).sort();

console.log('\n--- Mismatches ---');
let hasMismatch = false;

// Check if every province region exists in badges
for (const region of sortedProvinceRegions) {
    if (!badgeRegions.has(region)) {
        console.log(`[MISSING IN BADGES] Province region: "${region}"`);
        // Find closest match?
        const closest = sortedBadgeRegions.find(r => r.includes(region) || region.includes(r));
        if (closest) console.log(`  -> Did you mean: "${closest}"?`);
        hasMismatch = true;
    }
}

// Check if every badge region exists in provinces
for (const region of sortedBadgeRegions) {
    if (!provinceRegions.has(region)) {
        console.log(`[MISSING IN PROVINCES] Badge region: "${region}"`);
        hasMismatch = true;
    }
}

if (!hasMismatch) {
    console.log('SUCCESS: All regions match perfectly!');
}
