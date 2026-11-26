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
  - "QA-cddaeec3-b9f7-458a-815a-6a14213557ed"
  - "QA-030f926b-5ae7-4543-b8cb-e66aae5e2b5e"
  - "QA-05493ea1-6af7-43b6-97bc-051bbb6fd8d1"
  - "QA-3952eb05-440f-4287-925c-62dd136b6b89"
  - "QA-3996a09e-f103-4b91-94b3-82764f97aa0c"
  - "QA-96fe5f3e-37bb-4094-bcf8-b9eeddbcf45b"
  - "QA-1f2fac5e-cfc3-46d7-89eb-34a9be7a07bf"
  - "QA-4a623664-650d-4a08-800f-691f4ea6ff91"
  - "QA-67715bb3-1162-4ccf-8441-2f44257a57da"
  - "QA-d9cf5fcb-6363-49eb-9511-48b233c0c978"
  - "QA-ae2f173b-e4b1-412b-8b1f-bcdc38b46170"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:56:56+09:00"
---

# トレーサビリティ検証基盤（sara によるドキュメントグラフの機械検証）

## 構成

`docs/` を [sara](https://github.com/cledouarec/sara)（Rust 製 CLI。個人 NUR 経由で dev flake
へ入れる）のナレッジグラフとして扱い、要件・設計・リスク・テストの紐付けが一貫しているかを
機械検証する。要件とリスクの紐付けの一貫性管理が主目的で、「仕様とテストの全体像把握」を支える。

| 部品 | 役割 |
|---|---|
| `docs/model.yaml` | カスタムスキーマ。12 型と relation を定義し、sara の組み込みモデルを全面置換する |
| `sara.toml` | リポジトリ設定 |
| `sara` job | `.github/workflows/check.yml` 内の 1 job。`sara check` で broken reference / duplicate ID / cycles を検出し、同じ job で契約テストを実行し、`sara-fresh` と `sara-gap` で実物のグラフの一覧を出し、`index.md` が生成結果と一致するかを確かめる |
| `sara-new` | `dev/scripts/sara-new.sh` を包む devShell のコマンド。`sara init` で採番し、`<slug>.md` へ配置して `generated` を足す |
| `sara-gap` | `dev/scripts/sara-gap.sh` を包む devShell のコマンド。グラフの未カバー（要件の無い要求、廃止した要求の下の要件、リスクを持たない品質特性を含む）と到達率、人が最終的に判断するテスト条件の一覧、`infrastructure_exempt` を持つ `quality` の一覧を 12 節で出す。結果は報告に留める |
| `sara-fresh` | `dev/scripts/sara-fresh.sh` を包む devShell のコマンド。上流の `generated.at` が自身の基準時刻より新しい item、`--base <ref>` との差分で本文が変わったのに `generated.at` が変わっていない item、`generated.at` 以降の `human:` の `verified` を持たない item（high の risk、`solution`、`use_case`）、`stale_after` の期限切れと間隔の超過を列挙する。結果は報告に留める |
| `sara-verify` | `dev/scripts/sara-verify.sh` を包む devShell の対話のコマンド。はじめに起点の型（`solution`・`adr`・`ubiquitous_term`）を選ぶ。`solution` では子の item を `fzf` で 1 段ずつ選び、根からの経路と選んだ item の下流を、上流から順に `leaf` で表示する。`solution` から辿れない `adr` と `ubiquitous_term` では、型の一覧から選んだ item を表示する。人が記録すると決めた item の `verified` に `human:` の要素を足し、ファイルごとにコミットする。端末でないときは動かない |
| `dev/tests/sara-gap.sh` | `sara-gap` が出す 12 節（未カバーと到達率を含む）の契約、および exit code を検証する。判定は fixture 基準で、実グラフのどの item が未カバーかは見ない（件数が動き続けるため契約にできない）|
| `dev/tests/sara-fresh.sh` | `sara-fresh` の 6 節の列挙と exit code の契約を検証する。グラフはテストが一時ディレクトリに作り、実物の `docs/model.yaml` を重ねる。`--base` の節は、一時ディレクトリに `git init` したリポジトリで確かめる |
| `dev/tests/sara-verify.sh` | `sara-verify` の起点の型、枝を選ぶ候補、対象の列挙と順序、`verified` の書き込み、確認の問いの表示、コミット、拒否の契約を検証する。一時ディレクトリに `git init` したリポジトリで動き、`fzf`・`leaf`・`EDITOR`・端末の判定をスタブへ差し替える |
| `dev/tests/sara-new.sh` | `sara-new` の起票契約（採番・ファイル名規約の適用）を検証する。fixture は実物の `docs/model.yaml` を重ねて使う |
| `dev/tests/adr-supersede.sh` | `supersedes` が指す ADR が `status: deprecated` かを frontmatter から検証する |
| `dev/tests/okf-frontmatter.sh` | OKF 互換の入れ子キー（`generated` / `verified` / `sources`）と `stale_after` の形を frontmatter から検証する |
| `dev/tests/okf-index.sh` | `index.md` が `dev/scripts/okf-index.sh` の生成結果と一致するかを検証する |
| `dev/tests/link-text.sh` | リンク文字列の裸のタグと、リンク直後の name の繰り返しを検出する。文書とコードにある許可外の場所のフル ID と 8 文字省略形も検出する |
| `dev/tests/test-doc-map.sh` | テスト資産 ⇔ CASE の 1:1 対応を検証する。区分と除外の正本は `dev/tests/` のデータファイルが持つ（CI に載せていない）|
| `dev/tests/risk-matrix.sh` | risk の `level` が `likelihood` × `impact` のマトリクス導出と一致するかを検証する。マトリクスの正本は `dev/tests/risk-matrix.tsv`（CI に載せていない）|
| `dev/tests/term-avoid.sh` | 用語 item の `avoid` にある綴りが docs・README・AGENTS.md の散文に無いことを検証する |
| `dev/scripts/test-doc-matrix.sh` | テスト資産 ⇔ CASE ⇔ TC ⇔ RISK の対応表を Markdown で生成する（CI に載せていない）|

`sara` job が実行する契約テストは、上の表の `dev/tests/` のうち「CI に載せていない」と書いていない
もの。契約テストを同じ job へ載せるのは、テストが「人が思い出したときだけ動く」状態を避けるため。
「CI に載せていない」と書いた 3 本は、risk とテスト資産が 0 件のいまは exit 1 になるので
載せていない。#6 で載せる。

`sara` job は実物のグラフにも `sara-fresh` を実行し、一覧をログと job のサマリーへ出す。
pull_request の base ブランチを `--base` に渡す。merge-base を引けるよう、
この job の checkout は全履歴を取る。挙がった item は読み直しが要ることを示すだけで破損を意味しないため、
一覧に item が挙がっても（exit 1）job は落とさず、実行に失敗したとき（exit 2 以上）か見出しが欠けたときだけ落とす
（→ [上流より古い item と generated の更新漏れは機械的に列挙する](../quality/stale-items-enumerated-mechanically.md)）。

`sara` job は実物のグラフに `sara-gap` も実行し、未カバーと到達率をログと job のサマリーへ出す。`--base` は渡さない。
未カバーが残っていても（exit 1）job は落とさず、実行に失敗したとき（exit 2 以上）か見出しが欠けたときだけ落とす。
PR ごとに未カバーの増減を見えるようにし、0 本にした節が後で増えたときに気づけるようにするため。

`sara` job は `check.yml` で `check` job（`nix flake check`）と並ぶが、paths-filter を持たず、
`check` job と同じ条件（pull_request）で毎回実行する。
`sara` job は sara 専用の devShell（`dev#sara`）で実行する。

## 支える規範と部品

この基盤が支える規範のうち、次の規範は、支える部品を挙げる。ほかの規範は、構成の表とほかの節で扱う。部品が確かめない部分はレビューで守る。表の注記は、レビューで守る部分の例である。

| 規範 | 支える部品 |
|---|---|
| [設計判断は ADR に記録し、改訂の書き戻しと item への接続を同じ変更の中で完了させる](../quality/adr-decisions-recorded-and-connected.md) | `dev/tests/adr-supersede.sh`、接続の無い ADR を拒む `sara check`。後継が揃っているかはレビューで守る |
| [人が最終的に判断する test_condition は、human_judgement に理由を書いて一覧にする](../quality/human-judgement-marked-on-test-condition.md) | `sara-gap` の節 11 |
| [risk は ISO/IEC 25010:2023 の品質特性を 1 つ持ち、リスクを持たない特性は対象外の宣言を除いて列挙する](../quality/risk-carries-one-quality-characteristic.md) | `docs/model.yaml` の enum、`sara-gap` の節 10、対象外の宣言の TSV |
| [solution の確認の問い](../quality/review-questions-for-solution.md) | 記録の前に問いを出す `sara-verify` |
| [use_case の確認の問い](../quality/review-questions-for-use-case.md) | 記録の前に問いを出す `sara-verify` |
| [specification は SHALL 系で書き、日本語の規範文は同じ強度の規範助動詞で終える](../quality/specification-shall-family-and-matching-auxiliaries.md) | SHALL の無い `specification` を拒む `sara check`、`dev/tests/link-text.sh`。MUST の禁止と日本語の助動詞はレビューで守る |
| [用語の正名は用語 item が固定し、執筆はそれに従う](../quality/glossary-fixes-canonical-terms.md) | `dev/tests/term-avoid.sh` |
| [規範は 1 ファイル 1 item のグラフが持ち、item の一覧は生成した index.md だけが持つ](../quality/normative-items-placement-and-authoring.md) | `dev/scripts/okf-index.sh`、`sara-new` の採番 |
| [risk はまず requirement に張り、設計を差し替えると消える懸念だけを design に張る](../quality/risk-attaches-to-requirement-by-default.md) | `sara-gap` の節 1 と節 6。`design` に張ってよいかの判定はレビューで守る |
| [mitodoke の文書は mitodoke 自身で管理する](../quality/own-docs-managed-by-mitodoke.md) | `sara.toml`、`docs/` のグラフ、CI の `sara` job |

## ID 規約

→ [フル ID は frontmatter だけに書き、散文では item にリンクで触れる](../quality/full-ids-in-frontmatter-links-in-prose.md)

## 検証の強度

**`strict_mode = true` の非必須の確認**。確認自体は strict で、接続漏れを含む全 warning が
error となり `sara check` は exit 1 を返す（→ [sara check を strict モードで回す](../adr/sara-check-strict-mode.md)）。
合格条件は「warning 0 件」に一本化されている。件数などの閾値による条件を持たないのは、
他 PR とのマージ順依存を避けるためでもある。

一方で main の required status check には登録しない。
これは移行中の暫定措置ではなく「**検出は機械・判断は人**」という分担を保つための恒久判断で、
接続漏れの修正が自明でないケース（item 新設を伴う等）を CI が赤いままレビューで扱える余地を
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
