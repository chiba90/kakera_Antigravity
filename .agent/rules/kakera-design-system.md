# Kakera Design & Markup System

Kakera JOURNALの「マークアップ（HTML/WordPress）構造」「レイアウト装飾」「画像生成・処理」を統括する単一情報源（SSoT）です。

---

## 1. WordPress Output Structure (最終出力の全体構造)
見た目がWordPressのGutenbergで完全に機能するHTMLを、ユーザーへコピペしやすいコードブロックとして出力すること。
構造化データ（JSON-LD）は**必ず本体HTMLと完全に切り離した「2つ目の独立したコードブロック（`<script type="application/ld+json">`で囲まれた状態）」**として出力し、「1つ目をコードエディターへ、2つ目（JSON-LD）をカスタムHTMLブロックへペーストしてください」と案内してください。

### ベースHTML構造の絶対ルール
```html
<h1>[採用した記事タイトル]</h1>
<figure class="wp-block-image"><img src="[01_eyecatch_ファイル名].png" alt="[具体的な代替テキスト]"/></figure>
<p>[プレ導入文（アイキャッチと核心ブロックの間を滑らかに繋ぐ短いリード文章）]</p>

<!-- 記事冒頭のBLUF（核心）ブロック（※詳細はSOPのテンプレート3を参照） -->
<!-- 【AIへの厳重注意】絶対に<ul>タグに `list-style: none` 等のCSSを追加したり、<li>内に手動で「・（中点）」を打ち込まないこと！WordPressのリスト機能と衝突し点が二重になります。必ずこのままの<ul>タグで出力してください -->
<div style="border-left: 4px solid #7b1113; background-color: #faf8f5; padding: 2em; margin: 2.5em 0; box-shadow: 0 4px 20px rgba(0,0,0,0.02);">
    <h3 style="margin-top: 0; margin-bottom: 1em; color: #111; font-family: serif; font-weight: bold; letter-spacing: 0.15em; font-size: 1.2em;">EXECUTIVE SUMMARY ／ 本稿の核心</h3>
    <ul style="margin: 0; padding-left: 1.2em; line-height: 1.9; color: #333; font-size: 0.95em; letter-spacing: 0.05em;">
        <li>...</li>
    </ul>
</div>

[各H2セクション本文（見出し連続を禁止し、肉厚に記述）]

<!-- ▼▼▼ 記事末尾：固定のReference ＆ CTAブロック（変更絶対禁止） ▼▼▼ -->
<hr class="wp-block-separator has-alpha-channel-opacity"/>
<p>伝統を身に纏い、1,000年先の未来へ遺す。Kakeraが織り上げる西陣織アロハシャツの哲学と私たちの物語は、<a href="https://kakera.inc/concept/" target="_blank" rel="noopener">CONCEPT</a>、<a href="https://kakera.inc/kakera-aloha/" target="_blank" rel="noopener">Kakera Aloha</a>、および<a href="https://kakera.inc/about/" target="_blank" rel="noopener">ABOUT</a>よりご覧いただけます。</p>
```

---

## 2. Layout & Decoration System (プレミアムマークアップ装飾)
記事の品格を高め、読者の滞在時間と読了率を最大化するため、伝統的で静謐な「引き算と重厚さ」を極めた装飾を適用します。

- **装飾テンプレートの単一情報源 (SSoT)**:
  具体的な装飾のコードおよびレイアウト設計は、すべて以下の品質管理ガイドラインに集約されています。CCOは執筆時に必ずこのファイルを物理ロードし、そこから**全16種の装飾テンプレート**を適切かつ多様に選定・適用してください。
  👉 [KakeraプレミアムマークアップSOP (kakera-markup-sop.md)](file:///c:/Users/hchiba/Dropbox/$_%E5%80%8B%E4%BA%BA%E7%9A%84%E3%81%AA%E3%82%84%E3%83%BC%E3%81%A4/Kakera/kakera_Antigravity/05_CQO_Quality_Control/guidelines/kakera-markup-sop.md)

- **安っぽい装飾の禁止**:
  ポップな角丸、蛍光イエローマーカー、絵文字の多用、意味のない装飾線などは一発Fail（差し戻し）対象となります。

---

## 3. Image Generation & Processing System (画像生成・処理システム)

生成する画像ファイルの名前（`ImageName`等）は、保存フォルダ内で探しやすいよう、必ず記事の見出し出現順に合わせて、**ファイル名の冒頭に2桁の連番（No）を付与**してください。
（例: アイキャッチ画像は `01_eyecatch_...`、最初のH2見出し下の画像は `02_h2_...`、2つ目のH2見出し下の画像は `03_h2_...` のように順番に振る）

**【TASK 1：AI画像の生成と並列処理の禁止】**
APIエラーを回避するため、4枚以上の画像を生成する場合は絶対に「全枚数を同時に並列生成」せず、「2枚生成 → 待機して完了確認 → 次の2枚を生成」という直列ステップを踏み Capacity Exhausted エラーを防ぐこと。生成した画像はワークスペース内の `99_Shared_Outputs/final_assets/[テーマ名]/` へ保存。

**【TASK 2：16:9 確実クロップの必須実行（最重要事項）】**
画像生成AIはアスペクト比を16:9で完璧に生成する保証がないため、画像を生成・配置した後は「絶対に」以下のPowerShellコマンドを実行し、物理的に16:9サイズへ強制クロップさせること。（自動化スクリプトによるSystem.Drawing of 操作を含む）

```powershell
powershell -ExecutionPolicy Bypass -Command "& { Get-ChildItem -Path '99_Shared_Outputs\final_assets\[テーマ名]\*.png' | ForEach-Object { powershell -ExecutionPolicy Bypass -File .\.agent\scripts\crop_16_9.ps1 -ImagePath `$_.FullName } }"
```

**【TASK 3：データ可視化要素と抽象表現】** 
複雑なデータ表はAI画像ではなく上記のHTMLテーブルを用いる。抽象的で可視化が難しい概念図等はプレースホルダーに逃げず、抽象的で静謐なコンセプチュアルアートとしてAI生成し配置すること。
