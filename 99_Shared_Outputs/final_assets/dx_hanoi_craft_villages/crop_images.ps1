Add-Type -AssemblyName System.Drawing

$sourceDir = "C:\Users\hchiba\.gemini\antigravity\brain\4209f06a-ca0e-44c5-b131-435635265603"
$targetDir = Get-Location

$images = Get-ChildItem -Path $sourceDir -Filter "*.png" | Sort-Object LastWriteTime -Descending

# Only process the 8 most recent files to avoid grabbing the old ones if they still exist in the brain dir
# Wait, the filenames are like 01_eyecatch_hanoi_dx_timestamp.png.
# I will group by the prefix and pick the newest one.

$groupedImages = $images | Group-Object -Property { $_.Name -replace '^(0[1-8]_[a-zA-Z0-9_]+)_\d+\.png$', '$1' }

foreach ($group in $groupedImages) {
    if ($group.Name -match "^0[1-8]_") {
        $img = $group.Group[0] # The newest one due to Sort-Object Descending
        $newName = $group.Name + ".png"
        $sourcePath = $img.FullName
        $targetPath = Join-Path $targetDir $newName

        Write-Host "Processing $newName from $($img.Name)..."

        $bmp = [System.Drawing.Bitmap]::FromFile($sourcePath)
        $targetRatio = 16.0 / 9.0
        $currentRatio = $bmp.Width / $bmp.Height

        $cropWidth = $bmp.Width
        $cropHeight = $bmp.Height
        $x = 0
        $y = 0

        if ($currentRatio -gt $targetRatio) {
            $cropWidth = [math]::Floor($bmp.Height * $targetRatio)
            $x = [math]::Floor(($bmp.Width - $cropWidth) / 2)
        } else {
            $cropHeight = [math]::Floor($bmp.Width / $targetRatio)
            $y = [math]::Floor(($bmp.Height - $cropHeight) / 2)
        }

        $cropRect = New-Object System.Drawing.Rectangle($x, $y, $cropWidth, $cropHeight)
        $croppedBmp = $bmp.Clone($cropRect, $bmp.PixelFormat)

        $croppedBmp.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)

        $croppedBmp.Dispose()
        $bmp.Dispose()

        Write-Host "Saved: $targetPath"
    }
}
Write-Host "All images processed successfully."
