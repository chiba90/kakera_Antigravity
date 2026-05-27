$assetsDir = ".\99_Shared_Outputs\final_assets"

$targets = @{
    "kasuga_shinroku" = "index.html"
    "karamoushi_orihime" = "karamoushi_orihime.html"
    "shino_ando_takumi" = "curation_shino_ando_takumi.html"
    "uchiyama_paper" = "uchiyama_paper.html"
}

foreach ($project in $targets.Keys) {
    $filename = $targets[$project]
    $filePath = Join-Path $assetsDir $project | Join-Path -ChildPath $filename
    
    if (-not (Test-Path $filePath)) {
        Write-Host "File not found: $filePath" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "Processing $project/$filename..." -ForegroundColor Cyan
    
    $content = Get-Content -Path $filePath -Raw
    
    # regex for relative src (not starting with http/https)
    $pattern = 'src=["''](?![a-zA-Z]+://)([^"'']+)["'']'
    $replacement = "src=`"https://kakera.inc/wp-content/uploads/final_assets/$project/`$1`""
    
    $newContent = [regex]::Replace($content, $pattern, $replacement)
    
    Set-Content -Path $filePath -Value $newContent -Encoding utf8
    Write-Host "  Successfully converted relative image URLs to absolute." -ForegroundColor Green
}
