#!/bin/zsh
if [[ ! -f "typst.toml" ]]; then
  echo "Error: This script must be run from the root directory of the project."
  exit 1
fi

mkdir -p "$HOME/Library/Application Support/typst/packages/local/superTheorems"
VERSION=$(grep '^version = ' typst.toml | sed -E 's/^version = "([^"]+)"/\1/')
rm -f "/Users/$USER/Library/Application Support/typst/packages/local/superTheorems/$VERSION"
ln -s $(pwd) "$HOME/Library/Application Support/typst/packages/local/superTheorems/$VERSION"
