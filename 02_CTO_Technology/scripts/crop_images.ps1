Add-Type -AssemblyName System.Drawing
function Crop-Image ($Src, $Dest, $TargetW, $TargetH) {
    if (Test-Path $Src) {
        $img = [System.Drawing.Image]::FromFile($Src)
        $w = $img.Width
        $h = $img.Height
        $new_h = [int]($w * 9 / 16)
        if ($h -gt $new_h) {
            $top = [int](($h - $new_h) / 2)
            $bmp = New-Object System.Drawing.Bitmap $w, $new_h
            $g = [System.Drawing.Graphics]::FromImage($bmp)
            $rectDest = New-Object System.Drawing.Rectangle 0, 0, $w, $new_h
            $rectSrc = New-Object System.Drawing.Rectangle 0, $top, $w, $new_h
            $g.DrawImage($img, $rectDest, $rectSrc, [System.Drawing.GraphicsUnit]::Pixel)
            $g.Dispose()
            
            # Resize
            $finalBmp = New-Object System.Drawing.Bitmap $TargetW, $TargetH
            $finalG = [System.Drawing.Graphics]::FromImage($finalBmp)
            $finalG.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $finalRect = New-Object System.Drawing.Rectangle 0, 0, $TargetW, $TargetH
            $finalG.DrawImage($bmp, $finalRect)
            $finalG.Dispose()
            
            $finalBmp.Save($Dest, [System.Drawing.Imaging.ImageFormat]::Png)
            $finalBmp.Dispose()
            $bmp.Dispose()
        } elseif ($w -eq $TargetW -and $h -eq $TargetH) {
            # Already target size
            $img.Save($Dest, [System.Drawing.Imaging.ImageFormat]::Png)
        } else {
            # Just resize without crop if aspect ratio is already 16:9
            $finalBmp = New-Object System.Drawing.Bitmap $TargetW, $TargetH
            $finalG = [System.Drawing.Graphics]::FromImage($finalBmp)
            $finalG.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
            $finalRect = New-Object System.Drawing.Rectangle 0, 0, $TargetW, $TargetH
            $finalG.DrawImage($img, $finalRect)
            $finalG.Dispose()
            $finalBmp.Save($Dest, [System.Drawing.Imaging.ImageFormat]::Png)
            $finalBmp.Dispose()
        }
        $img.Dispose()
        Remove-Item $Src
        Write-Output "Successfully processed $Dest"
    } else {
        Write-Output "File not found: $Src"
    }
}

$dl_dir = "C:\Users\hchiba\Downloads"
if (-Not (Test-Path $dl_dir)) {
    New-Item -ItemType Directory -Force -Path $dl_dir
}

# Image paths (Note: generate_image suffixes numbers, we'll find them via Get-ChildItem if needed, 
# but I'll write the script to use wildcard paths for the artifact folder)
$artifactDir = "C:\Users\hchiba\.gemini\antigravity\brain\93a40728-4b1c-436c-b75e-f7de9237d686"

$mood1 = Get-ChildItem -Path $artifactDir -Filter "mucha_nishijin_mood1_*.png" | Select-Object -First 1
$mood2 = Get-ChildItem -Path $artifactDir -Filter "mucha_nishijin_mood2_*.png" | Select-Object -First 1
$chart = Get-ChildItem -Path $artifactDir -Filter "chart_craft_art_market_*.png" | Select-Object -First 1
$diag  = Get-ChildItem -Path $artifactDir -Filter "diagram_nishijin_sublimation_*.png" | Select-Object -First 1

if ($mood1) { Crop-Image $mood1.FullName "$dl_dir\mood_nishijin_mucha_1.png" 640 360 }
if ($mood2) { Crop-Image $mood2.FullName "$dl_dir\mood_nishijin_mucha_2.png" 640 360 }
if ($chart) { Crop-Image $chart.FullName "$dl_dir\chart_craft_art_market.png" 640 360 }
if ($diag) { Crop-Image $diag.FullName "$dl_dir\diagram_nishijin_sublimation.png" 640 360 }

Write-Output "All 16:9 cropping done."
