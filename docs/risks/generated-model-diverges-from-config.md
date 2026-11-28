---
id: "RISK-689ed16a-0747-45cd-b949-0410efcc0a83"
type: risk
name: "設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す"
description: "設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す"
likelihood: high
impact: medium
level: high
quality_characteristic: functional_suitability
section: config-model
status: stable
threatens:
  - "REQ-76368939-a62b-47cb-b334-8bd7d7ee8389"
  - "REQ-01efc4d0-bec2-44d7-8592-0f7adc81a236"
  - "REQ-f319e7d0-8a0b-4c3f-92fc-b855e7e90652"
  - "REQ-ade865fa-90ea-43c3-b504-4566bb9582ae"
  - "REQ-9ab110e1-6a93-4c21-b5c3-d9023a77d5c1"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:08:00+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:58:28+09:00"
---
# 設定から生成した model.yaml と sara.toml が設定や組み込みの定義と食い違うか、--check が差分を見逃す

## リスク

`model` が設定ファイルから生成する `model.yaml` と `sara.toml` が、設定や組み込みの定義と食い違う懸念である。
[model.yaml と sara.toml は設定ファイルから生成し、生成物との差分を確かめる](../requirements/model-and-sara-toml-generated-from-config.md)
が生成と差分の確かめを求め、生成物が何を含むかを次の要件が定める。失敗の向きは次のものがある。

- [組み込みの型は 12 型で、すべて必須とする](../requirements/twelve-builtin-types.md): 生成したモデルから組み込みの型が欠ける
- [組み込みの relation は上流の 8 つと peer の 3 つとし、保証する連鎖は requirement → risk → test_condition → test_case とする](../requirements/builtin-relations-and-guaranteed-chain.md):
  relation の張り元と張り先の型を誤るか、design を連鎖の必須の中継点にする
- [specification は英語で必須とし、ほかの言語のフィールドは設定から生成する](../requirements/specification-languages.md):
  設定で選んだ言語の `specification_<言語>` と `name_<言語>` を生成しない
- [テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く](../requirements/test-categories-from-config.md):
  risk の `section` の値を区分の一覧と違えて生成する
- `model --check` が、コミットした生成物と生成し直した結果の差分を見逃す

最も重い向きは、`--check` が差分を見逃し、設定と食い違うモデルで検査が続く向きで、この risk はこの向きで
採点する。食い違うモデルでも sara は読み込めるので、誤りは検査の結果がずれる形でしか表に出ない。設定が
組み込みの定義を変えられてしまう懸念は
[設定が組み込みの型・relation・フィールドや、likelihood・impact・level の値の集合を削除または変更できる](config-alters-builtin-definitions.md)
が持ち、この risk は生成の誤りだけを持つ。

## 実現性

likelihood は high とした。変わりやすさは高い。生成物は 12 の型、11 の relation とその張り元と張り先、
言語ごとのフィールド、区分の一覧から導く値を含み、分岐が多い。見逃しやすさも高い。mitodoke 自身の
`docs/model.yaml` は手で書いたもので、写した契約テストは設定からの生成も `model --check` も確かめていない。

impact は medium とした。食い違うモデルでの検査は出荷物の誤動作だが、生成を直して生成し直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
