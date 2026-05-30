# Kakera JOURNAL プレミアムマークアップSOP (標準作業手順書)

本ファイルは、Kakera JOURNALのブランド価値、ひいてはメガコンテンツの「思考体力」を読者に強いるための、極めて重要なデザイン装置（HTML/CSSマークアップ）の仕様書です。
CCO（執筆）は本テンプレートから意図的かつ多様に組み合わせて記事をリッチ化し、CQO（品質監査）は本規定以外の安っぽい装飾が混入していないか厳しく監査してください。

---

## 🎨 デザインの基本哲学（引き算と重厚さ）
- **ポップさの完全排斥**: 丸角の強いボタン（`border-radius: 12px` 超）、蛍光色のカラー、絵文字の過剰使用は一切禁止します。
- **伝統色の表現**: 漆黒（`#111`）、漆赤（`#7b1113` / `#8B0000`）、砂金（`#bba078`）、和紙（`#faf8f5`）、深紫（`#4B0082`）など、日本の伝統的で静謐な色彩のみを使用します。
- **認知的摩擦の提供**: スクロール中に「足を止める」「目を留める」ための余白や構造を意図的に配置し、読者の滞在時間と読了率を極限まで高めます。

---

## 💎 プレミアム装飾テンプレート 16選

### 1. 砂金色明朝の「ドロップキャップ（落とし文字）」
各H2セクションの冒頭1文字を巨大化させ、高級アート雑誌のような風格を演出します。
```html
<p><span style="float: left; font-size: 2.5em; line-height: 0.8; margin-top: 0.15em; margin-right: 8px; font-family: serif; color: #bba078; font-weight: bold;">[頭文字]</span>本文...</p>
```
- **設置目的**: スクロールする手を一瞬で止めさせ、記事への没入を開始させます（直帰率の低下）。

### 2. 空間の境界を溶かす「縦書き詩的インセット」
横スクロールの日常に、物理的な「縦書き」による美しい余白を挿入します。
```html
<div style="writing-mode: vertical-rl; text-orientation: mixed; height: 18em; margin: 4em auto; padding: 0 2em; border-left: 1px solid #bba078; font-family: serif; font-size: 1.15em; color: #111; letter-spacing: 0.2em; line-height: 2.5; text-align: center;">
    [縦書きの詩的で短い文章・2〜3行程度]<br>
    [改行は br を使用]
</div>
```
- **設置目的**: スクロール中に心地よい「認知的ブレーキ（摩擦）」をかけ、滞在時間を引き延ばします。

### 3. 漆金（うるしがね）キャプションボード
左に漆の太いライン、背景に生成りの和紙を敷いた、本稿の核心（BLUF）を示すためのボードです。
```html
<div style="border-left: 4px solid #7b1113; background-color: #faf8f5; padding: 2em; margin: 2.5em 0; box-shadow: 0 4px 20px rgba(0,0,0,0.02);">
    <h3 style="margin-top: 0; margin-bottom: 1em; color: #111; font-family: serif; font-weight: bold; letter-spacing: 0.15em; font-size: 1.2em;">EXECUTIVE SUMMARY ／ 本稿の核心</h3>
    <ul style="margin: 0; padding-left: 1.2em; line-height: 1.9; color: #333; font-size: 0.95em; letter-spacing: 0.05em;">
        <li>...</li>
    </ul>
</div>
```
- **設置目的**: 記事の冒頭で核心的な知の価値を提示し、読了のコミットメントを高めます。

### 4. 陰翳インセットボックス（コラム・補足用）
左に砂金の細い線、右に消え入るグラデーション背景を持つ知的コラム枠です。
```html
<div style="margin: 2.5em 0; padding: 1.8em 1.5em; border-left: 1px solid #bba078; background: linear-gradient(to right, #fbfaf8, transparent); font-size: 0.93em; line-height: 1.8; color: #444; letter-spacing: 0.05em;">
    <strong style="color: #111; display: block; margin-bottom: 0.5em; font-family: serif; letter-spacing: 0.1em;">※補足事項のタイトル</strong>
    本文... <a href="..." style="color: #7b1113; text-decoration: none; border-bottom: 1px solid #7b1113; font-weight: 600;">関連リンク</a>
</div>
```
- **設置目的**: メインストーリーから少し外れた興味深い歴史・技術のファクトを綺麗に格納します。

### 5. 漆赤（うるしあか）境界線コラム
左に太い深紅の境界線を配した、特定の技術や特徴を記述するためのコラムブロックです。
```html
<div style="border-left: 4px solid #8B0000; padding-left: 15px; margin: 25px 0;">
    <p style="font-weight: bold; margin-bottom: 5px; color: #8B0000;">🍷 [アイコン・絵文字1字] [技術的特徴のタイトル]</p>
    <p style="margin: 0; line-height: 1.6; font-size: 0.95em; color: #333;">[補足説明文...]</p>
</div>
```
- **設置目的**: 技術のコアファクトを目立たせ、スクロール時の視線誘導を滑らかにします。

### 6. 深紫（こきむらさき）境界線コラム
格式高い高貴な深い紫を左に配した、地域性や思想を記述するためのコラムブロックです。
```html
<div style="border-left: 4px solid #4B0082; padding-left: 15px; margin: 25px 0;">
    <p style="font-weight: bold; margin-bottom: 5px; color: #4B0082;">🌾 [アイコン・絵文字1字] [思想・文脈のタイトル]</p>
    <p style="margin: 0; line-height: 1.6; font-size: 0.95em; color: #333;">[補足説明文...]</p>
</div>
```
- **設置目的**: ブランドの美意識と格式の高さを、色彩のアクセントによって表現します。

### 7. 砂金（さきん）境界線コラム
砂金色を左に配した、製品へのこだわりや特筆ポイントを記述するためのコラムブロックです。
```html
<div style="border-left: 4px solid #bba078; padding-left: 15px; margin: 25px 0;">
    <p style="font-weight: bold; margin-bottom: 5px; color: #bba078;">💡 [アイコン・絵文字1字] [こだわり・補足のタイトル]</p>
    <p style="margin: 0; line-height: 1.6; font-size: 0.95em; color: #333;">[補足説明文...]</p>
</div>
```
- **設置目的**: コラムのバリエーションを確保し、読者を色彩の変化で飽きさせないようにします。

### 8. 引き算のノングリッドテーブル（3カラム）
無駄な格子線を排し、黒金の重厚さを載せた極めてミニマルなテーブルです。
```html
<table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 0.9em; letter-spacing: 0.05em; line-height: 1.7; margin: 2.5em 0;">
    <thead>
        <tr style="border-bottom: 1px solid #111;">
            <th style="padding: 1.5em 1em; color: #111; font-weight: normal; font-family: serif; letter-spacing: 0.05em;">項目分類</th>
            <th style="padding: 1.5em 1em; color: #111; font-weight: normal; font-family: serif; letter-spacing: 0.05em;">味わい・物理の個性</th>
            <th style="padding: 1.5em 1em; color: #111; font-weight: normal; font-family: serif; letter-spacing: 0.05em;">最適なペアリング・シーン</th>
        </tr>
    </thead>
    <tbody>
        <tr style="border-bottom: 1px solid #eee;">
            <td style="padding: 1.5em 1em; font-weight: bold; color: #111; font-family: serif;">...</td>
            <td style="padding: 1.5em 1em; color: #555;">...</td>
            <td style="padding: 1.5em 1em; color: #555;">...</td>
        </tr>
    </tbody>
</table>
```
- **設置目的**: 複雑な仕様やクラスターの対比を、知性の漂うデザインで整理します。

### 9. 引き算のノングリッドテーブル（2カラム）
ヘッダー背景に高級感のあるブランドカラー（例: 漆赤 `#8B0000`）を載せた2カラムの対比テーブルです。
```html
<table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 0.92em; letter-spacing: 0.05em; line-height: 1.7; margin: 2.5em 0;">
    <thead>
        <tr style="background-color: #8B0000; color: white;">
            <th style="padding: 12px; border: 1px solid #ddd; text-align: left; font-family: serif; font-weight: normal;">項目</th>
            <th style="padding: 12px; border: 1px solid #ddd; text-align: left; font-family: serif; font-weight: normal;">テイスティング／プロファイル</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td style="padding: 12px; border: 1px solid #ddd; font-weight: bold; background-color: #fcfcfc; font-family: serif; color: #111;">...</td>
            <td style="padding: 12px; border: 1px solid #ddd; color: #333;">...</td>
        </tr>
    </tbody>
</table>
```
- **設置目的**: パラメータと詳細解説という2層のデータを、引き締まった境界線と共に対比します。

### 10. 中央寄せ・両側境界線付きブレンダー引用ブロック
左右にソリッドな黒境界線を配し、職人や先人の言葉を際立たせるための引用ブロックです。
```html
<blockquote style="margin: 2.5em 0; padding: 2em; border-left: 1px solid #111; border-right: 1px solid #111; background-color: #faf8f5; text-align: center;">
    <p style="margin: 0; font-family: serif; font-size: 1.1em; color: #333; letter-spacing: 0.1em; line-height: 2;">「[職人がぽつりと語る深い独白や核心の言葉]」</p>
    <cite style="display: block; margin-top: 1em; font-size: 0.85em; color: #777; font-family: serif;">[発言者の属性・出典]</cite>
</blockquote>
```
- **設置目的**: 安易なインタビュー体（「〇〇さん：〜」）を排し、職人の執念を言葉の「重力」として読者に体感させます。

### 11. アソシエイト・アンダーライン（漆赤強調マーカー）
テキストのインライン強調用マーカー。蛍光マーカーを完全に排した大人仕様です。
```html
<span style="background: linear-gradient(transparent 65%, rgba(123, 17, 19, 0.1) 0%); font-weight: bold; color: #111;">[強調テキスト]</span>
```
- **設置目的**: 本文中の極めて本質的な概念や、歴史・科学的インサイトを品格を維持したまま強調します。

### 12. アソシエイト・アンダーライン（砂金強調マーカー）
漆赤とは異なる、砂金色の極めて知的なインラインマーカーです。
```html
<span style="background: linear-gradient(transparent 65%, rgba(187, 160, 120, 0.2) 0%); font-weight: bold; color: #111;">[強調テキスト]</span>
```
- **設置目的**: 漆赤マーカーと多様に組み合わせることで、強調箇所のニュアンス（技術的こだわり、余白の記述など）を区別します。

### 13. 画像キャプション（ギャラリー展示ラベル）
写真の直下に配置する、右寄せ・明朝体・イタリックの極めて知的なラベルです。
```html
<figcaption style="text-align: right; font-size: 0.8em; color: #888; font-family: 'Times New Roman', serif; font-style: italic; letter-spacing: 0.15em; margin-top: 0.8em; padding-right: 0.5em;">── Exhibit XX: [作品／歴史／マテリアルの短い説明]</figcaption>
```
- **設置目的**: 単なる「イメージ画像」ではなく、そこに展示されている美術品のような重みをアセットへ与えます。

### 14. 重厚な「定義リスト型カード（dl）」
技法の解説や、専門概念の違いを美しく整理するための、のっぺり化打破ブロックです。
```html
<dl style="margin: 2.5em 0; border-top: 2px solid #111;">
    <dt style="font-weight: bold; font-size: 1.1em; margin-top: 1.5em; color: #111; font-family: serif; letter-spacing: 0.05em;">[定義語・技術名]</dt>
    <dd style="margin: 0.5em 0 1.5em 0; padding-left: 1.5em; border-left: 2px solid #bba078; color: #555; line-height: 1.8; font-size: 0.95em;">[技術や言葉の詳細な解説文]</dd>
</dl>
```
- **設置目的**: 長い解説文章の連続を心地よく解体し、読者の理解を深めます。

### 15. 自律型「原則・カードリストボックス」（まとめ用）
記事の最終章などで、読者に持ち帰ってほしい「コアバリュー」を美しい枠に格納するまとめブロックです。
```html
<div style="border: 1px solid #e0e0e0; padding: 2.5em; margin: 3em 0; box-shadow: 0 4px 20px rgba(0,0,0,0.02); background-color: #faf8f5;">
    <p style="font-size: 0.8em; text-transform: uppercase; letter-spacing: 0.2em; color: #bba078; text-align: center; margin-bottom: 2em; font-family: 'Times New Roman', serif; font-weight: bold;">Core Principles of Curation</p>
    <ul style="list-style: none; padding: 0; margin: 0; color: #333; line-height: 1.9; font-size: 0.93em;">
        <li style="border-bottom: 1px dotted #eee; padding: 1.2em 0; font-family: serif;"><strong style="color: #111;">[原則タイトル]</strong>：[解説内容]</li>
        <li style="border-bottom: 1px dotted #eee; padding: 1.2em 0; font-family: serif;"><strong style="color: #111;">[原則タイトル]</strong>：[解説内容]</li>
        <li style="padding-top: 1.2em; font-family: serif;"><strong style="color: #111;">[原則タイトル]</strong>：[解説内容]</li>
    </ul>
</div>
```
- **設置目的**: 読後の満足感を高め、Kakeraの他の記事への回遊やSNSでのシェア意欲を強力に刺激します。

### 16. デメリット／宿命の「 sincere disclosure (誠実なる告白) 」ボックス
伝統工芸品が抱える物理的デメリット、取り扱いの難しさ、あるいは衰退という現実のファクトを誠実に提示します。
```html
<div style="margin: 3em 0; padding: 2em; border-left: 2px solid #7b1113; background-color: #f9f2f2; font-size: 0.93em; line-height: 1.8; color: #555; letter-spacing: 0.05em;">
    <strong style="color: #7b1113; display: block; margin-bottom: 0.8em; font-family: serif; font-size: 1.05em; letter-spacing: 0.08em;">⚠️ SINCERE DISCLOSURE ／ 避けられぬ経年と宿命</strong>
    [デメリットや取り扱いの注意点などの誠実な解説文]
</div>
```
- **設置目的**: 良い部分だけを並び立てる宣伝広告の欺瞞を排し、工芸のリアルな物理性に寄り添うメディアとしての「圧倒的信頼性」と「知的水準」を獲得します。

---

## 🚫 使用禁止装飾（即Fail判定となる対象）
- `border-radius: 8px` 以上の角丸（極めて安っぽく、伝統の品格を損ないます）
- `border: 1px solid #ccc;` のみの味気ない境界線囲み（WordPressのデフォルトブロックのままであり、知層としての工夫が見えません）
- 蛍光イエローマーカー（`<mark>`タグなどのベタ塗り）
- ポップなボタン（丸みの強いもの、グラデーションの強すぎるもの）
- 本文中の顔文字・過剰な絵文字（知性を著しく毀損します）

---

*(本SOPはKakera JOURNALの「マークアップ装飾」の全公式ライブラリ（SSoT）であり、これに基づき品質監査が行われます)*
