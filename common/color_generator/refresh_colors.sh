#!/usr/bin/env bash

# Clean up previous assets
CUSTOM_COLORS="(bw|bootstrap)"
rm -rf base16_schemes
rm -rf ../../gallery/scheme_previews
ls ../../src/color/templates/*.json | grep -v -E "${CUSTOM_COLORS}" | xargs rm

python get_themes.py
python get_previews.py
python get_jsons.py

for file in ../../src/color/templates/*.json; do
  echo $(basename "$file" .json)
done > ../../src/color/valid-schemes.txt
