# Kakera JOURNAL System Architecture

## 概要 (Overview)
このプロジェクトは、Kakeraブランドの思想を組み込んだ高品質なSEO記事の量産および、そこから派生するYouTube動画（Remotion）の生成までを一貫して自動化するAIエージェント・システムです。
「入力（学習） → 執筆（コア） → 出力（派生）」というシームレスなパイプラインで構築されており、各ワークフローはDRY原則に基づきモジュール化されています。

## ディレクトリ構造 (Directory Structure)
- `.agent/workflows/` : AIが実行すべき各種エントリーポイントとコアプロセスを定義。
- `.agent/rules/` : デザイン装飾やSEO方針、ブランドトーンを規定するルール集。
- `.agent/data/` : AIが学習したナレッジ（Founder's Voice）や、フィードバック・変更履歴（`agent_learning_log.md`）などの実行ログを蓄積するストレージ。
- `.agent/scripts/` : ニュース取得や画像クロップなどに用いる自動化スクリプト。
- `outputs/` : 生成されたHTML記事や画像が格納される出力先。
- `kakera-video/` : 記事をもとにショート動画を自動生成するRemotion/VOICEVOXのシステム。

---

## システムパイプライン (System Pipeline)

### 1. 入力・学習エンジン (Input & Learning)
- **`kakera-note-learning.md` (Workflow)**
  - **役割**：千葉氏のnote等のテキストから「哲学・葛藤」を抽出し、`.agent/data/founder_knowledge.md` に蓄積します。
  - **連携**：ここで蓄積されたナレッジは、後段の記事執筆時の「最終章（Founder's Voice）」の生成時に必ず読み込まれ、魂の通った文脈として記事に編み込まれます。

### 2. 執筆エンジン (Writing Engine)

**【3つの入り口（エントリーポイント）】**
1. **`kakera-curation.md`**: 最新ニュース（文化庁や報道機関ベース）を検索し、Kakeraの哲学と結びつくトピックを提案・執筆するルート。
2. **`kakera-heritage.md`**: 歴史や伝統工芸の深掘りテーマ（例：本金糸や漆など）を与えられ、そこから執筆するルート。
3. **`kakera-rewrite.md`**: 既存の短文記事を受け取り、専門リサーチを経て5,000文字規模へスケールアップ・リライトするルート。

**【共通コア・プロセス】**
- **`kakera-writing-core.md` (Workflow)**
  - 上記3つの入り口を通った後、**すべての執筆はこのコアモジュールに合流**します。
  - ルール群（`rules/`）やナレッジ（`data/founder_knowledge.md`）の読み込み。
  - ファクトリサーチと証拠ファイル生成。
  - H2/H3構成案の提示、3段階の装飾コーディング（`kakera-design-system.md`の適用）、セルフチェック。
  - `kakera-design-system.md` およびスクリプトを用いた16:9画像の自動生成とクロップ。

### 3. ルールセット (Rule Sets & Formatting)
執筆エンジン（共通コア）が参照する絶対的な品質基準です（DRY設計により2つに集約されています）。
- **`kakera-writing-rules.md`**: 「執筆の頭脳」。文章の構成制約（5,000文字以上等）、CEOのトーン＆マナー（AI特有の冗長さや安易な表現の徹底排除）、および高度なSEO戦略（見出しの左寄せ、事実に基づくリサーチ義務）を統括します。
- **`kakera-design-system.md`**: 「出力の手足」。インラインCSSを含むプレミアムな記事装飾の定義（灰色BOXの連続等禁止）、画像の16:9生成ルール、さらに変更不可な「末尾のReference/CTAブロック」と分離出力するJSON-LDの最終HTML構造フォーマットまで、成果物の物理的なレイアウトを一元管理します。

### 4. 出力・派生エンジン (Output & Derivative)
- **`kakera-video.md` (Workflow)**
  - 出来上がった記事情報（テキストと画像）を受け取り、それを極限まで情報圧縮（7〜8シーンのフック付きテキストへ変換）。
  - `generate-voicevox.mjs` を通じてVOICEVOX（東北ずん子）の音声を生成。
  - `Remotion`（Reactベースの動画構成）のスクリプトを更新し、1分間のドラマティックな縦型ショート動画へと自動変換します。

---

## 開発・改修時の原則 (Principles for Modification)
1. **DRY（Don't Repeat Yourself）原則の死守**: 
   - 執筆の手順や生成プロセスを変えたい場合は `kakera-writing-core.md` を編集してください。（他のワークフローにコピペ処理を追加しないこと）
   - CTAの文言やデザイン部品を変えたいなら `kakera-design-system.md` を、SEO方針を変えたいなら `kakera-writing-rules.md` を編集してください。
2. **全体俯瞰の徹底（Architecture Awareness）**: 
   - 新たなワークフローやルールを追加する際は、AI（あなた）は必ず事前に本ドキュメントを一読してください。既存のシステムとの競合や重複がないか（影響範囲）をリサーチしてから、詳細な計画案を提示・着手すること。
3. **アーキテクチャの同期（Architecture Sync）**: 
   - ワークフロー、ルール、スクリプトの追加・変更・削除を行った後は、**必ず本ドキュメント（`system-architecture.md`）の内容も見直し、システム構成の記述を最新化（アップデート）すること**。ドキュメントの陳腐化を防ぎ、常に設計と実装を一致させてください。
4. **フィードバックの自律学習（Continuous Learning）**:
   - ユーザーから受けた指摘事項やエラーの回避策、設計の変更履歴は必ず `.agent/data/agent_learning_log.md` に追記してください。タスク着手前やコード修正時にはこのログを参照し、過去のミスを繰り返さないように自律的な改善を図ってください。
