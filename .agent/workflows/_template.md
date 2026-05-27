# [役職/部署]: 新規ワークフロー名

このファイルは、[部署名]が担当する「[業務内容の説明]」を実行するための規定ファイル（ワークフロー）です。

## Step 0: 監査ログとコンテキストの確認
- `05_CQO_Quality_Control/audit_logs/agent_learning_log.md` を物理的（view_file等）にロードし、過去の指摘事項・改善策を確認する。
- `.agent/rules/coo-orchestration-rules.md` （COO絶対原則）をロードし、役割と職務権限を再セットする。

## Step 1: [プロセスの開始]
- [具体的な指示内容、ツールの制限など]

## Step 2: [事実確認（Granular Fact-Checking）]
- ※一次情報の物理的なロードと照合プロセスを必ず挟み込み、ハルシネーションを未然に防ぐ手順を記述する。

## Step 3: [成果物のチェックと出力]
- 完了後、成果物をチャット上に出力するとともに、 `.agent/logs/execution_dashboard.md` の末尾にステータス（SUCCESS / Fail / RUNNING）を1行追記（ロギング）し、COOへ報告する。
