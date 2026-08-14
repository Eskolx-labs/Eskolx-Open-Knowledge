---
type: concept
status: active
area: community
created: 2026-08-14
updated: 2026-08-14
author: Natnael
tags: [tooling, onboarding]
publish-status: published

cover: https://upload.wikimedia.org/wikipedia/commons/e/e2/Firefoxshortcuts.png
participants: ["Natnael-Getahun"]
---

![Keybindings cover|152](https://upload.wikimedia.org/wikipedia/commons/e/e2/Firefoxshortcuts.png)

# Keybindings

The Eskolx keyboard map. Same in both vaults.

| Keys | Command |
|---|---|
| `Ctrl+T` | Templater: Create new note from template |
| `Ctrl+Shift+A` | QuickAdd: Eskolx Command Center |
| `Ctrl+Shift+P` | Git: Pull |
| `Ctrl+Shift+S` | Git: Commit-and-sync |
| `Ctrl+Shift+U` | Git: Push |
| `Ctrl+Shift+H` | Open Home |
| `Ctrl+O` | Quick switcher (open any note) |
| `Ctrl+E` | Toggle edit / reading view |
| `Ctrl+Shift+E` | Highlightr color menu (Grape, Wine, Forest, Soil, Harvest) |

## Editing

| Keys | Command |
|---|---|
| `Ctrl+H` | Toggle highlight (`==text==`, native background highlight) |

## Personal keys

Your theme, font, and window preferences are personal — stored in `.obsidian/appearance.json`, which is gitignored and never pushed. Other people's theme choices never affect you.

## Changing keys

Settings → Hotkeys → search the command name → click the `+` → press your keys.


## Related Notes (Related Notes plugin)

- No hotkey by default — open the panel from the ribbon (paper-plane icon) or command palette ("Related Notes: Open related notes panel").
- Offline similarity search; no API key needed.

## Authorship dots (Eskolx Authorship plugin)

**Dots are the only authorship display.** The per-line name/date gutter is OFF — the left margin is empty; the right margin carries the dots.

- A dot marks the start of a contiguous chunk written by one person in one sitting.
- Color = author (consistent across the whole vault).
- Hover a dot to see author, date, branch, merge status, and commit subject.
- The `participants` frontmatter property is machine-generated (scripts/authorship.py) — never hand-edit it.
- Git blame / history still hold the full record (author + date per commit) — see Obsidian Git's History view.
