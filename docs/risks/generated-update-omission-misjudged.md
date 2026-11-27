---
id: "RISK-9ed4873c-9822-4f24-bcee-279cc363b2cf"
type: risk
name: "generated の更新漏れで、本文に数える範囲か、基準のリビジョンが無い実行の扱いを誤る"
description: "generated の更新漏れで、本文に数える範囲か、基準のリビジョンが無い実行の扱いを誤る"
likelihood: medium
impact: medium
level: medium
quality_characteristic: functional_suitability
section: freshness
status: stable
threatens:
  - "REQ-da3bf704-20f3-4c26-bd7a-c25adb45b733"
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# generated の更新漏れで、本文に数える範囲か、基準のリビジョンが無い実行の扱いを誤る

## リスク

generated の更新漏れ（基準のリビジョンとの差分で本文が変わったのに `generated.at` が変わっていない item）の
判定を誤る懸念である。
[検査の既定の強さは、構造の契約を失敗、つながりの欠けと見直しの義務を報告とし、設定で変えられる](../requirements/default-inspection-strength.md)
と
[サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md)
は、同じ規則で本文の範囲と基準のリビジョンが無い実行を定める。失敗の向きは次の 4 つある。

- `specification` と `specification_<言語>` の変更を本文に数えず、更新漏れを見逃す
- `name`・`description`・`status`・relation・OKF のキーの変更を本文に数え、余分に報告する
- `generated.at` の表記だけを書き換えて同じ時刻を指すときに、`generated.at` が変わったとみなし、
  更新漏れを見逃す
- 基準のリビジョンを渡さない実行で、検査しなかったことを `check` と `fresh` の結果に記録しない

最も重い向きは、本文の変更を数えずに更新漏れを見逃す向きで、この risk はこの向きで採点する。見逃した
item は報告に出ないので、本文を変えたのに再確認を促さないまま下流が古い前提に立ち続ける。検査しなかった
ことを記録しない向きは、更新漏れが無いという誤った安心を与えるが、基準のリビジョンを渡せば見つかる。

## 実現性

likelihood は medium とした。変わりやすさは高い。本文に数える範囲、数えない frontmatter のキー、時刻の
表記の扱い、基準のリビジョンが無い実行と分岐が多く、`check` と `fresh` が同じ規則を使う。見逃しやすさは
低い。写した `dev/tests/sara-fresh.sh` は、本文を変えて `generated.at` を据え置いた item、frontmatter だけ・
H1 だけ・空白だけの変更、新規と削除と改名、未コミットの変更、merge-base との比較、`--base` が無ければ
節を出さないことを確かめている。`specification` の変更、時刻の表記だけの書き換え、検査しなかったことの
記録は確かめていない。

impact は medium とした。誤った更新漏れの報告は出荷物の誤動作だが、直した版で再実行すれば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
