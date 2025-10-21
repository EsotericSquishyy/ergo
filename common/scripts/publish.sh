#!/usr/bin/env bash

export LC_ALL=C
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/../.."
VERSION=$(grep '^version = ' "$ROOT_DIR/typst.toml" | sed -E 's/^version = "([^"]+)"/\1/')
TARGET_DIR="$ROOT_DIR/../packages/packages/preview/ergo/$VERSION"

mkdir -p $TARGET_DIR

cp -r "$ROOT_DIR/gallery" "$ROOT_DIR/src" "$TARGET_DIR"
cp "$ROOT_DIR/LICENSE" "$ROOT_DIR/.gitignore" "$ROOT_DIR/README.md" \
   "$ROOT_DIR/lib.typ" "$ROOT_DIR/typst.toml" "$TARGET_DIR"

# MacOS and Linux sed behavior differ
OS="$(uname -s)"
if [[ "$OS" == "Darwin" ]]; then
    SED_INPLACE=(-i "")
elif [[ "$OS" == "Linux" ]]; then
    SED_INPLACE=(-i)
else
    echo "Unsupported platform: $UNAME" >&2
    exit 1
fi

# replace @local with @preview
find "$TARGET_DIR/gallery" -type f -exec sed "${SED_INPLACE[@]}" 's/@local/@preview/g' {} +

# drop everything in README before first ##
sed "${SED_INPLACE[@]}" '1,/^##/{ /^##/!d; }' "$TARGET_DIR/README.md"
