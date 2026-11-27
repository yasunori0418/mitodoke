---
id: "RISK-30c42d07-666a-4ed2-904f-4be233bf35c6"
type: risk
name: "index の見出しと並びが置き場所と区分の表と食い違うか、--check が差分を見逃す"
description: "index の見出しと並びが置き場所と区分の表と食い違うか、--check が差分を見逃す"
likelihood: low
impact: medium
level: low
quality_characteristic: functional_suitability
section: authoring
status: stable
threatens:
  - "REQ-058df54b-eeb6-4074-9c9f-c303bd6d3273"
  - "REQ-5c52b41a-9015-4c68-8143-b813f13064fa"
  - "REQ-9ab110e1-6a93-4c21-b5c3-d9023a77d5c1"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:28:24+09:00"
---
# index の見出しと並びが置き場所と区分の表と食い違うか、--check が差分を見逃す

## リスク

`index` が生成する `index.md` が、設定の表から導くはずの形と食い違う懸念である。失敗の向きは次の 3 つある。

- [item の置き場所は、設定に持つ型ごとの置き場所と一致しなければならない](../requirements/type-locations-in-config.md)
  が型ごとの index の見出しを同じ置き場所の表から決めることに反し、見出しが表と食い違う
- [テストの区分は設定で決め、置き場所・risk の section・index の見出しを導く](../requirements/test-categories-from-config.md)
  が区分ごとの見出しを区分の一覧から導くことに反し、区分の節が欠けるか、一覧に無い節が出る
- [サブコマンドは init・new・gap・fresh・index・matrix・model・verify・export・check とする](../requirements/subcommand-set.md)
  の `index --check` が、生成した結果とコミットされた `index.md` の差分を見逃し、exit code 0 で終わる

最も重い向きは、`--check` が差分を見逃す向きで、この risk はこの向きで採点する。見逃すと、置き場所や
区分を変えたあとの古い `index.md` が CI を通って残り、利用者は古い一覧から item を探すことになる。
見出しと並びの食い違いは、生成した `index.md` を読めば分かる。

## 実現性

likelihood は low とした。変わりやすさは低い。この risk が扱う規則は、見出しを置き場所と区分の表から引く
ことと、生成した結果をコミットされたファイルと比べることで、`index` だけが使う。見逃しやすさも低い。
写した `dev/tests/okf-index.sh` は、`docs/test/` の区分の節、risk を区分の節に分けること、表に無い
`section` の値で生成を止めること、ファイル名順の並び、`--check` が食い違うパスを出して exit code 1 で
終わることを確かめている。

impact は medium とした。古い `index.md` は出荷物の誤動作だが、生成し直せば回復できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
