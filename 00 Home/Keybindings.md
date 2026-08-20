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

| Keys           | Command                                                    |
| -------------- | ---------------------------------------------------------- |
| `Ctrl+T`       | Templater: Create new note from template                   |
| `Ctrl+Shift+A` | QuickAdd: Eskolx Command Center                            |
| `Ctrl+Shift+P` | Git: Pull                                                  |
| `Ctrl+Shift+S` | Git: Push (auto-commit covers saving; see Guide — Git and Sync) |
| `Ctrl+Shift+U` | Git: Push (alias)                                             |
| `Ctrl+Shift+H` | Open Home                                                  |
| `Ctrl+O`       | Quick switcher (open any note)                             |
| `Ctrl+E`       | Toggle edit / reading view                                 |
| `Ctrl+Shift+E` | Highlightr color menu (Soil, Wine, Grape, Forest, Harvest, Sky, Slate, Rose, Mint, Amber) |

## Editing

| Keys | Command |
|---|---|
| `Ctrl+H` | Toggle highlight (`==text==`, native background highlight) |

## Personal keys

Your theme, accent, translucency, and enabled snippets live in `.obsidian/appearance.json`, which is **committed** so a fresh install looks right immediately. Personal overrides go in `.obsidian/snippets/eskolx-personal.css`. That one is gitignored and never pushed, so your individual tweaks never affect anyone else.

## Changing keys

Settings → Hotkeys → search the command name → click the `+` → press your keys.


## Related notes (Related Notes plugin)

- No hotkey by default. Open the panel from the ribbon (paper-plane icon) or command palette ("Related Notes: Open related notes panel").
- Offline similarity search; no API key needed.

## Authorship dots (Eskolx Authorship plugin)

**Dots are the only authorship display.** The per-line name/date gutter is OFF. The left margin is empty; the right margin carries the dots.

- A dot marks the start of a contiguous chunk written by one person in one sitting.
- Color = author (consistent across the whole vault).
- Hover a dot to see author, date, branch, merge status, and commit subject.
- The `participants` frontmatter property is machine-generated (scripts/authorship.py). Never hand-edit it.
- Git blame / history still hold the full record (author + date per commit). See Obsidian Git's History view.
