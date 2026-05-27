param(
    [string]$FilePath
)

if (-not (Test-Path $FilePath)) {
    Write-Output "Error: File not found - $FilePath"
    exit 1
}

try {
    # 明示的にUTF-8エンコーディングでファイルを全て読み込む
    $text = [System.IO.File]::ReadAllText($FilePath, [System.Text.Encoding]::UTF8)
    
    # HTMLタグの除去 (コメントタグ等もカバーする堅牢な正規表現)
    $stripped = $text -replace '<[^>]+>', ''
    
    # 空白文字、改行コード(\r\n, \n, \t, 全角スペース, 半角スペース)の完全除去
    $clean = $stripped -replace '\s+', ''
    $clean = $clean -replace '　', ''

    $length = $clean.Length
    Write-Output "[$($FilePath)] Pure Characters: $length"
    
    # PowerShellが数値をそのままステータスコードにできるわけではないが、後で取り出しやすくする
    return $length
} catch {
    Write-Output "Error reading file: $_"
    exit 1
}
