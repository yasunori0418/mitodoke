# mitodoke

*Read this in [Japanese (日本語)](README.ja.md).*

> **mitodoke** — helps people see quality decisions through, from requirements to implemented test cases.

mitodoke is a quality-support platform for software development. It structures the
artifacts through which people reason about quality (requirements, design, risks, test
conditions, test plans, and test cases), makes the relationships between them traceable,
and detects downstream artifacts that need renewed human review after an upstream change.

mitodoke does not guarantee quality on anyone's behalf. People judge, decide, review, and
take responsibility; mitodoke identifies, connects, compares, and reports.

> **Status: design phase (provisional README).** The design has been settled, but nothing
> is implemented yet. This repository currently contains only the Nix flake, the
> development shell, and CI. Everything under [Planned shape](#planned-shape) may change.

## The name

*mitodoke* comes from the Japanese word **見届け**: to watch something through to the end
and confirm it with one's own eyes. The one who sees things through is a person, not the
tool. mitodoke supports that act by showing what remains to be confirmed and recording
what a person has confirmed.

## Planned shape

- **A single CLI written in Rust** that embeds [SARA](https://github.com/cledouarec/sara)'s
  `sara-core` as a crate.
- **A configuration file, `mitodoke.yaml`**, from which the SARA model (`model.yaml`) and
  `sara.toml` are generated and committed.
- **Subcommands**: `new`, `gap`, `fresh`, `index`, `matrix`, `model`, `verify`, `export`,
  and `check`. `--json` output follows the [outturn](https://github.com/yasunori0418/outturn)
  result envelope.
- **Document-management norms and agent skills** (`mitodoke-docs`, `mitodoke-test-plan`,
  `mitodoke-test-analyze`) shipped with the product.
- **Distribution via Nix flake**, together with the SARA CLI.

## Documentation

- [Product concept](docs/mitodoke-concept.md) ([日本語](docs/mitodoke-concept.ja.md))

## Development

The development shell is provided by `dev/flake.nix` and loaded with direnv.

```sh
cp example.envrc .envrc
direnv allow
```

Without direnv, run `nix develop ./dev`. CI runs `nix flake check`.

## License

[MIT](LICENSE)
