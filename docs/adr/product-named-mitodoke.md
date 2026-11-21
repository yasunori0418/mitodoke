---
id: "ADR-89699b1a-3fe6-4358-aa5d-9702c6005a8d"
type: adr
name: "製品名を mitodoke にする"
description: "製品名を、日本語の見届けに由来する mitodoke にし、製品名を含む名前をすべてこの名前から決める"
section: product-scope
status: stable
sources:
  - id: "issue-4"
    resource: "https://github.com/yasunori0418/mitodoke/issues/4"
    title: "#4"
origin: "2026-11-17 の grilling（Q51）で確定"
justifies:
  - "REQ-d7a8bbab-8ca2-4d3e-b20b-0f845c370283"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-21T16:45:54+09:00"
---
# 製品名を mitodoke にする

- ステータス: stable
- 日付: 2026-11-17
- 関連: GitHub Issue #4
- 起点: 2026-11-17 の grilling（Q51）で確定

## 背景

製品は当初 `qascade`（Quality と Cascade の造語）と呼んでいた。決定がそろったところで、
利用者はこの名前が適切かを見直すよう求めた。条件は、GitHub や既存のプロダクトと名前が
重ならないこと、決定の内容と製品の働きを名前から思い浮かべられることだった。途中で、命名を
UNIX 哲学に合わせることも加わった。候補を比べる側は、これを「何をする道具かを名前が言う」
ことと読み、比べる観点の 1 つにした。

候補を何度か足して比べたあと、利用者は cascade の観点を外して比べ直すよう求めた。concept の
cascade の比喩を引き継げることと、変更の波及を名前で言えることを、加点に使わないという
ことである。この条件で、残った候補から製品名を 1 つ決める必要があった。

## 決定

製品名を `mitodoke` にする。由来は日本語の「見届け」（最後まで見て確かめること）である。

製品名を含む名前は、すべて `mitodoke` から決める。設定ファイル `mitodoke.yaml`、コマンド
`mitodoke <サブコマンド>`、環境変数 `MITODOKE_GENERATED_BY`、コード `E_MITODOKE_<契約名>`・
`W_MITODOKE_<契約名>`、crate と flake の出力の名前、GitHub のリポジトリ名がこれにあたる。

## 根拠

`mitodoke` は、人が品質の責任を果たすのを支えるという concept §4.1 と §12 に近い。見届ける
のは人で、mitodoke はそれを支える側に立つ。8 文字で、crates.io・npm・PyPI・repology・
GitHub・Web 検索のどこにも重ならない。

代償として、日本語を知らない人には名前から意味が伝わらない。README などで意味を添える
必要がある。

## 棄却した代替案

### `qtrail`

推奨だった案。品質の判断の足跡を表し、要求から risk・テストまでの記録の連なりを保つという、
製品全体の役割に近い。綴りと読みが迷いにくく、英語なので日本語を知らない人にも伝わり、
どこにも重ならない。弱点は、q で始まる QA ツールの名前（qTest・qTrace・QaTraq など）が多い
分野に並ぶことだった。利用者は一度この案を選んだあと、concept の「人が責任を持つ」に近い
`mitodoke` に改めた。

### `qascade`

当初の名前。同じ名前の製品は無いが、綴りの近い企業 qashqade と、Cascade という名前の製品が
複数ある。利用者は `qascade` 以外の候補を求め、`qascade` も候補に残したまま比べた。cascade の
観点を外して比べ直すと、Quality と Cascade という名前の由来を加点に使えなくなる。

### `reviewdue`

見直しの時期が来ていることを表す。英語で伝わり、重なりも無い。ただし言うのは再確認待ちの
報告という働きの 1 つだけで、起票のサブコマンドと組み合わせると、名前と働きがずれる。

### `minaoshi`

見直しを日本語でそのまま言う。働きの 1 つだけを言う点は `reviewdue` と同じで、日本語を知らない
人には伝わらない。同名の organization と、スター 0 のリポジトリ 2 件がある。

### `trascade`

trace と cascade の造語。「トラス」が建築や土木のトラス構造を連想させ、cascade を意識した
「ケード」が何を指すのか分かりにくいと、利用者が指摘した。

### `sujime`

短いが、あまり聞かない日本語なので、意味は通っても意味まで連想できないと、利用者が判断した。
