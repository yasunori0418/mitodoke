---
id: "RISK-53ac6801-326d-4313-90e6-077500b20891"
type: risk
name: "テスト資産の一覧の重複、除外、種別を読み誤り、test_case との 1:1 と対応表が狂う"
description: "テスト資産の一覧の重複、除外、種別を読み誤り、test_case との 1:1 と対応表が狂う"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: inspection
status: stable
threatens:
  - "REQ-3e39ec3b-6f45-4b66-a31a-0b9d489a0076"
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:50:03+09:00"
---
# テスト資産の一覧の重複、除外、種別を読み誤り、test_case との 1:1 と対応表が狂う

## リスク

[テスト資産の一覧は設定のコマンドとファイルから読み、併用した一覧の重複は失敗とする](../requirements/test-asset-inventory-sources.md)
が破れ、テスト資産の一覧を読み誤る懸念である。失敗の向きは次の 4 つある。

- 複数の出どころから同じ資産識別子が出たときに失敗にせず、片方を黙って捨てる
- 設定で外した資産を一覧に残すか、外していない資産を落とす
- タブ区切りの行の種別やテスト名を読み誤り、手順書とテストチャーターをほかの資産と混ぜる
- 資産識別子の表記を test_case の `resource` と揃えずに読み、対応が付かない

[サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md)
への辺は、この一覧を使う `matrix` の対応表と、`check` の構造の契約のうち test_case とテスト資産の 1:1 と
テスト資産の重複を指す。

最も重い向きは、重複や除外を読み誤って test_case との 1:1 を誤る向きで、この risk はこの向きで採点する。
落とした資産には test_case が無くても欠けとして挙がらず、`matrix` の対応表からも消えるので、誤りは表に
出ない。

## 実現性

likelihood は medium とした。変わりやすさは高い。出どころはコマンドとファイルをそれぞれ複数持て、合わせて
1 つにする規則、除外、種別の値があり、`matrix` と `check` が同じ一覧を使う。見逃しやすさも高い。写した
`dev/tests/test-doc-map.sh` が合成フィクスチャで両側へ倒して確かめているのは、1:1、`resource` が実在する
資産を指すこと、除外リストを通る経路を含めて全資産に test_case があることである。除外の理由・実在しない
資産の除外・除外と test_case の排他は、実データに当てるだけである。写した
`dev/scripts/test-inventory.sh` は資産を出さない骨組みで、複数の出どころの重複と種別は確かめていない。
両方が高いときは high とする読み替えの規則に当てると high になる。それでも medium としたのは、出どころを
合わせた一覧での重複は、両側へ倒して確かめている 1:1 の判定と同じ形の一意性の判定で確かめられるためである。

impact は medium とした。狂った対応表は出荷物の誤動作だが、一覧を直して再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
