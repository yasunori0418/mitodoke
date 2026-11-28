---
id: "ADR-02f1464f-07c0-4ec6-b755-18d7be97bad3"
type: adr
name: "outturn の Rust の crate を outturn の側に作って使う"
description: "エンベロープの型と item の id の導出を持つ Rust の crate を outturn の側に作り、mitodoke はそれに git のコミットで依存して、mitodoke のコードと text 出力だけを自分で持つ。"
section: json-output
status: stable
sources:
  - id: "issue-74"
    resource: "https://github.com/yasunori0418/mitodoke/issues/74"
    title: "cli-upstream: 3 全体の構造の設計を design と ADR に起こす"
origin: "issue #74 の grilling（2026-11-23）で確定"
justifies:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
references:
  - "ADR-4de11190-40c0-442d-890b-ed92f3c786b9"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:00:42+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:35:11+09:00"
---
# outturn の Rust の crate を outturn の側に作って使う

- ステータス: stable
- 日付: 2026-11-23
- 関連: [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](json-output-conforms-to-outturn.md), GitHub Issue #74
- 起点: issue #74 の grilling（2026-11-23）で確定

## 背景

mitodoke のすべてのサブコマンドの `--json` は outturn のエンベロープにし、outturn の Rust 対応は、必要なら
outturn の側で用意すると決めていた。outturn に Rust の実装は無く、タグもまだ無い。参照実装は Go と Nix
にある。

outturn の仕様は、エンベロープの `result.items[]` の要素が持つ `id` を、item の `kind` と `key` の組を JCS で
正準化して sha256 を取った値と定めている。この手順は、どのツールが計算しても同じ値にならなければならず、
outturn はそれを確かめるテストベクタを持っている。

## 決定

outturn の Rust の crate を、outturn の側に作って使う。

- crate は、エンベロープの型と、item の `id` の導出（`kind` と `key` の組を JCS で正準化して sha256 を
  取る手順）を持つ
- mitodoke の outturn のモジュールは、この crate を使い、mitodoke のコードと text 出力だけを自分で持つ
- mitodoke は crate に git のコミットで依存し、outturn にタグができたらタグに切り替える

[サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](json-output-conforms-to-outturn.md)
は置き換えない。

## 根拠

`id` の導出は仕様の手順なので、ツールごとに書くと同じ手順の実装が増える。mitodoke の中に書くと、Go と
Nix と mitodoke の 3 か所になり、2 つ目の Rust のツールが出たときに 4 か所になる。outturn の crate に置けば、
手順の実装とテストベクタが同じリポジトリに揃う。

crate を型と `id` の導出に限れば、outturn の作業は小さく済み、mitodoke の基盤の epic が待つ期間を短く
できる。mitodoke のコードと text 出力は mitodoke の語彙なので、mitodoke が持つ。

この決定は、outturn の Rust 対応を outturn の側で用意するという既存の決定を具体にしたもので、食い違わない。

## 棄却した代替案

### エンベロープの型と `id` の導出を、mitodoke の中のモジュールとして持つ

別のリポジトリの作業を CLI の実装の前に入れずに済むが、`id` の導出の手順の実装が outturn の外に増え、
2 つ目の Rust のツールで使い回せない。

### crate にエンベロープの型だけを持たせ、`id` の導出を mitodoke の中に書く

outturn の作業は小さくなるが、mitodoke が outturn のテストベクタを自分のテストで読むことになる。

### crate に共通コードの一覧と、エンベロープを組み立てる補助まで持たせる

mitodoke の側は薄くなるが、outturn の作業が大きくなり、基盤の epic が待つ期間が延びる。
