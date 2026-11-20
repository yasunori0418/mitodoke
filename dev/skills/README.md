# dev/skills

mitodoke 自身の開発で使うスキルの正本。default の開発シェルに入ると、layat が各スキルを `.claude/skills/<名前>` へ
配置する（設定は `dev/layat.nix`）。

## 暫定のスキル

次の 3 本は暫定で置いている。mitodoke の開発で使いながら直し、後続の作業の中で詳細化を検討する。

- `sara-docs`: 文書管理の基盤の規約（型・relation・ID・`specification`・コマンドの使い方）。layat の `97ec53ae` の
  同名のスキルを写し、mitodoke に合わない記述だけを直した。layat とは同期しない
- `term-record`: 決まった用語を台帳へ記録する
- `term-apply`: 台帳の語を用語 item にする。用語 item の書式は `sara-docs/references/ubiquitous-language.md` が持つ

### 詳細化を検討する点

- `section` の値の決め方。いまは `docs/model.yaml` の enum から選び、合う値が無ければ利用者に訊くだけにしている
- コマンドの呼び出し方。CLI ができたら、`term-apply/references/commands.md` を CLI のサブコマンドに置き換える
- `sara-docs` の名前と中身。工程スキル（テスト計画・テスト分析）がまだ無く、コマンドの説明は script の名前のままになっている
- `sara-docs` と `term-apply` のコマンドの説明の重なり（`sara-docs/references/sara-cli.md` と `term-apply/references/commands.md`）
- 名前と配り方。ほかのリポジトリへ配るか、配るなら名前に接頭辞を付けるか
- 台帳の置き場所と書式。いまはリポジトリに 1 つの `tmp-agents/terms.md`
- `term-apply` の起動の仕方。いまは明示の起動だけで、PR を作る側からは未処理の語を検出しない
- 避ける綴りを既存の文書で直す手順。実際の違反ではまだ試していない
