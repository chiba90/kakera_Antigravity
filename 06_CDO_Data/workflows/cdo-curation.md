# CDO: 最新ニュース調達ワークフロー

このファイルは、データ部門（CDO）が担当する「最新情報の調達処理」です。

## Step 0: 監査ログの確認
`05_CQO_Quality_Control/audit_logs/agent_learning_log.md` を読み込み、同じ過ちを起こさないようにする。

## Step 1: 情報収集（専用ツールの強制使用）
- 汎用Web検索ツール（search_web等）の使用は禁止する（GoogleトラッキングURLや404エラーの原因となるため）。
- ニュースのキュレーションには必ず、物理ディレクトリの専用スクリプト（例: `node .agent/scripts/fetch_prtimes.mjs` や `fetch_news.mjs` 等）を実行し、生データを抽出すること。
- 過去の抽出履歴（`06_CDO_Data/history/curated_articles_log.md`）を参照し、重複したネタは除外する。
- 【重要】取得した情報ソースの**「実際にアクセス可能な正確なURL（ダミーや適当な文字列は厳禁）」**を必ずセットで保存・提示すること。HTTP 200 OKのアクティブリンクであることを確認せよ。

## Step 2: 選択の提示と結果の保管
3つの候補を提示し、ユーザー（またはCOO）が1つを選択したら、その内容を `06_CDO_Data/history/curated_articles_log.md` に追記して完了報告を行う。
