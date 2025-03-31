#!/bin/zsh
if [[ ! -f "typst.toml" ]]; then
  echo "Error: This script must be run from the root directory of the project."
  exit 1
fi

PKG_DIR=$(pwd)

if [[ "$(uname)" == "Darwin" ]]; then
    TARGET_DIR="$HOME/Library/Application Support/typst/packages/local/superTheorems"
    VERSION=$(grep '^version = ' typst.toml | sed -E 's/^version = "([^"]+)"/\1/')

    mkdir -p $TARGET_DIR
    rm -f "$TARGET_DIR/$VERSION"
    ln -s $PKG_DIR "$TARGET_DIR/$VERSION"
    exit 0

elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    TARGET_DIR="$HOME/.local/share/typst/packages/local/superTheorems"
    VERSION=$(grep -oP '(?<=^version = ").*?(?=")' typst.toml)

    mkdir -p $TARGET_DIR
    ln -sfn $PKG_DIR "$TARGET_DIR/$VERSION"
    exit 0

fi
exit 2
