---
id: "RISK-9aa5aa6a-bb4e-4249-af5b-4df0c1ce18a7"
type: risk
name: "flake が、組み込んだ sara-core と違うタグの sara の CLI を配る"
description: "flake が、組み込んだ sara-core と違うタグの sara の CLI を配る"
likelihood: medium
impact: medium
level: medium
quality_characteristic: compatibility
section: distribution
status: stable
threatens:
  - "REQ-7ec90232-7ec2-414a-a95e-af8d6994340b"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T10:13:15+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:58:48+09:00"
---
# flake が、組み込んだ sara-core と違うタグの sara の CLI を配る

## リスク

[Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配る](../requirements/distribution-by-nix-flake.md)
が破れる懸念である。失敗の向きは次の 2 つある。

- flake が、組み込んだ sara-core と違うタグの sara の CLI を配る
- flake が sara の CLI を配らない

最も重い向きは、違うタグの CLI を配る向きで、この risk はこの向きで採点する。どちらのコマンドも動くので、
mitodoke の検査と sara の CLI の検査の結果が食い違っても、利用者はそれを版のずれと結び付けにくい。
CLI を配らない向きは、コマンドが見つからないので実行した時点で気づける。sara-core の版を上げたことで
mitodoke 自身の結果が変わる懸念は
[sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる](sara-core-breaking-change-alters-results.md)
が持つ。

## 実現性

likelihood は medium とした。変わりやすさは低い。採点した向きの規則は、配る CLI の版を組み込む sara-core
と同じタグにすることだけで、分岐を持たない。見逃しやすさは高い。いまの `flake.nix` は mitodoke の
出力をまだ持たず、配る CLI と組み込む sara-core のタグが同じかを確かめる契約テストも無い。

impact は medium とした。食い違う検査の結果は出荷物の誤動作だが、版を揃えた flake を出し直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
