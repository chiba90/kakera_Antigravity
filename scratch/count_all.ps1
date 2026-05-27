$files = @(
    "noh_mask_curation\noh_mask_curation.html",
    "hakogike_national_treasure\hakogike_national_treasure.html",
    "shino_ando_takumi\curation_shino_ando_takumi.html",
    "uchiyama_paper\uchiyama_paper.html",
    "karamoushi_orihime\karamoushi_orihime.html",
    "samani_glass_beads\samani_glass_beads_draft.html",
    "dx_ikaruga_animals\dx_ikaruga_animals.html"
)

foreach ($f in $files) {
    $path = Join-Path ".\99_Shared_Outputs\final_assets" $f
    if (Test-Path $path) {
        $text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        $stripped = $text -replace '<[^>]+>', ''
        $clean = $stripped -replace '\s+', ''
        $clean = $clean -replace '　', ''
        $len = $clean.Length
        Write-Output "$f : $len chars"
    } else {
        Write-Output "$f : Not Found at $path"
    }
}
