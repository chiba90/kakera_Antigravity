$path = "99_Shared_Outputs\texts\atelier_shimura_final_audit_passed.html"
$content = Get-Content $path -Raw -Encoding UTF8
$content = $content.Replace("<h1>命の色を纏う覚悟とアトリエシムラ着物が示す自然との交差点</h1>", "<h1>命の色を纏う覚悟。着物が提示する自然との交差点</h1>")
$content = $content.Replace("<h2>アトリエシムラの着物が内包する植物の命と途方もない抽出プロセス</h2>", "<h2>植物の命を抽出する途方もないプロセス</h2>")
$content = $content.Replace("<h2>アトリエシムラ世田谷の静謐な空間で成される自然との直接的な対話</h2>", "<h2>世田谷の空間で成される自然との対話</h2>")
$content = $content.Replace("<h2>着物に刻まれた志村ふくみ氏の系譜と色をいただくという不可逆の連鎖</h2>", "<h2>志村ふくみの系譜と色をいただく連鎖</h2>")
$content = $content.Replace("<h2>日常という臨床現場でアトリエシムラの色彩を纏うための決断</h2>", "<h2>日常でアトリエシムラの色を纏う決断</h2>")
$content = $content.Replace("<h2>絹という有機物と植物染料が結合する瞬間と「色落ち」の美学</h2>", "<h2>絹と植物染料が魅せる色落ちの美学</h2>")
$content = $content.Replace("<h2>合成染料の誕生による色彩の均質化と、アトリエシムラが放つ歴史的逆照射</h2>", "<h2>合成染料への抵抗と失われた色彩の回復</h2>")
$content = $content.Replace("<h2>着るアートとしての着物と、次世代へ「記憶」を継承するラグジュアリーの真髄</h2>", "<h2>着るアートとして次世代へ継承する記憶</h2>")
$content = $content.Replace("01_eyecatch_atelier_shimura_main.png", "01_eyecatch_atelier_shimura.png")
$content = $content.Replace("02_h2_plant_dye_process.png", "02_h2_plant_dye.png")
$content = $content.Replace("03_h2_setagaya_space.png", "03_h2_setagaya.png")
$content = $content.Replace("04_h2_shimura_fukumi.png", "04_h2_shimura.png")
$content = $content.Replace("05_h2_daily_clinical_scene.png", "05_h2_clinical.png")
$content = $content.Replace("08_h2_chemical_dye_history.png", "07_h2_chemical.png")
$content = $content.Replace("07_h2_wearing_art.png", "08_h2_wearing_art.png")
Set-Content -Path $path -Value $content -Encoding UTF8

Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\01_eyecatch_atelier_shimura_main.png" "01_eyecatch_atelier_shimura.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\02_h2_plant_dye_process.png" "02_h2_plant_dye.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\03_h2_setagaya_space.png" "03_h2_setagaya.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\04_h2_shimura_fukumi.png" "04_h2_shimura.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\05_h2_daily_clinical_scene.png" "05_h2_clinical.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\07_h2_wearing_art.png" "08_h2_wearing_art.png"
Rename-Item "99_Shared_Outputs\final_assets\atelier_shimura\08_h2_chemical_dye_history.png" "07_h2_chemical.png"
