$filepath = ".\03_CCO_Content_Creative\drafts\uchiyama_paper.html"
$text = [System.IO.File]::ReadAllText($filepath, [System.Text.Encoding]::UTF8)
$stripped = $text -replace '<[^>]+>', ''
$clean = $stripped -replace '\s+', ''
$clean = $clean -replace '　', ''
$cleanLength = $clean.Length
Write-Output "Powershell exact characters: $cleanLength"
[System.IO.File]::WriteAllText(".\clean.txt", $clean, [System.Text.Encoding]::UTF8)
