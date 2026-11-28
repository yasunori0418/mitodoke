---
id: "RISK-a13b5a14-d002-403c-8aed-fd1409fd6350"
type: risk
name: "独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る"
description: "独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る"
likelihood: high
impact: medium
level: high
quality_characteristic: flexibility
section: config-model
status: stable
threatens:
  - "REQ-26df91d3-8166-4192-9b78-7b4b82c306c8"
  - "REQ-fe865691-be47-4ddf-b878-01fc88c0a549"
  - "REQ-73e736ca-7c31-4c0a-9448-80fb29347f1d"
  - "REQ-5c52b41a-9015-4c68-8143-b813f13064fa"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:08:00+09:00"
---
# 独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る

## リスク

適用先の製品が独自の型・relation・フィールドを定義したときに、mitodoke がそれを受け付けないか、扱う範囲を
誤る懸念である。失敗の向きは次の 4 つある。

- [設定ファイルは YAML の mitodoke.yaml とする](../requirements/config-file-format.md): sara の `model.yaml` が
  受け付ける書き方（YAML のタグを含む）の一部を `mitodoke.yaml` に書けない
- [検査が独自の型に及ぶ範囲を、全型に働く契約と組み込みの型だけに働く契約に分ける](../requirements/inspection-scope-for-custom-types.md):
  組み込みの名前を条件に持つ契約を独自の型に働かせるか、それ以外の契約を独自の型に働かせない
- [独自の relation は、再確認待ちを伝播させるかを設定で宣言する](../requirements/staleness-propagation-declared-for-custom-relations.md):
  伝播させると宣言した独自の relation を辿らないか、宣言していない relation を辿る
- [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](../requirements/type-locations-in-config.md):
  独自の型の置き場所を設定から読まず、一致の検査や index の見出しから漏らす

最も重い向きは、独自の定義に契約が働かず、違反や再確認待ちを見逃す向きで、この risk はこの向きで採点する。
働かない契約は何も報告しないので、誤りは表に出ない。

## 実現性

likelihood は high とした。変わりやすさは高い。YAML のタグを含む書き方のすべて、契約ごとの範囲の振り分け、
relation ごとの伝播の宣言、型ごとの置き場所と、独自の定義に関わる分岐が多い。見逃しやすさも高い。
mitodoke 自身の `docs/model.yaml` は組み込みの 12 型だけを持つので、写した契約テストは独自の定義を
どれも扱っていない。

impact は medium とした。独自の定義での見逃しは出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
