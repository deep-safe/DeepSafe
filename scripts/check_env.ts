
import fs from 'fs';
import path from 'path';

const envPath = path.resolve(process.cwd(), '.env.local');
try {
    const envConfig = fs.readFileSync(envPath, 'utf8');
    if (envConfig.includes('DATABASE_URL=')) {
        console.log('DATABASE_URL found');
    } else {
        console.log('DATABASE_URL NOT found');
    }
} catch (e) {
    console.log('Error reading .env.local');
}
