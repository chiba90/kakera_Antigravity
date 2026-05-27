import re

input_path = r"c:\Users\hchiba\Dropbox\$_個人的なやーつ\Kakera\kakera_Antigravity\03_CCO_Content_Creative\drafts\shurijo_miyadaiku_full.html"
output_path = r"c:\Users\hchiba\Dropbox\$_個人的なやーつ\Kakera\kakera_Antigravity\03_CCO_Content_Creative\drafts\shurijo_miyadaiku_full.html"

with open(input_path, "r", encoding="utf-8") as f:
    html = f.read()

# 1. Blockquote 内の cite に含まれる エムダッシュ 「— 」 の置換
# 例: <cite style="display: block; margin-top: 1em; font-size: 0.85em; color: #777;">— 令和首里城正殿復興プロジェクト 棟梁の言葉より</cite>
html = re.sub(
    r'<cite([^>]*)>\s*(?:—|──|―)\s*(.*?)\s*</cite>',
    r'<cite\1>（\2）</cite>',
    html
)

# 2. 本文中の <p> タグの調整
def refactor_p_tag(match):
    attrs = match.group(1) or ""
    content = match.group(2)
    
    # すべてのダッシュ記号 (—, ──, ―) を日本語表現に置換または削除
    content = content.replace("──", "、").replace("—", "").replace("―", "")
    
    # <br> で分割
    parts = re.split(r'\s*<br\s*/?>\s*', content)
    
    new_paragraphs = []
    for part in parts:
        part = part.strip()
        if not part:
            continue
        
        # 句点「。」で文を分割し、1〜2文ごとに新しい <p> を作る
        # リンク <a> などのタグが含まれている可能性を考慮し、安全に分割する
        # ここでは単純に「。」の後に文が続く場合に分割を試みる
        sentences = re.split(r'(?<=。)', part)
        
        current_p_text = ""
        sentence_count = 0
        
        for sentence in sentences:
            if not sentence.strip():
                continue
            current_p_text += sentence
            sentence_count += 1
            
            # 2文に達した、あるいは文字数が120文字を超えた場合に分割
            if sentence_count >= 2 or len(current_p_text) >= 120:
                new_paragraphs.append(f"<p{attrs}>{current_p_text.strip()}</p>")
                current_p_text = ""
                sentence_count = 0
        
        if current_p_text.strip():
            new_paragraphs.append(f"<p{attrs}>{current_p_text.strip()}</p>")
            
    return "\n".join(new_paragraphs)

# <p> タグをキャプチャして置換。ただし装飾用の div や li 内の p タグなどを考慮
# <p> タグの正規表現
html = re.sub(
    r'<p([^>]*)>(.*?)</p>',
    refactor_p_tag,
    html,
    flags=re.DOTALL
)

# 保存
with open(output_path, "w", encoding="utf-8") as f:
    f.write(html)

print("Refactoring complete.")
