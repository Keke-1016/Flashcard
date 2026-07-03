# Flashcards — Public Web Page

A read-only public flashcard site. Visitors open a link, browse and flip your decks.
Data lives in `decks.json`; the page (`index.html`) reads it.

## Files
- `index.html` — the public viewer (read-only, flip animation)
- `decks.json` — your deck data (this is what you update to publish)
- `publish.sh` — one-click updater (copies newest export → commits → pushes)

## First-time setup (once)
1. Create a **free GitHub account** at https://github.com if you don't have one.
2. Create a new repository, e.g. named `flashcards`, set to **Public**.
3. Connect this folder to it (run in this folder):
   ```
   git remote add origin https://github.com/<YOUR_USERNAME>/flashcards.git
   git push -u origin main
   ```
4. On GitHub: **Settings → Pages → Source = Deploy from a branch → main / (root) → Save**.
5. After ~1 minute your site is live at:
   `https://<YOUR_USERNAME>.github.io/flashcards/`

## Updating your decks (every time)
1. Open `flashcards.html` (your local editor), edit decks.
2. Click **🌐 Export decks.json** (saves to Downloads).
3. In this folder run:  `./publish.sh`
4. Wait ~30 seconds — the public page shows the new decks.
