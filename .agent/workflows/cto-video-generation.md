# CTO: 動画自動生成バッチ

このファイルは、技術部門（CTO）が保守する、Remotionを用いたYouTube用動画の自動生成システムです。

## Step 0: 監査ログの確認
`05_CQO_Quality_Control/audit_logs/agent_learning_log.md` を確認する。

## Step 1: VOICEVOX音声生成
`02_CTO_Technology/kakera-video/scripts/generate-voicevox.mjs` を通じて渡されたテキストの音声を生成する。

## Step 2: Remotionレンダリング
ターミナルツールを用い、`02_CTO_Technology/kakera-video/` ディレクトリで `npm run build` を実行して動画を生成し、完了を報告する。
