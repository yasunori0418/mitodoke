---
id: "RISK-e25dd3d2-11ce-4468-b7cd-c084d04fdcf1"
type: risk
name: "init が既存の mitodoke.yaml を上書きするか、規範を適用先へ複製する"
description: "init が既存の mitodoke.yaml を上書きするか、規範を適用先へ複製する"
likelihood: low
impact: high
level: medium
quality_characteristic: reliability
section: config-model
status: stable
threatens:
  - "REQ-ba6cb998-94a0-4806-bd9a-db9a83484991"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:20:24+09:00"
---
# init が既存の mitodoke.yaml を上書きするか、規範を適用先へ複製する

## リスク

[init は初期の mitodoke.yaml と型ごとの置き場所のディレクトリを作り、既存の mitodoke.yaml を上書きしない](../requirements/init-creates-config-and-directories.md)
が破れる懸念である。失敗の向きは次の 2 つある。

- すでにある `mitodoke.yaml` を、拒まずに初期の内容で上書きする
- mitodoke の文書管理の規範を、適用先の製品へ複製する

最も重い向きは、既存の `mitodoke.yaml` を上書きする向きで、この risk はこの向きで採点する。上書きは
`init` が成功で終わるので、利用者が設定の中身を開くまで誤りは表に出ない。複製された規範は、適用先の製品が
mitodoke の規範を自分のものと取り違える原因になるが、ファイルを消せば戻せるので軽い向きである。

## 実現性

likelihood は low とした。変わりやすさは低い。規則はファイルがあるかの 1 つの分岐で、`init` だけが使う。
見逃しやすさは高い。`init` に当たる契約テストはまだ無い。変わりやすさと見逃しやすさの片方だけが高い
ときは medium とする読み替えの規則に当てると medium になる。それでも low としたのは、既存のファイルを
上書きせずに落ちることを `dev/tests/sara-new.sh` が起票について確かめていて、同じ確かめ方を `init` に
そのまま写せるためである。

impact は high とした。上書きは利用者の環境の実データを壊し、`mitodoke.yaml` がコミット前の変更を持って
いれば、再実行では回復できない。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
