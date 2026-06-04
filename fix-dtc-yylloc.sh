#!/usr/bin/env bash
set -euo pipefail

echo "Fixing duplicate yylloc definitions in scripts/dtc..."

files=(
  "scripts/dtc/dtc-lexer.lex.c"
  "scripts/dtc/dtc-lexer.lex.c_shipped"
)

for file in "${files[@]}"; do
  if [[ -f "$file" ]]; then
    echo "Patching $file"
    sed -i \
      -e 's/^YYLTYPE yylloc;$/extern YYLTYPE yylloc;/' \
      "$file"
  fi
done

echo "Removing generated DTC objects..."
rm -f scripts/dtc/*.o
rm -f scripts/dtc/dtc

echo "Done. Now rebuild with:"
echo "  make"
