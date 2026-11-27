---
id: "RISK-2dac132a-a227-45b8-94f7-21c3492c0f8d"
type: risk
name: "README の workflow の例が動かなくなるか、mitodoke 自身の CI と食い違う"
description: "README の workflow の例が動かなくなるか、mitodoke 自身の CI と食い違う"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: distribution
status: stable
threatens:
  - "REQ-af47f52f-4ff5-4298-8746-6b5e8b76ce52"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:13:16+09:00"
---
# README の workflow の例が動かなくなるか、mitodoke 自身の CI と食い違う

## リスク

[CI 連携は CLI と workflow の例で提供する](../requirements/ci-integration-form.md) が破れる懸念である。
失敗の向きは次の 2 つある。

- README の workflow の例が、Nix での入れ方かサブコマンドの引数の変化に追随せず、写しても動かない
- mitodoke 自身の CI が、例と違う形で動く

最も重い向きは、例が動かなくなる向きで、この risk はこの向きで採点する。例を写した適用先の製品の CI が
落ちるか、`mitodoke fresh --base` の段が働かないまま通る。自身の CI が例と食い違う向きは、例を動かして
確かめる手段が失われることで、それだけでは利用者に届かない。

## 実現性

likelihood は medium とした。変わりやすさは低い。採点した向きの規則は、Nix で入れて `mitodoke check` を
実行し、pull request のときだけ `mitodoke fresh --base` を加えることで、分岐は pull request かどうかの
1 つである。見逃しやすさは高い。README にはまだ workflow の例が無く、自身の CI は `sara check` を
動かしていて、例を実行して確かめる手段も、例と自身の CI を突き合わせる契約テストも無い。

impact は medium とした。動かない例は出荷物の誤動作だが、例を直せば適用先の製品は写し直して回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
