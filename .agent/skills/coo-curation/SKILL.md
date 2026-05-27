---
name: coo-curation
description: "COO オーダー: 最新ニュース調達"
triggers:
  - "/coo-curation"
---

# COO オーダー: 極上記事制作（最新ニュース調達〜正式納品）

社長（CEO）からの特命オーダーです。
COOであるあなたは、この指示を受け取り次第、以下の**全部署（CDO/CMO/CCO/CQO）を繋ぐ一連の完全自動オーケストレーション・パイプライン**を最後まで自律的に実行・推進し、最終成果物の納品まで完了させてください。

## 🔄 全体推進パイプライン（I/O連携）

1. **【CDOフェーズ: 最新ニュース調達】** 
   * `06_CDO_Data/workflows/cdo-curation.md` を起動し、重複のない3候補と話題性・トレンドデータ（Google Trends / TV露出等）を調査し提示。社長に1つを採択していただく。
2. **【CMOフェーズ: マーケティング・インテント設計】** ※社長のニュース採択後、**自動起動**
   * `04_CMO_Marketing/workflows/cmo-article-strategy.md` に従い、主要キーワード・LSI（100件＋10サジェスト）・ピラー＆クラスター・想定クエリを策定し、タイトル3案を提示。社長に承認をいただく。
3. **【CCOフェーズ: 極上コンテンツ執筆・画像生成】** ※CMO設計承認後、**自動起動**
   * `03_CCO_Content_Creative/workflows/cco-writing-core.md` および `cco-heritage.md` 等に基づき、1万文字を基準とする超一流の本文（HTML形式）を執筆し、美術館品質（Museum-grade）の最高級画像（16:9）を生成する。
4. **【CQOフェーズ: 厳格品質監査＆納品】** ※執筆・画像生成完了後、**自動起動**
   * `05_CQO_Quality_Control/workflows/cqo-audit.md` に従い、自己監査を実施する。その際、必ず `05_CQO_Quality_Control/scripts/validate_headings.ps1` 自動品質監査スクリプトを実行し、5大品質ハザード（見出し連続、英語of混入、致命的タイポ、画像絶対URL、マーカー装飾消失）を100%機械的に検証・PASSすること。1点でもエラーがあれば進行を完全ブロック（Exit 1）し、CCOへ自動差し戻しを行う。すべての検証をパスした上で `99_Shared_Outputs/final_assets/[プロジェクト名]/` ディレクトリへ正式納品し、完了報告を行う。

※COOとして、実行前に必ず以下の2つのファイルを物理的（view_file等）に読み込み（ロードし）、自身のコンテキストと職務権限を再セットしてから現場へ指示を出すこと。
1. `.agent/rules/coo-orchestration-rules.md`（COO絶対原則）
2. `05_CQO_Quality_Control/audit_logs/agent_learning_log.md`（監査ログ）

