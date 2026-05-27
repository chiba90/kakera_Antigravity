import urllib.request
import urllib.parse
import re

queries = [
    "GO FOR KOGEI 2025 開催 prtimes",
    "KOGEI Art Fair Kanazawa 2025 prtimes",
    "伝統万博2025 prtimes"
]

def search(q):
    url = 'https://html.duckduckgo.com/html/?q=' + urllib.parse.quote(q)
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        html = urllib.request.urlopen(req).read().decode('utf-8')
        links = re.findall(r'href=[\'"](https?://[^\'"]+)[\'"]', html)
        return [urllib.parse.unquote(l[l.find('uddg=')+5:]) if 'uddg=' in l else l for l in links if ('prtimes.jp' in l or 'artnews' in l or 'bijutsutecho.com' in l)][:5]
    except Exception as e:
        return []

for q in queries:
    print(f"{q}: {search(q)}")
