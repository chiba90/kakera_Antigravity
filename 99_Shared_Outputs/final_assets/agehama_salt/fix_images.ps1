$dir = (Resolve-Path .).Path

# Rename existing 02-07 to 03-08
Rename-Item "07_h2_heritage_archive.png" "08_h2_heritage_archive.png"
Rename-Item "06_h2_agehama_experience.png" "07_h2_agehama_experience.png"
Rename-Item "05_h2_denenshio_minerals.png" "06_h2_denenshio_minerals.png"
Rename-Item "04_h2_kitamae_ship.png" "05_h2_kitamae_ship.png"
Rename-Item "03_h2_nakai_casting.png" "04_h2_nakai_casting.png"
Rename-Item "02_h2_kaga_culture.png" "03_h2_kaga_culture.png"

# Move the new image
$srcFile = "C:\Users\hchiba\.gemini\antigravity\brain\cfd508b9-66c1-4b6b-8770-3cb5544bc5a7\h2_survival_strategy_1778388624819.png"
Copy-Item $srcFile "02_h2_survival_strategy.png"

# Crop the new image
$cropScript = (Resolve-Path "..\..\..\.agent\scripts\crop_16_9.ps1").Path
& powershell -ExecutionPolicy Bypass -File $cropScript -ImagePath "$dir\02_h2_survival_strategy.png"

# Fix the MD file
$mdFile = "agehama_salt_full.md"
$content = Get-Content $mdFile -Raw -Encoding UTF8

# Move 01_eyecatch to the very top
$eyecatchRegex = [regex]::Escape('<figure class="wp-block-image"><img src="01_eyecatch_agehama_salt.png" alt="吹き荒れる日本海の風の中、砂浜に海水を撒き散らす職人の姿"/></figure>')
$content = $content -replace "$eyecatchRegex\r?\n?", ""
$eyecatchHtml = '<figure class="wp-block-image"><img src="01_eyecatch_agehama_salt.png" alt="吹き荒れる日本海の風の中、砂浜に海水を撒き散らす職人の姿"/></figure>'
$content = $eyecatchHtml + "`n" + $content

# Insert 02 for the first H2
$content = $content -replace '<h2>揚げ浜式製塩が強いた極限の生存戦略と年貢システム</h2>', "<h2>揚げ浜式製塩が強いた極限の生存戦略と年貢システム</h2>`n<figure class=`"wp-block-image`"><img src=`"02_h2_survival_strategy.png`" alt=`"重い海水の桶を担ぎ、過酷な砂浜を登る農民たちの歴史的風景`"/></figure>"

# Update subsequent numbers
$content = $content -replace '02_h2_kaga_culture.png', '03_h2_kaga_culture.png'
$content = $content -replace '03_h2_nakai_casting.png', '04_h2_nakai_casting.png'
$content = $content -replace '04_h2_kitamae_ship.png', '05_h2_kitamae_ship.png'
$content = $content -replace '05_h2_denenshio_minerals.png', '06_h2_denenshio_minerals.png'
$content = $content -replace '06_h2_agehama_experience.png', '07_h2_agehama_experience.png'
$content = $content -replace '07_h2_heritage_archive.png', '08_h2_heritage_archive.png'

Set-Content $mdFile -Value $content -Encoding UTF8
