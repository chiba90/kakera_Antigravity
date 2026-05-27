$filepath = ".\99_Shared_Outputs\final_assets\suzutake_bamboo_crisis\suzutake_bamboo_crisis.html"
$text = [System.IO.File]::ReadAllText($filepath, [System.Text.Encoding]::UTF8)
$stripped = $text -replace '<[^>]+>', ''
$clean = $stripped -replace '\s+', ''
$clean = $clean -replace '　', ''
$cleanLength = $clean.Length
Write-Output "Exact characters: $cleanLength"
