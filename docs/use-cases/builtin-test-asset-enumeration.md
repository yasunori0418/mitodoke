---
id: "UC-8c19a4ec-573c-4c4c-98fb-2aa216cb4e5d"
type: use_case
name: "テスト資産の列挙を内蔵する"
description: "利用者が、適用先の製品のテスト資産を mitodoke 自身に列挙させ、列挙のコマンドも一覧のファイルも用意せずに test_case との対応を確かめる。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:31:01+09:00"
---
# テスト資産の列挙を内蔵する

> **棄却**: この提案は採らない。mitodoke はテスト資産の列挙を内蔵せず、設定に書いた列挙のコマンドの出力と、
> コミットした一覧のファイルを読む。決定は
> [テスト資産の列挙は内蔵せず、設定のコマンドかコミットしたファイルから読む](../adr/test-assets-listed-by-configured-sources.md)
> にある。

## 提案した使われ方

利用者は `test_case` とテスト資産が 1 対 1 で対応しているかを確かめるときに、テスト資産の一覧を
mitodoke 自身に列挙させる。mitodoke が Rust や Go など主な言語のテストを見つけるので、利用者は列挙の
コマンドも一覧のファイルも用意しない。

## 作らない理由

テストの列挙の方法は言語とテストフレームワークごとに変わる。mitodoke が列挙を持つと、特定の
プログラミング言語やテストフレームワークを製品に求めることになり、コンセプト文書の §10 の非目標に当たる。
適用先の製品が列挙のコマンドを設定に書けば、mitodoke は判定のたびにその出力を読み直せる。

## 出典

根拠の決定は次の ADR が持つ。

- [テスト資産の列挙は内蔵せず、設定のコマンドかコミットしたファイルから読む](../adr/test-assets-listed-by-configured-sources.md)

`docs/mitodoke-concept.ja.md`「10. スコープと非目標」
