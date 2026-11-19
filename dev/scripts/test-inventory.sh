#!/usr/bin/env bash
# テスト資産を列挙する。いまは契約だけを持つ骨組みで、どちらのモードも何も出力しない。
# Rust のテスト資産の列挙は #6 で実装する。
#
#   dev/scripts/test-inventory.sh --static   # ファイル粒度（契約テストが使う）
#   dev/scripts/test-inventory.sh --full     # テスト名粒度（対応表生成が使う）
#
# 出力（TSV・資産識別子でソート）:
#   --static: <資産>\t<種別>
#   --full:   <資産>\t<種別>\t<テスト名>
#
# exit code は 0 = 列挙できた / 2 = 引数の誤り。

set -uo pipefail

usage() {
  cat >&2 <<'EOF'
usage: test-inventory.sh (--static | --full)

  --static  ファイル粒度で列挙する
  --full    テスト名粒度で列挙する

出力は TSV。詳細はスクリプト冒頭のコメントを参照。
EOF
}

if [ "$#" -ne 1 ]; then
  usage
  exit 2
fi

case "$1" in
  -h | --help)
    usage
    exit 0
    ;;
  --static | --full) ;;
  *)
    usage
    exit 2
    ;;
esac

exit 0
