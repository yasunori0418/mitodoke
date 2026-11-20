# コマンドの呼び出し方

`term-apply` が使うコマンドを 1 か所に集める。コマンドの名前と呼び出し方が変わったら、このファイルだけを直す。

どのコマンドも、リポジトリのルートで実行する。`sara`・`sara-new`・`sara-fresh` と検査に使う道具は、dev flake の
`sara` シェルにある。次の前置きを付けて呼ぶ。以下では `<sara>` と書く。

```bash
nix develop '.?dir=dev#sara' -c
```

## 起票

```bash
SARA_NEW_GENERATED_BY='claude-code/<モデル ID>' <sara> sara-new ubiquitous_term <slug> docs/ubiquitous-language -- \
  --name '<name>' --description '<日本語の 1 文の要約>' --section '<section>' --status stable \
  [--name-ja '<name_ja>'] [--avoid '<綴り>' ...]
```

- `SARA_NEW_GENERATED_BY` は必須。人が起こすなら `human:<GitHub ID>` にする。
- `--avoid` は綴り 1 つごとに繰り返す。
- 出力は `id:` と `file:` の 2 行。`file:` のファイルの本文を書き直す。

## 索引の生成

```bash
<sara> bash dev/scripts/okf-index.sh
```

## 検査

```bash
<sara> sara check
<sara> bash dev/scripts/okf-index.sh --check
<sara> bash dev/tests/okf-frontmatter.sh
<sara> bash dev/tests/link-text.sh
<sara> bash dev/tests/term-avoid.sh
```

どれも exit 0 で通過。`term-avoid.sh` は、用語 item の `avoid` の綴りが `docs/`（`docs/adr/` と
`docs/ubiquitous-language/` を除く）・README・AGENTS.md の散文に無いことを確かめる。frontmatter は見ない。

## 避ける綴りの全文検索

`term-avoid.sh` が見ない frontmatter も含めて探す。綴りごとに実行する。

```bash
rg -n -F '<綴り>' docs README.md README.ja.md AGENTS.md -g '!docs/adr/**' -g '!docs/ubiquitous-language/**'
```

## generated の更新漏れの確認

```bash
<sara> sara-fresh --base <親のブランチ>
```

`generated` の更新漏れの節に item が挙がらなければよい。再確認待ちの節に下流の item が挙がるのは、そのままにする。
exit 1 は、どれかの節に item があることを表す。

## 現在の時刻（generated.at に書く値）

```bash
date --iso-8601=seconds
```
