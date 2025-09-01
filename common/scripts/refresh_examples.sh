#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SRC_DIR="$SCRIPT_DIR/../../gallery/examples-typ"
OUT_DIR="$SCRIPT_DIR/../../gallery/examples-svg"

mkdir -p "$OUT_DIR"

for f in "$SRC_DIR"/*.typ; do
  filename=$(basename "$f")
  base="${filename%.typ}"
  out="$OUT_DIR/$base.svg"

  echo "Compiling: $f -> $out"
  typst compile --format svg "$f" "$out"
done
