
/**
 * Simple utility to calculate the bounding box of an SVG path.
 * Assumes the path consists of commands followed by coordinates.
 * This is a heuristic approach and might not cover all SVG path features (like relative commands 'l', 'h', 'v' if not handled carefully),
 * but should work for standard absolute paths exported from tools.
 */

interface BoundingBox {
    minX: number;
    minY: number;
    maxX: number;
    maxY: number;
    width: number;
    height: number;
    centerX: number;
    centerY: number;
}

export const getPathBoundingBox = (path: string): BoundingBox | null => {
    // Extract all numbers from the path string
    const matches = path.match(/[-+]?[0-9]*\.?[0-9]+/g);

    if (!matches || matches.length < 2) {
        return null;
    }

    const numbers = matches.map(Number);
    const xCoords: number[] = [];
    const yCoords: number[] = [];

    // Assume pairs of X, Y
    for (let i = 0; i < numbers.length; i += 2) {
        if (i + 1 < numbers.length) {
            xCoords.push(numbers[i]);
            yCoords.push(numbers[i + 1]);
        }
    }

    if (xCoords.length === 0 || yCoords.length === 0) {
        return null;
    }

    const minX = Math.min(...xCoords);
    const maxX = Math.max(...xCoords);
    const minY = Math.min(...yCoords);
    const maxY = Math.max(...yCoords);

    return {
        minX,
        minY,
        maxX,
        maxY,
        width: maxX - minX,
        height: maxY - minY,
        centerX: (minX + maxX) / 2,
        centerY: (minY + maxY) / 2,
    };
};

export const getRegionBoundingBox = (paths: string[]): BoundingBox | null => {
    let minX = Infinity;
    let minY = Infinity;
    let maxX = -Infinity;
    let maxY = -Infinity;
    let hasValidPath = false;

    paths.forEach(path => {
        const bbox = getPathBoundingBox(path);
        if (bbox) {
            hasValidPath = true;
            minX = Math.min(minX, bbox.minX);
            minY = Math.min(minY, bbox.minY);
            maxX = Math.max(maxX, bbox.maxX);
            maxY = Math.max(maxY, bbox.maxY);
        }
    });

    if (!hasValidPath) return null;

    return {
        minX,
        minY,
        maxX,
        maxY,
        width: maxX - minX,
        height: maxY - minY,
        centerX: (minX + maxX) / 2,
        centerY: (minY + maxY) / 2,
    };
};
