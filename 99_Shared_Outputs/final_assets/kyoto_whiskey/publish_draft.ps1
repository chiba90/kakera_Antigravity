# ==============================================================================
# Kakera JOURNAL: WordPress Auto Draft Publisher (REST API)
# ==============================================================================
# [Usage]
#   1. 下記の「$username」と「$appPassword」をご自身のWordPress情報に書き換えてください。
#   2. 本スクリプトをPowerShellで実行すると、同フォルダ内のHTML原稿が「下書き」として自動入稿されます。
# ==============================================================================

# 1. 認証情報の設定（ご自身の情報に書き換えてください）
$username = "YOUR_WORDPRESS_USERNAME"
$appPassword = "xxxx xxxx xxxx xxxx xxxx xxxx" # WordPressプロフィール画面最下部で生成した24文字のパスワード
$wpUrl = "https://kakera.inc/wp-json/wp/v2/posts"

# 2. 認証バッファの作成
$base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${username}:${appPassword}"))
$headers = @{
    Authorization = "Basic $base64Auth"
    "Content-Type" = "application/json"
}

# 3. 同フォルダ内のHTML原稿の読み込み（相対パス自動判定）
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ([string]::IsNullOrEmpty($scriptDir)) { $scriptDir = "." }
$htmlPath = Join-Path $scriptDir "kyoto_whiskey_article.html"

if (-not (Test-Path $htmlPath)) {
    Write-Host "[ERROR] HTML原稿ファイル（kyoto_whiskey_article.html）が見つかりません。スクリプトと同じフォルダに配置してください。" -ForegroundColor Red
    Exit 1
}
$contentHtml = Get-Content -Path $htmlPath -Raw

# 4. 送信ボディの構築（ステータスは 'draft' = 下書き）
$body = @{
    title   = "ISC金賞受賞 京都ウイスキー西陣織ラベルの評判と魅力を紐解く"
    content = $contentHtml
    status  = "draft"
} | ConvertTo-Json -Depth 10 -Compress

# 5. REST API経由での投稿実行
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "     WordPress Auto Draft Publisher (REST API)    " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "WordPress (kakera.inc) へ下書きを送信中..." -ForegroundColor Cyan

try {
    $response = Invoke-RestMethod -Uri $wpUrl -Method Post -Headers $headers -Body $body
    Write-Host "`n[SUCCESS] 下書き記事の入稿に成功しました！" -ForegroundColor Green
    Write-Host "編集用URL: https://kakera.inc/wp-admin/post.php?post=$($response.id)&action=edit" -ForegroundColor Yellow
} catch {
    Write-Host "`n[ERROR] 送信に失敗しました。認証情報、またはユーザー名に間違いがないかご確認ください。" -ForegroundColor Red
    Write-Error $_
}
Write-Host "`nキーを押すと終了します..."
$null = [Console]::ReadKey()
