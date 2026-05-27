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

function parseGoogleNewsRSS(xmlData, sourceLabel, maxItems = 3) {
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

function parsePRTimes(html, maxItems = 2) {
  const items = [];
  // Try matching PR Times list item titles and links
  const regex = /<a[^>]*href="([^"]*\/main\/html\/rd\/p\/[^"]*)"[^>]*>([\s\S]*?)<\/a>/g;
  let match;
  while ((match = regex.exec(html)) !== null && items.length < maxItems) {
    let link = match[1];
    if (!link.startsWith('http')) {
      link = 'https://prtimes.jp' + link;
    }
    const title = match[2].replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim();
    if (title && !items.some(item => item.url === link)) {
      items.push({
        source: 'PR TIMES',
        title: title,
        url: link,
        date: new Date().toUTCString()
      });
    }
  }
  return items;
}

async function fetchAllNews() {
  console.log("=== Kakera Curation News Search ===\n");

  // 1. 文化庁・文化財 (Agency for Cultural Affairs / Cultural Properties)
  const bunkaUrl = 'https://news.google.com/rss/search?q=%E6%96%87%E5%8C%96%E5%BA%81+OR+%E6%96%87%E5%8C%96%E8%B2%A1&hl=ja&gl=JP&ceid=JP:ja';
  try {
    const bunkaXml = await getRequest(bunkaUrl);
    const bunkaNews = parseGoogleNewsRSS(bunkaXml, "文化庁・文化財", 3);
    console.log("【公的機関・文化庁関連ニュース】");
    bunkaNews.forEach(item => {
        console.log(`Title: ${item.title}\nURL: ${item.url}\nDate: ${item.date}\nSource: ${item.source}\n`);
    });
  } catch (e) {
    console.error("Failed to fetch Cultural Affairs news:", e.message);
  }

  // 2. 伝統工芸（一般報道） (Traditional Crafts - General Media)
  const dentoUrl = 'https://news.google.com/rss/search?q=%E4%BC%9D%E7%B5%B1%E5%B7%A5%E8%8A%B8+-PRTIMES&hl=ja&gl=JP&ceid=JP:ja';
  try {
    const dentoXml = await getRequest(dentoUrl);
    const dentoNews = parseGoogleNewsRSS(dentoXml, "一般報道", 3);
    console.log("【ジャーナリズム・一般報道ニュース】");
    dentoNews.forEach(item => {
        console.log(`Title: ${item.title}\nURL: ${item.url}\nDate: ${item.date}\nSource: ${item.source}\n`);
    });
  } catch (e) {
    console.error("Failed to fetch General Media news:", e.message);
  }

  // 3. PR TIMES (Corporate Press Releases - Keep limited)
  const prUrl = 'https://prtimes.jp/main/action.php?run=html&page=searchkey&search_word=%E4%BC%9D%E7%B5%B1%E5%B7%A5%E8%8A%B8&search_pref=&search_period=all';
  try {
    const prHtml = await getRequest(prUrl);
    const prNews = parsePRTimes(prHtml, 2);
    console.log("【企業動向・展示会 (PR TIMES)】");
    prNews.forEach(item => {
        console.log(`Title: ${item.title}\nURL: ${item.url}\nDate: ${item.date}\nSource: ${item.source}\n`);
    });
  } catch (e) {
    console.error("Failed to fetch PR TIMES news:", e.message);
  }
}

fetchAllNews();
