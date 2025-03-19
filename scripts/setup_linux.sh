#!/bin/zsh
if [[ ! -f "typst.toml" ]]; then
  echo "Error: This script must be run from the root directory of the project."
  exit 1
fi

PKG_DIR=$(pwd)
TARGET_DIR="$HOME/.local/share/typst/packages/local/superTheorems"
VERSION=$(grep -oP '(?<=^version = ").*?(?=")' typst.toml)

mkdir -p "$TARGET_DIR"
ln -sfn "$PKG_DIR" "$TARGET_DIR/$VERSION"
