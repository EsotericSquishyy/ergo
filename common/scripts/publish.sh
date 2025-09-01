#!/bin/zsh

SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
VERSION=$(grep '^version = ' "$SCRIPT_DIR/typst.toml" | sed -E 's/^version = "([^"]+)"/\1/')
TARGET_DIR="$SCRIPT_DIR/../packages/packages/preview/ergo/$VERSION"

mkdir -p $TARGET_DIR

cp -r "$SCRIPT_DIR/gallery" "$SCRIPT_DIR/src" "$TARGET_DIR"
cp "$SCRIPT_DIR/LICENSE" "$SCRIPT_DIR/.gitignore" "$SCRIPT_DIR/README.md" \
   "$SCRIPT_DIR/lib.typ" "$SCRIPT_DIR/typst.toml" "$TARGET_DIR"

# MacOS and Linux sed behavior differ
UNAME="$(uname)"
if [[ "$UNAME" == "Darwin" ]]; then
    SED_INPLACE=(-i '')
elif [[ "$(expr substr "$UNAME" 1 5)" == "Linux" ]]; then
    SED_INPLACE=(-i)
else
    echo "Unsupported platform: $UNAME" >&2
    exit 1
fi

# replace @local with @preview
find "$TARGET_DIR/gallery" -type f -exec sed "${SED_INPLACE[@]}" 's/@local/@preview/g' {} +

# drop everything in README before first ##
sed "${SED_INPLACE[@]}" '1,/^##/{ /^##/!d; }' "$TARGET_DIR/README.md"
