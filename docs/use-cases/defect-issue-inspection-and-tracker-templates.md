---
id: "UC-d7be1f85-3a5c-4af3-9b8f-7b2e5f0d8c8a"
type: use_case
name: "欠陥の Issue を検査し、トラッカー用の雛形を配る"
description: "利用者が、欠陥の Issue のラベルや本文の型を mitodoke に検査させ、トラッカー用の雛形を製品から受け取る。"
status: deprecated
refines:
  - "SOL-951ca4d0-8d09-4e41-967b-71315dbf5cf3"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T10:07:32+09:00"
---
# 欠陥の Issue を検査し、トラッカー用の雛形を配る

> **棄却**: この提案は採らない。製品にはトラッカーに依らない欠陥運用の規範を入れ、GitHub 用の部分は例として
> 置く。mitodoke は欠陥の Issue を検査しない。決定は
> [トラッカーに依らない欠陥運用の規範を製品に含め、欠陥の Issue は検査しない](../adr/tracker-independent-defect-norm-shipped.md)
> にある。

## 提案した使われ方

利用者は、欠陥の Issue が欠陥運用の規範に沿っているかを mitodoke に検査させる。mitodoke は `gh` を使って、
Issue のラベル（`risk-expected` と `risk-unexpected`）と本文の型を確かめる。利用者はトラッカー用の
雛形（bug フォームなど）も製品の一部として受け取る。

## 作らない理由

mitodoke が欠陥の Issue を検査すると、mitodoke の役割が文書の検査からトラッカーの運用にまで広がり、
責務を明確に分離するというコンセプト文書の設計原則の 9 から外れる。GitHub 用の部分は例として置けば、
GitHub を使う適用先の製品はそのまま写せ、ほかのトラッカーを使う適用先の製品は読み替えられる。

## 出典

- [トラッカーに依らない欠陥運用の規範を製品に含め、欠陥の Issue は検査しない](../adr/tracker-independent-defect-norm-shipped.md)
- `docs/mitodoke-concept.ja.md`「11. 設計原則」
