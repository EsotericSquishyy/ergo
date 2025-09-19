#!/usr/bin/env bash

rm -rf base16_schemes
rm -rf ../../gallery/scheme_previews
ls ../../src/color/*.json | grep -v -E "(bw|bootstrap)" | xargs rm

python get_themes.py
python get_previews.py
python get_jsons.py

for file in ../../src/color/*.json; do
  echo $(basename "$file" .json)
done > ../../src/color/valid-schemes.txt
