const https = require('https');
const urls = [
  "https://news.google.com/rss/articles/CBMibEFVX3lxTFBTWlZOcmw4cmNZc0kwb3VYa2lOV2Fud21scmE3V0RKRzQtYjVVcm9Oek9kNEtCX3R5NVBtNnp4OG83NFp6cUVuY3NhMTA0VHhlUVQ0WHpob1UwNmk3cmxkdHpvNGozckViWkRENQ",
  "https://news.google.com/rss/articles/CBMigwFBVV95cUxNVThFaUhISnVFdG5TTVRMQWdpa21aRkRmc0xHUFRfa0RIRFhwcnByVEVGeDIzX2xZVkJpbmtxcTh6dkQ2U0I3S2c3RTlWemhNeEQ5VXJsXzVQZ0JUUGRGWHBvV09IRk9BaGtXVDVHVUZ1dUFOVk9raGludTRlaUJwOWRWQQ",
  "https://news.google.com/rss/articles/CBMiZEFVX3lxTE5tNnBhWndWMDJYRFQ5X3dBaFZqNnYyTEpzREJVUjJmTjNJUDVOYjJPbmZPT3FwUDVKVlNXTFRPZU83MVM2R3V5bERBbVA5b091ZWl1ZzlYbnB5Y1N6S05XQ2FQbHg"
];

urls.forEach(url => {
  https.get(url, {
    headers: {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
    }
  }, (res) => {
    console.log(url, "Status:", res.statusCode);
  });
});
