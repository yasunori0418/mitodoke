---
id: "RISK-20b9b69f-34cb-4509-a8aa-ff856889c323"
type: risk
name: "不正な設定を受け付け、誤った前提で検査する"
description: "不正な設定を受け付け、誤った前提で検査する"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: config-model
status: stable
threatens:
  - "REQ-cfa09935-9066-433a-a3ef-05ca83ad9a22"
  - "REQ-9ab110e1-6a93-4c21-b5c3-d9023a77d5c1"
  - "REQ-26df91d3-8166-4192-9b78-7b4b82c306c8"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:08:00+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:48:10+09:00"
---
# 不正な設定を受け付け、誤った前提で検査する

## リスク

不正な `mitodoke.yaml` を誤りとして拒まずに受け付け、その設定を前提に検査や生成をする懸念である。不正な
設定の例は次のものである。

- [level の導出表は設定で変えられ、設定が無ければ既定の表を使う](../requirements/risk-matrix-configuration.md):
  `likelihood` と `impact` の 9 通りの組に満たない導出表
- [テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く](../requirements/test-categories-from-config.md):
  区分の一覧と risk の `section` の値が食い違うなど、区分の一覧の誤り
- [設定ファイルは YAML の mitodoke.yaml とする](../requirements/config-file-format.md): sara の `model.yaml` の
  書き方として成り立たない独自の定義

どの向きも、誤った前提での検査になる点で同じ重さである。9 通りに満たない導出表では、表に無い組の risk の
`level` を確かめられず、その risk の検査が抜けるが、何も報告されないので誤りは表に出ない。組み込みの値の
集合を変える設定は
[設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる](config-alters-builtin-definitions.md)
が持ち、正しい独自の定義を受け付けない懸念は
[独自の型・relation・フィールドを設定に書けないか、契約と再確認待ちの伝播が独自の定義に及ぶ範囲を誤る](custom-definitions-rejected-or-out-of-scope.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは高い。導出表、区分の一覧、独自の定義と、確かめる設定の部分が
多く、それぞれに不正の形がある。見逃しやすさは低い。写した契約テストのうち `dev/tests/risk-matrix.sh` は
導出表の 9 つのセルが揃うことを、`dev/tests/okf-index.sh` は区分の一覧に無い `section` の値の risk で生成を止めることを
確かめている。

impact は medium とした。誤った前提での検査は出荷物の誤動作だが、設定を直して再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
