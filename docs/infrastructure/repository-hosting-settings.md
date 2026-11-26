---
id: "INF-b341594a-d24c-4425-9e60-d812d1a5ea64"
type: infrastructure
name: "リポジトリのホスティングの設定（issue フォーム・ラベル・ブランチの保護）"
description: "issue フォームとラベルで起票を分類語彙に通し、main の ruleset で PR を経ない変更と削除・force push を禁じるホスティングの設定"
status: stable
satisfies:
  - "QA-87b7776a-9ece-42ac-9a56-78daacb42217"
  - "QA-8ec88967-57ce-40aa-957d-ff3c640a44b2"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:27:05+09:00"
---

# リポジトリのホスティングの設定（issue フォーム・ラベル・ブランチの保護）

## 構成

リポジトリをホストする GitHub の設定のうち、規範を支えるものをまとめる。

| 部品 | 役割 |
|---|---|
| issue フォーム | `.github/ISSUE_TEMPLATE/` の 3 本（不具合・機能の要望・ドキュメントの改善）。起票した issue に種別のラベルと `needs-triage` を付ける |
| 空の issue の禁止 | `.github/ISSUE_TEMPLATE/config.yml` の `blank_issues_enabled: false`。Web の画面からの起票をフォームに限る。gh CLI からの起票はこの設定の影響を受けない |
| ラベル | トリアージ・構造・種別・欠陥の分類のラベル。意味は `docs/agents/triage-labels.md` が持つ |
| main の ruleset | main への変更に PR を必須にし、main の削除と force push を禁じる |

## 支える規範と部品

| 規範 | 支える部品 |
|---|---|
| [欠陥はトラッカーが持ちドキュメントグラフは規範のみを持つ。起票は分類語彙を経由する](../quality/defects-in-tracker-graph-holds-norms.md) | issue フォーム 3 本、空の issue の禁止、ラベル |
| [main は PR だけで変え、required の check が成功するまでマージしない](../quality/main-changed-only-by-pull-request-with-required-checks.md) | main の ruleset（PR の必須、削除と force push の禁止） |

main の ruleset は、required の check を 1 つも登録していない。そのため「required の check が成功するまで
マージしない」の部分は、まだ設定で強制していない。
