Add-Type -AssemblyName System.Drawing

$images = @{
    "C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\01_eyecatch_friction_1778390212041.png" = "01_eyecatch.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\02_h2_inefficiency_1778390227363.png" = "02_h2_inefficiency.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\03_h2_acceptance_1778390243208.png" = "03_h2_acceptance.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\2fca9ab1-ae6e-4bdf-a44b-d70519e7797d\04_h2_waiting_1778390259577.png" = "04_h2_waiting.png"
}

$outDir = "99_Shared_Outputs\note_assets\1622"
if (!(Test-Path $outDir)) {
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

$absOutDir = (Resolve-Path $outDir).Path

foreach ($key in $images.Keys) {
    $inFile = $key
    $outFile = Join-Path $absOutDir $images[$key]
    
    try {
        $img = [System.Drawing.Image]::FromFile($inFile)
        $targetRatio = 16.0 / 9.0
        $currentRatio = $img.Width / $img.Height
        
        if ($currentRatio -gt $targetRatio) {
            $newWidth = [int]($img.Height * $targetRatio)
            $left = [int](($img.Width - $newWidth) / 2)
            $top = 0
            $cropRect = New-Object System.Drawing.Rectangle($left, $top, $newWidth, $img.Height)
        } else {
            $newHeight = [int]($img.Width / $targetRatio)
            $top = [int](($img.Height - $newHeight) / 2)
            $left = 0
            $cropRect = New-Object System.Drawing.Rectangle($left, $top, $img.Width, $newHeight)
        }
        
        $bmp = New-Object System.Drawing.Bitmap($cropRect.Width, $cropRect.Height)
        $gfx = [System.Drawing.Graphics]::FromImage($bmp)
        $gfx.DrawImage($img, (New-Object System.Drawing.Rectangle(0, 0, $bmp.Width, $bmp.Height)), $cropRect, [System.Drawing.GraphicsUnit]::Pixel)
        
        $bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
        
        $gfx.Dispose()
        $bmp.Dispose()
        $img.Dispose()
        Write-Host "Successfully cropped and saved $outFile"
    } catch {
        Write-Host "Failed to process $inFile : $_"
    }
}
