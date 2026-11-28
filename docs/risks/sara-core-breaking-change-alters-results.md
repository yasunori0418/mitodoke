---
id: "RISK-afb7a2bc-0438-478a-b957-e1adda830c90"
type: risk
name: "sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる"
description: "sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる"
likelihood: high
impact: medium
level: high
quality_characteristic: maintainability
section: foundation
status: stable
threatens:
  - "DSG-a5468c87-cf5a-4d27-b261-d22a083a6ff0"
  - "REQ-1477f1b9-06c6-4f55-8bce-7239bba01d9c"
  - "REQ-4ac9181f-5394-4617-b05e-be2387228008"
  - "REQ-7ec90232-7ec2-414a-a95e-af8d6994340b"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-27T09:15:31+09:00"
verified:
  - by: "human:yasunori0418"
    at: "2026-11-28T20:52:18+09:00"
---
# sara-core の破壊的変更で、読み込みと検査の結果が気づかないうちに変わる

## リスク

組み込む sara-core の版を上げたときに、その破壊的変更で読み込みと検査の結果が変わり、それに気づかない
懸念である。外部への依存の risk で、次の要件を脅かす。

- [1 つの CLI が、サブコマンドごとに入力・出力・exit code を定める](../requirements/single-cli-subcommand-contracts.md):
  サブコマンドが定めた出力と exit code が、sara-core の振る舞いの変化で黙って変わる
- [export は文書 1 件を item とし、sara 0.12 の items[] の形に OKF のキーを加えて出す](../requirements/export-shape.md):
  sara の形が変わっても export の形を自動で変えない、という規則が、sara-core の型の変化を通じて破れる
- [Nix flake で配り、組み込む sara-core と同じタグの sara の CLI を一緒に配る](../requirements/distribution-by-nix-flake.md):
  sara-core を上げたときに、mitodoke と一緒に配る sara の CLI の検査と結果が食い違う

どの向きも、利用者が誤った検査の結果を受け取る点で同じ重さである。API の型を変えない振る舞いの変化は
コンパイルを通るので、誤りは表に出ない。flake が別のタグの sara の CLI を配る梱包の誤りは
[flake が、組み込んだ sara-core と違うタグの sara の CLI を配る](flake-ships-mismatched-sara-cli.md)
が持つ。

[sara-core を使う箇所を 1 つのモジュールに集める](../design/sara-core-confined-to-one-module.md) への辺は、
追随の範囲を 1 つのモジュールに集める設計に固有の面を指す。この設計は API の変化をそのモジュールの
コンパイルの失敗に集めるが、型の変わらない意味の変化はそのモジュールを素通りする。

## 実現性

likelihood は high とした。変わりやすさは高い。sara は 0.x の版で、版を上げるたびに読み込みと検査の
振る舞いが変わりうる。見逃しやすさも高い。写した契約テストは sara の CLI を呼ぶもので、sara-core を
組み込んだときの結果が版をまたいで変わらないことを確かめていない。

impact は medium とした。誤った検査の結果は出荷物の誤動作だが、版を戻すか追随して再ビルドすれば回復
できる。

この採点は CLI のコードが無い時点での読み替えによるもので、実装が進んだら採点し直す。
