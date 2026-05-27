const https = require('https');
const fs = require('fs');

const seeds = [
  "スズタケ 開花",
  "スズタケ 枯死",
  "竹細工 材料 不足",
  "戸隠竹細工 スズタケ",
  "別府竹細工 スズタケ",
  "竹細工 スズタケ 枯死",
  "伝統工芸 原材料 不足",
  "伝統工芸 存続 危機",
  "工芸 素材 枯渇",
  "手仕事 自然 影響",
  "伝統工芸 後継者",
  "伝統工芸 衰退 原因",
  "手仕事 価値 現代",
  "日本の伝統工芸 課題"
];
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
            console.error("Error fetching for seed: " + seed, e.message);
        }
    }
    
    const finalKeywords = Array.from(resultSet);
    console.log(JSON.stringify(finalKeywords, null, 2));
}

run();
