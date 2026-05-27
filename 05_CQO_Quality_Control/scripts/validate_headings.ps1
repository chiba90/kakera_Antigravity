# ==============================================================================
# CQO Quality Validation Script: Ultimate Asset Auditor (Pure ASCII Safe Code)
# ==============================================================================
# This script audits final HTML assets for 5 major quality hazards:
# 1. Consecutive Headings / Missing Body (e.g. <h2><h3> without <p>)
# 2. English "of" mix-in inside Japanese text (AI multilingual bug)
# 3. Critical Typos / Inappropriate words ("nikuseiteki")
# 4. Absolute Image URL enforcement (src must start with kakera.inc absolute path)
# 5. Marker decoration check (linear-gradient must be used at least 2 times)
#
# Usage:
#   powershell -File .\validate_headings.ps1 [-projectName "project_directory_name"]

param(
    [string]$projectName = ""
)

$assetsDir = ".\99_Shared_Outputs\final_assets"
if ($projectName -ne "") {
    $assetsDir = Join-Path $assetsDir $projectName
    Write-Host "Targeting Project: $projectName" -ForegroundColor Cyan
}

if (-not (Test-Path $assetsDir)) {
    Write-Host "[ERROR] Assets directory not found: $assetsDir" -ForegroundColor Red
    Exit 1
}

$htmlFiles = Get-ChildItem -Path $assetsDir -Filter "*.html" -Recurse
$failCount = 0

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "     CQO Ultimate Automated Quality Audit (v2.3)  " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

# Define NG words using Unicode characters to prevent PowerShell encoding issues.
# "nikuseiteki" (肉性的) -> U+8089 (肉), U+6027 (性), U+7684 (的)
$nikuseiteki = "$([char]0x8089)$([char]0x6027)$([char]0x7684)"
# "nikuseitekishugyou" (肉性的修行) -> U+8089 (肉), U+6027 (性), U+7684 (的), U+4FEE (修), U+884C (行)
$nikuseitekishugyou = "$([char]0x8089)$([char]0x6027)$([char]0x7684)$([char]0x4FEE)$([char]0x884C)"

$ngWords = @($nikuseiteki, $nikuseitekishugyou)

foreach ($file in $htmlFiles) {
    # Skip non-final assets, json-ld structural files, and temporary files
    if ($file.Name -match "jsonld|json_ld|json-ld|temp|draft|chunk") { continue }
    
    $content = Get-Content -Path $file.FullName -Raw
    $lines = Get-Content -Path $file.FullName
    
    $fileHasIssue = $false
    $issues = @()
    
    # --------------------------------------------------
    # 1. Consecutive Headings & Missing Body
    # --------------------------------------------------
    $consecutiveMatches = [regex]::Matches($content, '(?i)<(h[1-6])[^>]*>.*?</\1>\s*<(h[1-6])[^>]*>')
    if ($consecutiveMatches.Count -gt 0) {
        $fileHasIssue = $true
        foreach ($match in $consecutiveMatches) {
            $issues += "Consecutive Headings: '$($match.Value)' without any body text in between."
        }
    }
    
    $inH2 = $false
    $hasP = $false
    $h2LineText = ""
    $h2LineNum = 0
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        
        if ($line -match '<h2[^>]*>') {
            $inH2 = $true
            $hasP = $false
            $h2LineText = $line
            $h2LineNum = $i + 1
        }
        
        if ($line -match '<p[^>]*>' -or $line -match '<ul[^>]*>' -or $line -match '<blockquote[^>]*>' -or $line -match '<table[^>]*>' -or $line -match '<dl[^>]*>') {
            $hasP = $true
        }
        
        if ($line -match '<h3[^>]*>' -and $inH2) {
            if (-not $hasP) {
                $fileHasIssue = $true
                $issues += "Missing Body text: H3 (Line $($i+1)) immediately follows H2 (Line $h2LineNum) without intermediate paragraph! (H2: '$h2LineText')"
            }
            $inH2 = $false
        }
        
        if ($line -match '<h2[^>]*>' -and $i -ne ($h2LineNum - 1)) {
            $inH2 = $true
            $hasP = $false
            $h2LineText = $line
            $h2LineNum = $i + 1
        }
    }

    $plainText = [regex]::Replace($content, '<[^>]+>', ' ')
    $plainText = [regex]::Replace($plainText, '\s+', ' ')

    # --------------------------------------------------
    # 2. English "of" mix-in check inside Japanese text
    # --------------------------------------------------
    $ofPattern = '(?i)([\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]{1,10})\s*of\s*([\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]{1,10})'
    $ofMatches = [regex]::Matches($plainText, $ofPattern)
    if ($ofMatches.Count -gt 0) {
        foreach ($match in $ofMatches) {
            $fileHasIssue = $true
            $issues += "English 'of' Mix-in: Found English 'of' in Japanese context -> '$($match.Value)'"
        }
    }

    # --------------------------------------------------
    # 3. Critical Typo / Inappropriate word check
    # --------------------------------------------------
    foreach ($word in $ngWords) {
        if ($content -match [regex]::Escape($word)) {
            $fileHasIssue = $true
            $issues += "Critical Typo / Quality Hazard: Inappropriate word detected!"
        }
    }

    # --------------------------------------------------
    # 4. Absolute Image URL check
    # --------------------------------------------------
    $imgMatches = [regex]::Matches($content, '(?i)<img[^>]+src=["'']([^"'']+)["'']')
    foreach ($img in $imgMatches) {
        $src = $img.Groups[1].Value
        if ($src -notmatch '^https://kakera\.inc/wp-content/uploads/final_assets/') {
            $fileHasIssue = $true
            $issues += "Absolute Image URL Violation: Image src must start with 'https://kakera.inc/wp-content/uploads/final_assets/' -> Current: '$src'"
        }
    }

    # --------------------------------------------------
    # 5. Marker decoration check
    # --------------------------------------------------
    $markerCount = ([regex]::Matches($content, 'linear-gradient')).Count
    if ($markerCount -lt 2) {
        $fileHasIssue = $true
        $issues += "Marker Decoration Missing: Linear-gradient markers are missing or insufficient. Need at least 2, found $markerCount."
    }

    # --------------------------------------------------
    # Report Result for current file
    # --------------------------------------------------
    $relativeFilePath = $file.FullName -replace [regex]::Escape($PSScriptRoot), ''
    if ($fileHasIssue) {
        $failCount++
        Write-Host "Auditing: $relativeFilePath" -ForegroundColor Yellow
        Write-Host "  [FAIL] Quality hazard(s) detected!" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "    - $issue" -ForegroundColor DarkRed
        }
    } else {
        Write-Host "Auditing: $relativeFilePath" -ForegroundColor Gray
        Write-Host "  [PASS] Quality audit passed." -ForegroundColor Green
    }
    Write-Host "--------------------------------------------------" -ForegroundColor Gray
}

if ($failCount -gt 0) {
    Write-Host "[CQO AUDIT RESULT] FAIL ($failCount quality issues detected across assets)." -ForegroundColor White -BackgroundColor Red
    Write-Host "COO Management Notice: Stop pipeline immediately. All quality hazards must be resolved before release." -ForegroundColor Red
    Exit 1
} else {
    Write-Host "[CQO AUDIT RESULT] PASS (All quality checks are 100% compliant)." -ForegroundColor White -BackgroundColor Green
    Exit 0
}
