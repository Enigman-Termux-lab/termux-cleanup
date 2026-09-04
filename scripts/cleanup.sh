#!/data/data/com.termux/files/usr/bin/bash
set -u
export PATH="${PREFIX:-/data/data/com.termux/files/usr}/bin:${PATH:-}"

echo "🧹 Termux Cleanup"
echo "=================="

BEFORE=$(du -sm "$HOME" 2>/dev/null | awk '{print $1}')
echo "Занято до: ${BEFORE} MB"
echo ""

echo "→ apt-кеш..."
pkg clean >/dev/null 2>&1 && echo "  ✓ готово"

echo "→ npm-кеш и логи..."
rm -rf "$HOME/.npm/_logs"/* "$HOME/.npm/_cacache" 2>/dev/null
echo "  ✓ готово"

echo "→ node-gyp кеш..."
rm -rf "$HOME/.cache/node-gyp"/* 2>/dev/null
echo "  ✓ готово"

echo "→ старые версии pnpm store..."
STORE="$HOME/.local/share/pnpm/store"
if [ -d "$STORE" ]; then
  LATEST=$(ls -1v "$STORE" 2>/dev/null | grep '^v[0-9]' | tail -1)
  if [ -n "$LATEST" ]; then
    for dir in "$STORE"/v*; do
      name=$(basename "$dir")
      if [ "$name" != "$LATEST" ]; then
        rm -rf "$dir" && echo "  ✓ удалён $name (старый)"
      fi
    done
    echo "  ✓ активная версия $LATEST сохранена"
  fi
fi

echo "→ pip-кеш..."
rm -rf "$HOME/.cache/pip"/* 2>/dev/null
echo "  ✓ готово"

echo "→ старые логи npx..."
rm -rf "$HOME/.npm/_npx"/* 2>/dev/null
echo "  ✓ готово"

echo ""
AFTER=$(du -sm "$HOME" 2>/dev/null | awk '{print $1}')
FREED=$((BEFORE - AFTER))
echo "=================="
echo "Занято после: ${AFTER} MB"
echo "🎉 Освобождено: ${FREED} MB"
echo ""
echo "Нажми Enter для выхода..."
read -r
