---
id: "RISK-6dc9612e-725d-4531-91f8-e915194ea1dd"
type: risk
name: "new が置き場所の不一致、設定に無い区分、description の無い起票を受け付ける"
description: "new が置き場所の不一致、設定に無い区分、description の無い起票を受け付ける"
likelihood: low
impact: medium
level: low
quality_characteristic: functional_suitability
section: authoring
status: stable
threatens:
  - "REQ-a69171a6-7587-4d92-8fce-1cf84d62b36f"
  - "REQ-d740fa25-bd04-4f84-847f-1f9c842f72d4"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# new が置き場所の不一致、設定に無い区分、description の無い起票を受け付ける

## リスク

`new` が拒むべき起票を受け付ける懸念である。失敗の向きは次の 3 つある。

- [new は引数の置き場所を型ごとの置き場所と比べ、合わなければ起票を拒む](../requirements/new-location-check.md)
  が破れ、型ごとの置き場所と合わない置き場所に起票する
- 同じ要件が破れ、test_condition と test_case を `docs/test/<区分>/` の形でない置き場所か、設定に無い区分に
  起票する
- [OKF の定義に重ねて、verified のリスト限定など 5 つの制約を検査する](../requirements/constraints-on-top-of-okf.md)
  が `new` に課す制約が破れ、`description` の無い起票を受け付ける

最も重い向きは、`description` の無い起票を受け付ける向きで、この risk はこの向きで採点する。`check` は
既存の item の `description` の欠けを違反にしないので、`new` が通すと、欠けはどの検査にも掛からずに残る。
置き場所の不一致と設定に無い区分は、`check` が型と置き場所の一致を構造の契約として確かめるので、CI で
見つかる。`check` がこの一致を見逃す懸念は
[check が構造の契約の違反を見逃すか、deprecated の item に構造の契約を働かせない](structural-violation-passes-check.md)
が持つ。

## 実現性

likelihood は low とした。変わりやすさは低い。規則は、置き場所を型ごとの置き場所の表と比べること、区分を
設定の一覧と比べること、`description` の有無を見ることの 3 つの照合で、`new` だけが使う。見逃しやすさは
高い。写した `dev/tests/sara-new.sh` は `description` の無い起票を拒むことを確かめているが、写した
`dev/scripts/sara-new.sh` は無い置き場所のディレクトリを作って起票するので、置き場所と区分の照合は
確かめていない。変わりやすさと見逃しやすさの片方だけが高いときは medium とする読み替えの規則に当てると
medium になる。それでも low としたのは、最も重い向きの `description` の拒否を契約テストが確かめていて、
確かめていない置き場所と区分の照合は、`new` が見逃しても `check` の構造の契約が CI で見つけるためである。

impact は medium とした。誤った置き場所の item や `description` の無い item は出荷物の誤動作だが、
ファイルを動かすか `description` を書き足せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
