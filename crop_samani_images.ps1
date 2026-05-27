Add-Type -AssemblyName System.Drawing

$images = @{
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\eyecatch_samani_beads_1779352096519.png" = "01_eyecatch_samani_glass_beads.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\h2_samani_beads_01_1779352116643.png" = "02_h2_samani_glass_beads_01.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\h2_samani_beads_02_1779352134981.png" = "03_h2_samani_glass_beads_02.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\h2_samani_beads_03_1779352155144.png" = "04_h2_samani_glass_beads_03.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\h2_samani_beads_04_1779352178103.png" = "05_h2_samani_glass_beads_04.png"
    "C:\Users\hchiba\.gemini\antigravity\brain\1424be1d-e614-491b-9aef-2ba71ae1e59f\h2_samani_beads_05_1779352197471.png" = "06_h2_samani_glass_beads_05.png"
}

$outDirs = @(
    "99_Shared_Outputs\final_assets\samani_glass_beads",
    "03_CCO_Content_Creative\drafts"
)

foreach ($dir in $outDirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
}

foreach ($key in $images.Keys) {
    $inFile = $key
    if (!(Test-Path $inFile)) {
        Write-Host "Source file not found: $inFile"
        continue
    }

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
        
        foreach ($dir in $outDirs) {
            $outFile = Join-Path $dir $images[$key]
            $bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
            Write-Host "Successfully cropped and saved to $outFile"
        }
        
        $gfx.Dispose()
        $bmp.Dispose()
        $img.Dispose()
    } catch {
        Write-Host "Failed to process $inFile : $_"
    }
}
