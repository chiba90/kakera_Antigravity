Add-Type -AssemblyName System.Drawing
$images = @(
    'C:\Users\hchiba\.gemini\antigravity\brain\47cc52d6-a8b8-453b-a650-9c990125cc04\note_eyecatch_pressure_1778763928721.png',
    'C:\Users\hchiba\.gemini\antigravity\brain\47cc52d6-a8b8-453b-a650-9c990125cc04\note_h2_risk_asymmetry_1778763942755.png',
    'C:\Users\hchiba\.gemini\antigravity\brain\47cc52d6-a8b8-453b-a650-9c990125cc04\note_h2_casting_forging_new_1778763956986.png'
)
$outputNames = @(
    '01_eyecatch.png',
    '02_h2_risk_return.png',
    '03_h2_casting_forging.png'
)

$outDir = '.\99_Shared_Outputs\note_assets\1422'
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

for ($i = 0; $i -lt $images.Length; $i++) {
    $imgPath = $images[$i]
    if (Test-Path $imgPath) {
        $bmp = [System.Drawing.Bitmap]::FromFile($imgPath)
        $targetRatio = 16.0 / 9.0
        $currentRatio = $bmp.Width / $bmp.Height
        $cropWidth = $bmp.Width
        $cropHeight = $bmp.Height
        $cropX = 0
        $cropY = 0

        if ($currentRatio -gt $targetRatio) {
            $cropWidth = [int]($bmp.Height * $targetRatio)
            $cropX = [int](($bmp.Width - $cropWidth) / 2)
        } elseif ($currentRatio -lt $targetRatio) {
            $cropHeight = [int]($bmp.Width / $targetRatio)
            $cropY = [int](($bmp.Height - $cropHeight) / 2)
        }

        $rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropWidth, $cropHeight)
        $cropped = $bmp.Clone($rect, $bmp.PixelFormat)
        
        $outPath = Join-Path $outDir $outputNames[$i]
        $cropped.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $cropped.Dispose()
        $bmp.Dispose()
        Write-Host "Cropped and saved: $outPath"
    } else {
        Write-Host "File not found: $imgPath"
    }
}
