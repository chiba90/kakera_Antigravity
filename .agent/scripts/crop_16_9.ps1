param(
    [Parameter(Mandatory=$true)]
    [string]$ImagePath
)

Add-Type -AssemblyName System.Drawing

try {
    $img = [System.Drawing.Image]::FromFile($ImagePath)
    $w = $img.Width
    $h = $img.Height
    $target_ratio = 16.0 / 9.0
    $current_ratio = $w / $h

    if ([Math]::Abs($current_ratio - $target_ratio) -lt 0.01) {
        Write-Host "Image is already 16:9 ratio."
        $img.Dispose()
        exit
    }

    if ($current_ratio -gt $target_ratio) {
        # Too wide
        $new_w = [int]($h * $target_ratio)
        $left = [int](($w - $new_w) / 2)
        $rect = New-Object System.Drawing.Rectangle($left, 0, $new_w, $h)
    } else {
        # Too tall
        $new_h = [int]($w / $target_ratio)
        $top = [int](($h - $new_h) / 2)
        $rect = New-Object System.Drawing.Rectangle(0, $top, $w, $new_h)
    }

    $bmp = New-Object System.Drawing.Bitmap($rect.Width, $rect.Height)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    
    # High quality resize settings
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $g.DrawImage($img, (New-Object System.Drawing.Rectangle(0, 0, $bmp.Width, $bmp.Height)), $rect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $img.Dispose()
    
    $bmp.Save($ImagePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    
    Write-Host "Successfully cropped image to 16:9 ($($rect.Width)x$($rect.Height)). Saved to $ImagePath"
} catch {
    Write-Error "Failed to crop image: $_"
}
