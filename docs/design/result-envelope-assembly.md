---
id: "DSG-b70a4bcf-fa63-4b19-a123-1076b32df625"
type: design
name: "結果エンベロープを outturn のモジュールで組み立てる"
description: "outturn のモジュールが outturn の crate を使って結果エンベロープを組み立て、subject・item と警告・kind とコード・changes と dryRun と label・info への記録を決まった形にし、text 出力もその結果から英語で作る"
section: product-scope
status: stable
satisfies:
  - "REQ-d97dc7f2-36d9-4677-ab39-5cae92843bc5"
  - "REQ-ebc63f3a-1d6f-4001-9f74-ce7157371cd7"
  - "REQ-0abd8c28-b3ef-46ee-b111-bd5bd38e4e89"
  - "REQ-ecc41a24-b465-4ab9-ba1b-e56dc5f8a17c"
generated:
  by: "claude-code/claude-opus-5-5"
  at: "2026-11-23T19:36:10+09:00"
---
# 結果エンベロープを outturn のモジュールで組み立てる

## 設計

どのサブコマンドの結果も、outturn のモジュールが outturn のエンベロープとして組み立てる。`--json` の
出力はこのエンベロープで、既定の text 出力もこのエンベロープの結果から作る。サブコマンドのモジュールは、
エンベロープも text 出力も自分で組み立てない。

### outturn の crate の使い方

outturn の Rust の crate を、outturn の側に作って使う。crate は、エンベロープの型と、item の `id` の
導出（`kind` と `key` の組を JCS で正準化して sha256 を取る手順）を持つ。mitodoke の outturn の
モジュールは、この crate を使い、mitodoke のコードと text 出力だけを自分で持つ。mitodoke は crate に
git のコミットで依存し、outturn にタグができたらタグに切り替える。

### subject

エンベロープの `results[]` の要素は、どのサブコマンドでも常に 1 つにし、その `subject.name` は固定の
文字列 `documents` にする。item はすべて、この 1 つの要素に置く。

### item と警告の表し方

`check`・`gap`・`fresh` の item は、1 つの文書と 1 つの契約の組（`gap` と `fresh` では文書と節の組）を
単位にする。その実行で指摘に働く強さは、その指摘がその実行の exit code を 0 でなくするかで決める。

| 組が持つ指摘 | item の `status` | 指摘を置く場所とコード |
|---|---|---|
| 失敗の指摘を持つ | `failed` | `error` に `E_MITODOKE_<契約名>` |
| 報告の指摘だけを持つ | `success` | `warnings` に `W_MITODOKE_<契約名>` |
| 成り立った | item にしない | なし |

- 単体の `gap` と `fresh` では、該当した組はすべて失敗で、該当した組があれば exit 1 で終える
- `check` は強さの設定に従う。報告の指摘だけなら exit 0 で、`status` は `success` になる
- `gap` の情報の節（`risk_exempt` を持つ要件の一覧と、`human_judgement` を持つテスト条件の一覧）と
  到達率は、item にせず `result.info` に置く

### kind とコードの書き方

item の `kind` は、契約名を小文字のスネークケースで書く。コードは、同じ契約名を大文字にして、
`E_MITODOKE_` か `W_MITODOKE_` の接頭辞を付ける。同じ指摘はどちらの強さでも同じ契約名を持ち、強さの設定で
切り替わるのは接頭辞だけである。sara の検証の種類から契約名への割り当ての表は、sara-core を呼ぶ
モジュールが持ち、outturn のモジュールはその契約名を受け取って `kind` とコードを作る。

### changes・dryRun・label

| サブコマンド | item | `dryRun` | `changes[]` |
|---|---|---|---|
| ファイルを書く `new`・`init`・`index`・`model`・`verify` | 書いたファイル 1 つを item 1 つにする | `false` | `add` か `modify` を並べる |
| `index` と `model` の `--check` | 差分のあるファイルを `failed` の item にし、差分があれば exit 1 で終える | `true` | 書くはずだった変更を並べる |
| 読むだけの `check`・`gap`・`fresh`・`matrix`・`export` | 契約と文書の組、または節と文書の組 | `true` | 出さない |

`label` はすべての item に付ける。文書を表す item の `key` は文書の ID で、`label` は文書の `name` に
する。文書の ID を持たない item（読み飛ばされたファイル、書いたファイル）の `key` と `label` は、
設定ファイルのあるディレクトリからの相対パスにする。

### info への記録

- 実行時の作業ディレクトリは、エンベロープの `workingDirectory` に出し、`info` には書かない
- 読んだ設定ファイルの絶対パスは、`--config` で指したときも省いたときも、トップレベルの `info` に記録する
- 環境変数 `MITODOKE_GENERATED_BY` から取った値と、設定のコマンドの出力から作った人の識別子も、
  トップレベルの `info` に記録する
- `info` のキーは、outturn のフィールドに合わせてキャメルケースにする

### text 出力の言語

既定の text 出力の見出しと、診断の文は、英語に固定する。item の `name` と `description` は、書かれた
言語のまま出す。言語を切り替える仕組みは持たない。

## 出典

根拠の決定は次の ADR が持つ。

- [outturn の Rust の crate を outturn の側に作って使う](../adr/outturn-rust-crate-provided-by-outturn.md)
- [エンベロープの subject は固定の documents 1 つにする](../adr/envelope-subject-fixed-to-documents.md)
- [報告の指摘は success の item の警告で表し、働く強さは exit code で決める](../adr/report-findings-as-success-items-with-warnings.md)
- [sara の検証の種類ごとに契約名を割り当て、kind とコードを契約名から導く](../adr/contract-name-per-sara-validation-kind.md)
- [changes・dryRun・label はファイルを書くかで分け、ID の無い item はパスで表す](../adr/envelope-changes-dry-run-label-and-path-keys.md)
- [作業ディレクトリは workingDirectory に出し、設定ファイルのパスは常に info に記録する](../adr/working-directory-field-and-config-path-always-recorded.md)
- [text 出力の見出しと診断の文を英語に固定する](../adr/text-output-and-diagnostics-in-english.md)
- [サブコマンドの --json は outturn のエンベロープにし、standalone まで適合させる](../adr/json-output-conforms-to-outturn.md)
