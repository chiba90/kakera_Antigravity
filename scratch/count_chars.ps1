$content = Get-Content -Path "03_CCO_Content_Creative\drafts\shurijo_miyadaiku_full.html" -Encoding UTF8 -Raw
# HTMLタグの除去
$pureText = $content -replace '<[^>]+>', ''
# 余計な空白や改行を除去
$pureText = $pureText -replace '\s+', ''
Write-Output "Pure text preview (first 100 chars):"
Write-Output $pureText.Substring(0, [Math]::Min(100, $pureText.Length))
Write-Output "----------------------------------"
Write-Output "Pure char count (excluding HTML tags and spaces):"
Write-Output $pureText.Length
