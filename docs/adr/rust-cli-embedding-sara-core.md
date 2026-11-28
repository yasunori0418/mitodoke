---
id: "ADR-22a2cfdf-7f6f-4315-9a73-d3067684cf8b"
type: adr
name: "Rust で書き、sara-core を crate として組み込む"
description: "CLI を Rust で書き、sara の CLI を subprocess で呼ばずに sara-core を crate として直接使い、使う箇所を 1 つのモジュールに集める"
section: product-scope
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q5）で確定"
justifies:
  - "DSG-a5468c87-cf5a-4d27-b261-d22a083a6ff0"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:32:52+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T21:40:45+09:00"
---
# Rust で書き、sara-core を crate として組み込む

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q5）で確定

## 背景

mitodoke の CLI は、文書のグラフの検証を sara に任せる。CLI を何の言語で書き、sara の検証を
どう使うかを決める必要があった。

sara は Rust 製で、ライブラリの `sara-core` が crates.io に公開されている（Apache-2.0、
0.12.2）。`sara-core` は、検証（`check_items`）、グラフとその辿り方（`KnowledgeGraph`・
`reach`・`impact`）、対応表、スキーマを公開している。Rust ならこの crate を直接使える。
ほかの言語からは、sara の CLI を subprocess で呼ぶか、`sara mcp` を MCP で呼ぶことになる。

sara の CLI を subprocess で呼ぶ場合は、次の挙動を mitodoke の側で見分ける必要がある。

- 診断のメッセージが stdout に出て、JSON の前に出力されることがある
- model.yaml の読み込みに失敗しても、組み込みのモデルに切り替えて処理を続ける（警告は
  stderr のログだけ）
- `init` に enum の範囲外の値を渡すと、既定の値に置き換えて exit 0 で終わる
- `errors` は人向けの文字列で、種別のキーが無い

sara は 0.x で、0.12.0 では破壊的変更が 7 件入り、CLI の JSON の形もこのとき変わった。
crate を直接使う場合も CLI を呼ぶ場合も、sara を上げるたびに追随が要る。

## 決定

CLI は Rust で書き、`sara-core` を crate として直接使う。バージョンは Cargo.lock で固定し、
`sara-core` を使う箇所を CLI の中の 1 つのモジュールに集める。このモジュールは別の
エンジンのための抽象化ではない。CLI は sara を組み込んだ 1 つのバイナリになる。

## 根拠

検証の結果を型で受け取れるので、stdout を解析しなくて済み、model.yaml の読み込みの失敗も
そのまま見える。jq で書いていたグラフの辿り方は、`sara-core` の関数に置き換えられる。sara を
CLI に組み込むので、適用先の製品は sara を別に入れなくても mitodoke を動かせる。

代わりに、sara のバージョンを上げるたびに `sara-core` の API の変更に追随することになる。
この追随の範囲を 1 つのモジュールに集めて小さくする。このモジュールは別のエンジンへ
差し替えるための抽象化ではないので、concept §11-10 の「先回りした抽象化を避ける」に
反しない。

`sara-core` のスキーマはプロセスごとに 1 度しか読み込めない。テストで複数のモデルを使う
ときは、プロセスを分けて実行する。

## 棄却した代替案

### Rust で書き、sara の CLI を subprocess で呼ぶ

背景に挙げた CLI の挙動（stdout に混ざる診断、読み込みの失敗を隠す切り替え、範囲外の値の
置き換え、種別の無い `errors`）を、mitodoke の側で見分ける必要が残る。検証の結果を型で
受け取れない。

### Go で書き、sara の CLI を subprocess で呼ぶ

subprocess で呼ぶので、上の案と同じく CLI の挙動を見分ける必要が残り、検証の結果を型で
受け取れない。

### Go で書き、sara は `sara mcp` を MCP で呼ぶ

MCP の結果は構造化された JSON で、output schema と種別が付く。ただし tool は 8 つだけで
ある。検証の結果を型で受け取り、グラフの辿り方を `sara-core` の関数に置き換えるという
利点は、crate を直接使う案だけが持つ。
