---
id: "INF-7d683bd6-5d87-48e7-ad50-2147dcfbe793"
type: infrastructure
name: "ビルド・検証・リリースの基盤"
description: "Rust のコードの整形・静的解析・カバレッジ・プラットフォームごとの検証、バージョンとタグ、sara の版の揃え、workflow の権限、受け入れテストの実行を支える基盤を draft で表す"
status: draft
satisfies:
  - "QA-1b6075e4-bb76-4da5-86a3-72e7486d7997"
  - "QA-4643187c-702a-4d53-9efe-b8352938d6d7"
  - "QA-b1f0d6f5-3d96-4d3f-9378-5ad23f27249a"
  - "QA-0c13507d-a425-49ac-b98b-eca5185dfb40"
  - "QA-927c1c38-06b7-4980-baf1-d354a9470203"
  - "QA-8f4da12f-6ce7-4d78-9b59-fb67891e8f71"
  - "DSG-e6af0d04-58c4-4c32-83d9-7b0d02fb0dab"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T00:27:50+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:07:47+09:00"
---
# ビルド・検証・リリースの基盤

## 構成

mitodoke の CLI をビルドし、マージ前に検証し、リリースする基盤である。次の規範と設計を支える仕組みを
1 本にまとめる。どの仕組みを使うかは、この item では決めない。

| 規範・設計 | 今の状態 |
|---|---|
| [rustfmt と clippy をマージ前の検証に入れ、手元でも同じ判定を得られるようにする](../quality/formatting-and-static-analysis-before-merge.md) | 今は無い。Rust のコードが無い |
| [カバレッジは報告にとどめ、閾値でマージを止めない](../quality/coverage-reported-without-threshold.md) | 今は無い。カバレッジを計測していない |
| [プラットフォームの差が出る層は、マージ前に配布の対象のすべてのプラットフォームで検証を成功させる](../quality/platform-dependent-layers-verified-on-all-platforms.md) | 今は無い。CI は ubuntu だけで動いている |
| [バージョンは一次情報 1 か所から導き、タグとリリースノートは自動で作る](../quality/version-from-single-source-with-automated-tags.md) | 今は無い。バージョンもタグも無い |
| [sara は必要なときに上げ、組み込む版と配る版を同じタグに揃える](../quality/sara-version-upgrade-policy.md) | 今は無い。`Cargo.lock` が無い |
| [workflow は最小権限の permissions を宣言し、外部の action はコミット SHA で固定する](../quality/workflows-least-privilege-and-pinned-actions.md) | 外部の action のコミット SHA での固定は済んでいる。`permissions` の宣言は `.github/workflows/check.yml` に無い |
| [受け入れテストは、ビルドしたバイナリを fixture のリポジトリに対して実行する](../design/acceptance-test-execution.md) | 今は無い。受け入れテストを実行する仕組みが無い |

## 今の状態

`status` は `draft` で、上の表のとおり、仕組みのほとんどはまだ無い。#6 の子の epic が仕組みを作り、
そのときに構成を書いて `status` を `stable` にする。
