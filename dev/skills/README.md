# dev/skills

mitodoke 自身の開発で使うスキルの正本。default の開発シェルに入ると、layat が各スキルを `.claude/skills/<名前>` へ
配置する（設定は `dev/layat.nix`）。

## 暫定のスキル

次の 2 本は暫定で置いている。mitodoke の開発で使いながら直し、後続の作業の中で詳細化を検討する。

- `term-record`: 決まった用語を台帳へ記録する
- `term-apply`: 台帳の語を用語 item にする

### 詳細化を検討する点

- `section` の値の決め方。いまは `docs/model.yaml` の enum から選び、合う値が無ければ利用者に訊くだけにしている
- コマンドの呼び出し方。CLI ができたら、`term-apply/references/commands.md` を CLI のサブコマンドに置き換える
- 文書管理の基盤のスキルとの分担。用語 item の書式の説明を、いまは `term-apply` が持っている
- 名前と配り方。ほかのリポジトリへ配るか、配るなら名前に接頭辞を付けるか
- 台帳の置き場所と書式。いまはリポジトリに 1 つの `tmp-agents/terms.md`
- `term-apply` の起動の仕方。いまは明示の起動だけで、PR を作る側からは未処理の語を検出しない
- 避ける綴りを既存の文書で直す手順。実際の違反ではまだ試していない
