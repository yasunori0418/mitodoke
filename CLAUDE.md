# CLAUDE.md

mitodoke は、ソフトウェア開発における品質に関する判断の成果物を構造化し、上流の変更で再確認が要る下流の成果物を検出して、人間が品質に責任を持つことを支える品質支援プラットフォーム。製品の考え方は [docs/mitodoke-concept.ja.md](docs/mitodoke-concept.ja.md)（英語版 [docs/mitodoke-concept.md](docs/mitodoke-concept.md)）、現状は [README.ja.md](README.ja.md)。

## Agent skills

### Issue tracker

Issue は GitHub Issues で管理し、`gh` コマンドで操作する。tracking・epic・sub-issue・defect の運用は
`docs/agents/issue-tracker.md`。

### Triage labels

トリアージのラベルは `needs-triage` / `needs-info` / `ready-for-agent` / `ready-for-human` / `wontfix` の 5 つ。
意味と、構造ラベル（`tracking` / `epic` / `task`）・種別のラベル（`bug` / `documentation` /
`enhancement`）・欠陥の分類のラベル（`risk-expected` / `risk-unexpected`）は `docs/agents/triage-labels.md` が持つ。
