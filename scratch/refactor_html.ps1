# Ultra-robust PowerShell HTML refactoring script (pure Unicode constants to eliminate all Shift-JIS issues)
$inputPath = "$PSScriptRoot\..\03_CCO_Content_Creative\drafts\shurijo_miyadaiku_full.html"
$outputPath = "$PSScriptRoot\..\03_CCO_Content_Creative\drafts\shurijo_miyadaiku_full.html"

# Unicode constants
$charEmDash = [char]0x2014       # —
$charHorizBar = [char]0x2015     # ―
$charBoxDash = [char]0x2500      # ─
$charPeriod = [char]0x3002       # 。
$charComma = [char]0x3001        # 、
$charParenOpen = [char]0xFF08    # （
$charParenClose = [char]0xFF09   # ）
$charNo = [char]0x306E           # の

$strDoubleDash = "$charBoxDash$charBoxDash"
$strEmDash = "$charEmDash"
$strHorizBar = "$charHorizBar"
$strPeriod = "$charPeriod"
$strComma = "$charComma"
$strParenOpen = "$charParenOpen"
$strParenClose = "$charParenClose"
$strNo = "$charNo"

# Read HTML in UTF-8
$html = [System.IO.File]::ReadAllText($inputPath, [System.Text.Encoding]::UTF8)

# 1. Clean cite tags (robust replacement)
# Replace "<cite...>— " with "<cite...>（"
$html = [regex]::Replace($html, '(<cite[^>]*>)\s*' + [regex]::Escape($strEmDash) + '\s*', {
    param($m)
    return $m.Groups[1].Value + $strParenOpen
})
# Append "）" before </cite>
$html = $html -replace '</cite>', "$strParenClose</cite>"

# 2. Refactor p tags (Paragraph splitting and body dash removal)
$pRegex = '(?s)<p([^>]*)>(.*?)</p>'
$pEvaluator = [System.Text.RegularExpressions.MatchEvaluator]{
    param($m)
    $attrs = $m.Groups[1].Value
    $content = $m.Groups[2].Value

    # Remove/Replace dashes in paragraph body using native PowerShell -replace
    if (-not [string]::IsNullOrEmpty($strDoubleDash)) {
        $content = $content -replace [regex]::Escape($strDoubleDash), $strComma
    }
    if (-not [string]::IsNullOrEmpty($strEmDash)) {
        $content = $content -replace [regex]::Escape($strEmDash), ""
    }
    if (-not [string]::IsNullOrEmpty($strHorizBar)) {
        $content = $content -replace [regex]::Escape($strHorizBar), ""
    }

    # Split by <br> tags
    $parts = $content -split '\s*<br\s*/?>\s*'
    $newParagraphs = [System.Collections.Generic.List[string]]::new()

    foreach ($part in $parts) {
        $pTrim = $part.Trim()
        if ([string]::IsNullOrEmpty($pTrim)) { continue }

        # Split by period (。) while keeping it
        $splitPattern = '(?<=' + [regex]::Escape($strPeriod) + ')'
        $sentences = [regex]::Split($pTrim, $splitPattern)
        $currentText = ""
        $sentenceCount = 0

        foreach ($sentence in $sentences) {
            $sTrim = $sentence.Trim()
            if ([string]::IsNullOrWhiteSpace($sTrim)) { continue }
            $currentText += $sTrim
            $sentenceCount++

            # Create paragraph if 2 sentences or >120 chars
            if ($sentenceCount -ge 2 -or $currentText.Length -ge 120) {
                $newParagraphs.Add("<p$attrs>$($currentText.Trim())</p>")
                $currentText = ""
                $sentenceCount = 0
            }
        }

        if (-not [string]::IsNullOrEmpty($currentText.Trim())) {
            $newParagraphs.Add("<p$attrs>$($currentText.Trim())</p>")
        }
    }

    return [string]::Join("`r`n", $newParagraphs.ToArray())
}

$html = [regex]::Replace($html, $pRegex, $pEvaluator)

# 3. Repair the "of" bug using PowerShell native -replace with clean pattern
$ofRegex = '([\p{IsHiragana}\p{IsKatakana}\p{IsCJKUnifiedIdeographs}])\s*of\s*([\p{IsHiragana}\p{IsKatakana}\p{IsCJKUnifiedIdeographs}])'
$replacePattern = '$1' + $strNo + '$2'
$html = $html -replace $ofRegex, $replacePattern

# Save file UTF-8 (No BOM)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($outputPath, $html, $utf8NoBom)

Write-Host "HTML Refactoring Complete successfully (repaired 'of' with native -replace)."
