import https from 'https';

function getRequest(url) {
  return new Promise((resolve, reject) => {
    https.get(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
      }
    }, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', err => reject(err));
  });
}

function parseGoogleNewsRSS(xmlData, sourceLabel, maxItems = 5) {
  const items = [];
  const itemRegex = /<item>([\s\S]*?)<\/item>/g;
  let match;
  while ((match = itemRegex.exec(xmlData)) !== null && items.length < maxItems) {
    const itemBlock = match[1];
    const titleMatch = itemBlock.match(/<title>([\s\S]*?)<\/title>/);
    const linkMatch = itemBlock.match(/<link>([\s\S]*?)<\/link>/);
    const dateMatch = itemBlock.match(/<pubDate>([\s\S]*?)<\/pubDate>/);
    
    if (titleMatch && linkMatch) {
      let title = titleMatch[1].replace(/<!\[CDATA\[|\]\]>/g, '').trim();
      let link = linkMatch[1].trim();
      let pubDate = dateMatch ? dateMatch[1].trim() : 'Unknown Date';
      
      items.push({
        source: sourceLabel,
        title: title,
        url: link,
        date: pubDate
      });
    }
  }
  return items;
}

async function fetchLatestTVNews() {
  console.log("=== Kakera Curation LATEST (24h/48h) TV News Search ===\n");
  
  // 直近1日〜2日のGoogle News検索 (when:2d)
  // クエリ: (伝統工芸 OR 文化財 OR 伝統芸能) AND (テレビ OR 番組 OR 放送 OR 放映 OR 密着 OR 紹介) when:2d
  const query = encodeURIComponent("(伝統工芸 OR 文化財 OR 伝統芸能) AND (テレビ OR 番組 OR 放送 OR 放映 OR 密着 OR 紹介) when:2d");
  const url = `https://news.google.com/rss/search?q=${query}&hl=ja&gl=JP&ceid=JP:ja`;
  
  try {
    const xml = await getRequest(url);
    const news = parseGoogleNewsRSS(xml, "直近テレビ", 8);
    console.log("【直近2日以内のテレビ・放送関連ニュース】");
    news.forEach(item => {
        console.log(`Title: ${item.title}\nURL: ${item.url}\nDate: ${item.date}\n`);
    });
  } catch (e) {
    console.error("Failed to fetch latest TV news:", e.message);
  }
}

fetchLatestTVNews();
