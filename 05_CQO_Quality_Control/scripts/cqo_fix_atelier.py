import os
import re

draft_dir = r"c:\Users\hchiba\Dropbox\$_個人的なやーつ\Kakera\kakera_Antigravity\99_Shared_Outputs\texts"
output_dir = r"c:\Users\hchiba\Dropbox\$_個人的なやーつ\Kakera\kakera_Antigravity\99_Shared_Outputs\final_assets\atelier_shimura"

# 1. Read chunks in correct order (1, 2, 3, 5, 4)
chunks = [
    "atelier_shimura_chunk1.html",
    "atelier_shimura_chunk2.html",
    "atelier_shimura_chunk3.html",
    "atelier_shimura_chunk5.html",
    "atelier_shimura_chunk4.html"
]

content = ""
for chunk in chunks:
    with open(os.path.join(draft_dir, chunk), "r", encoding="utf-8") as f:
        content += f.read() + "\n"

# 2. Fix H1
content = content.replace(
    "<h1>命の色を纏う覚悟とアトリエシムラ着物が示す自然との交差点</h1>",
    "<h1>命の色を纏う覚悟。アトリエシムラの着物が提示する自然との交差点</h1>"
)

# 3. Fix H2s
h2_replacements = {
    "<h2>アトリエシムラの着物が内包する植物の命と途方もない抽出プロセス</h2>": "<h2>植物の命を抽出する途方もないプロセス</h2>",
    "<h2>アトリエシムラ世田谷の静謐な空間で成される自然との直接的な対話</h2>": "<h2>世田谷の空間で成される自然との対話</h2>",
    "<h2>着物に刻まれた志村ふくみ氏の系譜と色をいただくという不可逆の連鎖</h2>": "<h2>志村ふくみの系譜と色をいただく連鎖</h2>",
    "<h2>日常という臨床現場でアトリエシムラの色彩を纏うための決断</h2>": "<h2>日常でアトリエシムラの色を纏う決断</h2>",
    "<h2>絹という有機物と植物染料が結合する瞬間と「色落ち」の美学</h2>": "<h2>絹と植物染料が魅せる色落ちの美学</h2>",
    "<h2>合成染料の誕生による色彩の均質化と、アトリエシムラが放つ歴史的逆照射</h2>": "<h2>合成染料への抵抗と失われた色彩の回復</h2>",
    "<h2>着るアートとしての着物と、次世代へ「記憶」を継承するラグジュアリーの真髄</h2>": "<h2>着るアートとして次世代へ継承する記憶</h2>"
}

for old_h2, new_h2 in h2_replacements.items():
    content = content.replace(old_h2, new_h2)

# 4. Fix Image tags and rename actual files
image_sequence = [
    ("01_eyecatch_atelier_shimura_main.png", "01_eyecatch_atelier_shimura.png"),
    ("02_h2_plant_dye_process.png", "02_h2_plant_dye.png"),
    ("03_h2_setagaya_space.png", "03_h2_setagaya.png"),
    ("04_h2_shimura_fukumi.png", "04_h2_shimura.png"),
    ("05_h2_daily_clinical_scene.png", "05_h2_clinical.png"),
    ("06_h2_silk_aging.png", "06_h2_silk_aging.png"),
    ("08_h2_chemical_dye_history.png", "07_h2_chemical.png"), # Chunk 5's image
    ("07_h2_wearing_art.png", "08_h2_wearing_art.png")      # Chunk 4's image
]

for old_img, new_img in image_sequence:
    content = content.replace(old_img, new_img)
    old_path = os.path.join(output_dir, old_img)
    new_path = os.path.join(output_dir, new_img)
    if os.path.exists(old_path):
        os.rename(old_path, new_path)

# 5. Write final audited HTML
final_path = os.path.join(draft_dir, "atelier_shimura_final_audit_passed.html")
with open(final_path, "w", encoding="utf-8") as f:
    f.write(content)

print(f"CQO Audit fixes applied successfully. Final file saved to {final_path}")
