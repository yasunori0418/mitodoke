---
id: "INF-dee49f6e-3499-4d26-9a97-2cd6e03a5d0f"
type: infrastructure
name: "トレーサビリティ検証基盤（sara によるドキュメントグラフの機械検証）"
description: "docs/ を sara のナレッジグラフとして扱い、紐付けの一貫性を CI の sara job と契約テストで機械検証する基盤"
status: stable
satisfies:
  - "QA-6bf957d9-17d9-4660-92b7-ebd6eeb71a8c"
  - "QA-b14e0a14-b9c9-4cc6-9b7a-0ce95d30d289"
  - "QA-bf975ac7-1e84-4f75-9fe7-8d6154d69ba1"
  - "QA-1dd63789-24ed-4a86-bf12-b62d8c526ba5"
  - "QA-611977bd-3d11-4695-9fb2-a9f7211fcfbd"
  - "QA-aa70fff6-3e0a-4163-bf4c-97f1730f7496"
generated:
  by: "claude-code/claude-fable-5-2"
  at: "2026-11-20T00:37:16+09:00"
---

# トレーサビリティ検証基盤（sara によるドキュメントグラフの機械検証）

## 構成

`docs/` を [sara](https://github.com/cledouarec/sara)（Rust 製 CLI。個人 NUR 経由で dev flake
へ入れる）のナレッジグラフとして扱い、要求・設計・リスク・テストの紐付けが一貫しているかを
機械検証する。要求とリスクの紐付けの一貫性管理が主目的で、「仕様とテストの全体像把握」を支える。

| 部品 | 役割 |
|---|---|
| `docs/model.yaml` | カスタムスキーマ。12 型と relation を定義し、sara の組み込みモデルを全面置換する |
| `sara.toml` | リポジトリ設定 |
| `sara` job | `.github/workflows/check.yml` 内の 1 job。`sara check` で broken reference / duplicate ID / cycles を検出し、同じ job で契約テスト 7 本（この表の `dev/tests/` のうち CI に載せるもの）を実行し、`sara-fresh` で実物のグラフの一覧を出し、`index.md` が生成結果と一致するかを確かめる |
| `sara-new` | `dev/scripts/sara-new.sh` を包む devShell のコマンド。`sara init` で採番し、`<slug>.md` へ配置して `generated` を足す |
| `sara-gap` | `dev/scripts/sara-gap.sh` を包む devShell のコマンド。グラフの未カバーを 7 節で列挙し、到達率を出す。実グラフへの実行は CI に載せていない |
| `sara-fresh` | `dev/scripts/sara-fresh.sh` を包む devShell のコマンド。上流の `generated.at` が自身の基準時刻より新しい item、`--base <ref>` との差分で本文が変わったのに `generated.at` が変わっていない item、`generated.at` 以降の `human:` の `verified` を持たない high の risk を列挙する。結果は報告に留める |
| `dev/tests/sara-gap.sh` | `sara-gap` が出す未カバーの 7 節と到達率の契約、および exit code を検証する。判定は fixture 基準で、実グラフのどの item がギャップかは見ない（件数が動き続けるため契約にできない）|
| `dev/tests/sara-fresh.sh` | `sara-fresh` の 3 節の列挙と exit code の契約を検証する。グラフはテストが一時ディレクトリに作り、実物の `docs/model.yaml` を重ねる。`--base` の節は、一時ディレクトリに `git init` したリポジトリで確かめる |
| `dev/tests/sara-new.sh` | `sara-new` の起票契約（採番・ファイル名規約の適用）を検証する。fixture は実物の `docs/model.yaml` を重ねて使う |
| `dev/tests/adr-supersede.sh` | `supersedes` が指す ADR が `status: deprecated` かを frontmatter から検証する |
| `dev/tests/okf-frontmatter.sh` | OKF 互換の入れ子キー（`generated` / `verified` / `sources`）と `stale_after` の形を frontmatter から検証する |
| `dev/tests/okf-index.sh` | `index.md` が `dev/scripts/okf-index.sh` の生成結果と一致するかを検証する |
| `dev/tests/link-text.sh` | リンク文字列の裸のタグと、リンク直後の name の繰り返しを検出する。文書とコードにある許可外の場所のフル ID と 8 文字省略形も検出する |
| `dev/tests/test-doc-map.sh` | テスト資産 ⇔ CASE の 1:1 対応を検証する。区分と除外の正本は `dev/tests/` のデータファイルが持つ（CI に載せていない）|
| `dev/tests/risk-matrix.sh` | risk の `level` が `likelihood` × `impact` のマトリクス導出と一致するかを検証する。マトリクスの正本は `dev/tests/risk-matrix.tsv`（CI に載せていない）|
| `dev/tests/term-avoid.sh` | 用語 item の `avoid` にある綴りが docs・README・AGENTS.md の散文に無いことを検証する（CI に載せていない）|
| `dev/scripts/test-doc-matrix.sh` | テスト資産 ⇔ CASE ⇔ TC ⇔ RISK の対応表を Markdown で生成する（CI に載せていない）|

`sara` job のステップのうち `nix develop` を実行するものは 10 個で、`sara check`、契約テスト 7 本
（`sara-gap`・`sara-fresh`・`sara-new`・`adr-supersede`・`okf-frontmatter`・`okf-index`・`link-text`）、
`sara-fresh` による一覧の報告、`okf-index.sh --check` である。契約テストを同じ job へ載せるのは、
テストが「人が思い出したときだけ動く」状態を避けるため。

`term-avoid.sh`・`risk-matrix.sh`・`test-doc-map.sh` と `dev/scripts/test-doc-matrix.sh` の 4 本は、
用語・risk・テスト資産が 0 件のいまは exit 1 になるため CI に載せていない。#6 で載せる。

`sara` job は実物のグラフにも `sara-fresh` を実行し、一覧をログと job のサマリーへ出す。
pull_request では base ブランチを `--base` に渡し、push では `--base` を付けない。merge-base を引けるよう、
この job の checkout は全履歴を取る。挙がった item は読み直しが要ることを示すだけで破損を意味しないため、
一覧に item が挙がっても（exit 1）job は落とさず、実行に失敗したとき（exit 2 以上）か見出しが欠けたときだけ落とす
（→ [上流より古い item と generated の更新漏れは機械的に列挙する](../quality/stale-items-enumerated-mechanically.md)）。

`sara` job は `check.yml` で `check` job（`nix flake check`）と並ぶが、paths-filter を持たず、
`check` job と同じ条件（main 以外への push と pull_request）で毎回実行する。
`sara` job は sara 専用の devShell（`dev#sara`）で実行する。

## ID 規約

→ [フル ID は frontmatter だけに書き、散文では item にリンクで触れる](../quality/full-ids-in-frontmatter-links-in-prose.md)

## 検証の強度

**`strict_mode = true` の非必須の確認**。確認自体は strict で、接続漏れを含む全 warning が
error となり `sara check` は exit 1 を返す（→ [sara check を strict モードで回す](../adr/sara-check-strict-mode.md)）。
合格条件は「warning 0 件」に一本化されている。件数などの閾値による条件を持たないのは、
他 PR とのマージ順依存を避けるためでもある。

一方で main の required status check には登録しない。
これは移行中の暫定措置ではなく「**検出は機械・判断は人**」という分担を保つための恒久判断で、
張り忘れの修正が自明でないケース（item 新設を伴う等）を CI が赤いままレビューで扱える余地を
残す。

## 出典

[model.yaml で組み込みモデルを全面置換し、汎用の型名を使う](../adr/model-yaml-full-replacement.md)、
[sara 品質管理機構の決定は sara_adr 型に分ける](../adr/sara-adr-type-for-doc-process-decisions.md)、[ADR も UUID で採番し、連番の旧 ADR は legacy_adr 型に凍結する](../adr/adr-uuid-ids-and-legacy-type.md)、
[root は solution と ADR 系の型だけにする](../adr/roots-solution-and-adr-types-only.md)、[sara check を strict モードで回す](../adr/sara-check-strict-mode.md)、
[risk の親に test_plan を含めない](../adr/risk-parent-excludes-test-plan.md)、
[infrastructure を技術基盤として再定義し root から外す](../adr/infrastructure-redefined-non-root.md)、[infrastructure 型を改名しない](../adr/infrastructure-name-kept.md)、
[design の satisfies 対象に test_plan を含める](../adr/design-satisfies-test-plan.md)、[ADR の justifies 対象を specification を持つ全型に広げる](../adr/adr-justifies-quality-and-test-plan.md)、
[item にできない外部参照は text フィールドへ逃がす](../adr/external-references-as-text-fields.md)、
[提案を棄却した決定は status 不採用 で記録する](../adr/adr-status-rejected.md)、[adr の status_note を持たない](../adr/adr-status-note-removed.md)、
[ADR の失効は supersedes と 廃止 で表す](../adr/adr-supersedes-and-deprecated-status.md)、[ID はフル UUID に統一し 8 文字省略形を使わない](../adr/full-uuid-ids-no-short-form.md)、
[frontmatter の外のフル ID と省略形は起票の機械化と契約テストで防ぐ](../adr/frontmatter-only-ids-checked-by-contract-test.md)。

この item は [layat の同じ slug の item](https://github.com/yasunori0418/layat/blob/97ec53ae73d8f609e7a7c53feeb1baf6909fd76d/docs/infrastructure/traceability-verification.md) を下敷きに、mitodoke の構成に合わせて書き起こした。
設計は [layat の epic の grilling セッション](https://github.com/yasunori0418/layat/issues/203) で確定した。
