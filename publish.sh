#!/bin/bash
# ── Flashcards one-click publisher ─────────────────────────────
# 1. In flashcards.html click "🌐 Export decks.json" (saves to Downloads)
# 2. Run this script:  ./publish.sh
# It copies the newest decks.json from Downloads into this folder,
# commits, and pushes to GitHub. Your public page updates in ~30s.

set -e
cd "$(dirname "$0")"

DL="$HOME/Downloads"

# Find the most recent decks*.json in Downloads
LATEST=$(ls -t "$DL"/decks*.json 2>/dev/null | head -n1 || true)

if [ -n "$LATEST" ]; then
  echo "→ Using newest export: $LATEST"
  cp "$LATEST" ./decks.json
else
  echo "→ No decks*.json found in Downloads; publishing current decks.json as-is."
fi

# Validate it's real JSON before pushing
if ! python3 -c "import json,sys; json.load(open('decks.json'))" 2>/dev/null; then
  echo "✗ decks.json is not valid JSON. Aborting."
  exit 1
fi

COUNT=$(python3 -c "import json; print(len(json.load(open('decks.json'))))")
echo "→ decks.json contains $COUNT deck(s)."

git add decks.json index.html
if git diff --cached --quiet; then
  echo "✓ Nothing changed — site already up to date."
  exit 0
fi

git commit -m "Update decks ($(date '+%Y-%m-%d %H:%M'))"
git push
echo "✓ Published! Your site will refresh in ~30 seconds."
