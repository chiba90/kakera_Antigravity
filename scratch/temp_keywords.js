const https = require('https');
const fs = require('fs');

async function fetchSuggest(query) {
    return new Promise((resolve) => {
        // ie=utf-8 and oe=utf-8 forced to get clean UTF-8 XML response
        const url = `https://google.com/complete/search?output=toolbar&hl=ja&ie=utf-8&oe=utf-8&q=${encodeURIComponent(query)}`;
        https.get(url, (res) => {
            let chunks = [];
            res.on('data', chunk => chunks.push(chunk));
            res.on('end', () => {
                const buffer = Buffer.concat(chunks);
                const data = buffer.toString('utf8');
                const keywords = [];
                const regex = /data="([^"]+)"/g;
                let match;
                while ((match = regex.exec(data)) !== null) {
                    keywords.push(match[1]);
                }
                resolve(keywords);
            });
        });
    });
}

async function run() {
    const seeds = ['首里城 復元', '首里城 宮大工', '宮大工 伝統技術', '木造復元 職人', '首里城 2026'];
    console.log('Scraping suggests for multiple seeds...');
    const resultSet = new Set();
    
    for (const seed of seeds) {
        const queue = [seed];
        const localSet = new Set();
        while (queue.length > 0 && localSet.size < 30) {
            const currentQuery = queue.shift();
            try {
                const results = await fetchSuggest(currentQuery);
                for (const res of results) {
                    if (!resultSet.has(res)) {
                        resultSet.add(res);
                        localSet.add(res);
                        if (res !== currentQuery && queue.length < 30) {
                            queue.push(res);
                        }
                    }
                }
            } catch (e) {
                console.error(e);
            }
            await new Promise(r => setTimeout(r, 100));
        }
    }
    
    const finalKeywords = Array.from(resultSet);
    fs.mkdirSync('scratch', { recursive: true });
    fs.writeFileSync('scratch/suggest_keywords.txt', finalKeywords.join('\n'), 'utf8');
    console.log('Saved ' + finalKeywords.length + ' keywords to scratch/suggest_keywords.txt');
}
run();
