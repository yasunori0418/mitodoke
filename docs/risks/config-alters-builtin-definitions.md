---
id: "RISK-bae814d8-9483-4d58-adad-30b0c076fbcf"
type: risk
name: "設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる"
description: "設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: config-model
status: stable
threatens:
  - "REQ-69c1c6b2-bbb7-425b-8256-9f340d9ad36f"
  - "REQ-01efc4d0-bec2-44d7-8592-0f7adc81a236"
  - "REQ-cfa09935-9066-433a-a3ef-05ca83ad9a22"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:08:00+09:00"
---
# 設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる

## リスク

設定ファイルが、製品で固定した定義を削除または変更できてしまう懸念である。失敗の向きは次の 3 つある。

- [組み込みの定義は設定で削除も変更もできない](../requirements/builtin-definitions-immutable.md):
  設定が組み込みの型の relation やフィールドを削除または変更でき、唯一の例外の `allowed_targets` の追加を
  超えた変更が通る
- [組み込みの型は 12 型で、すべて必須とする](../requirements/twelve-builtin-types.md): 設定で組み込みの型を
  選ぶか外せる
- [level の導出表は設定で変えられ、設定が無ければ既定の表を使う](../requirements/risk-matrix-configuration.md):
  設定で `likelihood`・`impact`・`level` の値の集合（low・medium・high）を変えられる

どの向きも、適用先の製品が保証する連鎖や採点の尺度を失い、検査が誤った前提で働く点で同じ重さである。
変更された定義でもモデルは形のうえでは成り立つので、誤りは表に出ない。生成の誤りで組み込みの型が欠ける
懸念は [設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す](generated-model-diverges-from-config.md)
が持ち、導出表の 9 通りが揃わないような不正な設定は
[不正な設定を受け付け、誤った前提で検査する](invalid-config-accepted.md) が持つ。

## 実現性

likelihood は medium とした。変わりやすさは低い。規則は組み込みの定義を変えさせないという 1 つの禁止と、
`allowed_targets` の追加という 1 つの例外からなる。見逃しやすさは高い。設定ファイルを読む処理がまだ無く、
写した契約テストはどれも設定による組み込みの定義の変更を確かめていない。

impact は medium とした。変更された定義での検査は出荷物の誤動作だが、設定を直して再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
