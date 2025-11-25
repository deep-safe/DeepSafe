const fs = require('fs');
const https = require('https');
const d3 = require('d3-geo');

const GEOJSON_URL = 'https://raw.githubusercontent.com/openpolis/geojson-italy/master/geojson/limits_IT_provinces.geojson';
const OUTPUT_FILE = 'src/data/provincesData.ts';
const WIDTH = 800;
const HEIGHT = 1000;

function fetchGeoJSON(url) {
    return new Promise((resolve, reject) => {
        https.get(url, (res) => {
            let data = '';
            res.on('data', (chunk) => data += chunk);
            res.on('end', () => resolve(JSON.parse(data)));
            res.on('error', reject);
        });
    });
}

async function generate() {
    console.log('Fetching GeoJSON...');
    const geojson = await fetchGeoJSON(GEOJSON_URL);

    console.log('Processing features...');
    const projection = d3.geoMercator()
        .fitSize([WIDTH, HEIGHT], geojson);

    const pathGenerator = d3.geoPath().projection(projection);

    const provinces = geojson.features.map(feature => {
        const props = feature.properties;
        // Adjust property names based on the GeoJSON structure
        // Usually: prov_acr (ID), prov_name (Name), reg_name (Region)
        // Let's inspect the first feature properties if possible, but standard openpolis data usually has these.
        // Based on openpolis/geojson-italy documentation/common usage:
        // prov_acr: "TO"
        // prov_name: "Torino"
        // reg_name: "Piemonte"

        return {
            id: props.prov_acr || props.SIGLA || 'UNKNOWN',
            name: props.prov_name || props.DEN_PROV || 'Unknown',
            region: props.reg_name || props.DEN_REG || 'Unknown',
            status: (props.prov_acr === 'CB' || props.prov_acr === 'IS') ? 'unlocked' : 'locked', // Default Molise unlocked
            progress: 0,
            path: pathGenerator(feature)
        };
    });

    const fileContent = `export type ProvinceStatus = 'locked' | 'unlocked' | 'safe';

export interface Province {
  id: string;
  name: string;
  region: string;
  status: ProvinceStatus;
  progress: number;
  path: string;
}

export const provincesData: Province[] = ${JSON.stringify(provinces, null, 2)};
`;

    fs.writeFileSync(OUTPUT_FILE, fileContent);
    console.log(`Generated ${provinces.length} provinces in ${OUTPUT_FILE}`);
}

generate().catch(console.error);
