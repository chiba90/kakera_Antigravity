const https = require('https');

const userSeed = process.argv[2];
const seeds = userSeed ? [userSeed] : ["春日大社 鹿", "細見美術館", "九州国立博物館", "金銅", "金工", "御正体", "室町時代 美術", "鋳造", "エイジング 経年変化", "仏教美術"];
const maxKeywords = 100;

function fetchSuggest(query) {
    return new Promise((resolve, reject) => {
        const url = `https://google.com/complete/search?output=toolbar&hl=ja&q=${encodeURIComponent(query)}`;
        const req = https.get(url, {
            headers: {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
            }
        }, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                const keywords = [];
                const regex = /data="([^"]+)"/g;
                let match;
                while ((match = regex.exec(data)) !== null) {
                    keywords.push(match[1]);
                }
                resolve(keywords);
            });
        });
        req.on('error', reject);
    });
}

async function run() {
    const resultSet = new Set();
    
    for (const seed of seeds) {
        if (resultSet.size >= maxKeywords) break;
        try {
            const results = await fetchSuggest(seed);
            for (const res of results) {
                resultSet.add(res);
                if (resultSet.size >= maxKeywords) break;
            }
            // Fetch combinations
            const results2 = await fetchSuggest(seed + " ");
            for (const res of results2) {
                resultSet.add(res);
                if (resultSet.size >= maxKeywords) break;
            }
        } catch (e) {
            console.error(e);
        }
    }
    
    const finalKeywords = Array.from(resultSet);
    console.log(finalKeywords.join('\n'));
}

run();
