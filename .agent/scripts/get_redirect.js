const https = require('https');
const url = process.argv[2];
https.get(url, (res) => {
  if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
    console.log(res.headers.location);
  } else {
    let data = '';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
      const match = data.match(/URL='([^']+)'/);
      if (match) console.log(match[1]);
      else console.log(data.match(/<a href="([^"]+)">/)?.[1] || "No redirect found");
    });
  }
});
