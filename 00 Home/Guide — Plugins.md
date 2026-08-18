---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Gear-icon-blue.png/500px-Gear-icon-blue.png
---

![Guide — Plugins cover](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Gear-icon-blue.png/500px-Gear-icon-blue.png)

# Guide — Plugins

> Every plugin and built-in feature in an Eskolx vault: what it does, how you trigger it, and what happens if it disappears. "Add a plugin only when it solves a real recurring problem" — every plugin here earned its place.

## Community Plugins (installed & trusted)

### Obsidian Git — the sync engine
Everything in the vault is a Git repo; this plugin makes Git invisible. It **auto-commits and pushes every ~15 minutes** and pulls on boot, and the bottom-right status bar shows the last sync time.
- `Ctrl+Shift+P` pull · `Ctrl+Shift+S` commit-and-sync · `Ctrl+Shift+U` push.
- See [[Guide — Git and Sync]] for conflicts and hygiene.
- **If it disappears:** use command-line Git — the vault is still just a repo.

### QuickAdd — the command center
`Ctrl+Shift+A` opens **Eskolx Command Center**: New Project/Research/Concept/Resource/Tutorial/Daily Note, Insert Dataview Block, Open Home. Every choice applies a template and auto-routes the note.
- **If it disappears:** use `Ctrl+T` (Templater) for templates and the command palette for everything else.

### Templater — the template engine
`Ctrl+T` → pick a template. Templates live in **`90 Templates/`** (a visible folder, not hidden in `.obsidian/`), fill in frontmatter and headings, and **self-route** via `tp.file.move` — you never choose the destination folder.
- **If it disappears:** Obsidian's built-in core Templates plugin covers basic insertion (no routing/auto-fill).

### Tasks — the query language for checkboxes
Notes use plain `- [ ]` checkboxes; the Tasks plugin turns them into **live filtered lists** on dashboards (Home). Queries filter by `#assignee/`, due dates, and done state.
- **If it disappears:** checkboxes still work as normal Markdown; you just lose the filtered views.

### Dataview — query your own vault
The `dataview` and `dataviewjs` code blocks turn notes into tables and lists by querying properties: `TABLE status, area FROM "05 Research" WHERE type = "research"`. Used heavily by dashboards.
- **If it disappears:** Obsidian's **Bases** (see below) covers most of the same needs.

### Bases (built-in, not a plugin)
Obsidian 1.9+ ships **Bases** — visual, queryable views of notes defined in `base` code blocks (the ```` ```base ```` blocks on Home and the shelves). Query properties like `type == "research"` and render as table/cards/list.
- **If Dataview disappears:** Bases keeps the dashboards working.

### Highlightr — the 10-color highlighter
`Ctrl+Shift+E` opens a palette of **10 theme-aware colors** (Soil, Wine, Grape, Forest, Harvest, Sky, Slate, Rose, Mint, Amber). `Ctrl+H` is the **native** toggle-highlight (`==text==`) — a real background highlight. Your color choices stay local (gitignored).
- **If it disappears:** `Ctrl+H` native highlight and `==text==` still work.

### Eskolx Authorship — the dots
A right-margin **dot marks the start of each contiguous author chunk**; color = author. Hover a dot for author, date, branch, merge status, and commit subject; click the link to open the commit/PR on GitHub. Computed client-side from git — no setup.
- The per-line name/date gutter is **off by design** — dots only.
- `participants` in frontmatter is machine-generated — never hand-edit.
- **If it disappears:** `scripts/authorship.py` still generates the cache; attribution lives in Git itself.

### Notebook Navigator — the dual-pane explorer
A friendlier file explorer with **hover previews** of notes (including their cover images), a calendar view, and a property browser. The classic file explorer remains available — Navigator never replaces it.
- **If it disappears:** the classic explorer is always there.

### Related Notes — offline similarity
Opens a right-sidebar panel (ribbon icon or "Related Notes: Open related notes panel") listing similar notes by text similarity. **Offline, no API key.**
- **If it disappears:** walk backlinks manually.

### Execute Code — run Python in a note
Put code in a ` ```python ` block and click the **▶ Run** button (always visible, top-right). Output appears below the block. Uses `python3`.
- **If it disappears:** run the code outside Obsidian.

### tldraw — canvas drawings
Draw scenes in a `tldr` file and **embed** them in notes. Portability rule: scenes are real files under `90 Attachments/animations/`, embedded **and** linked. Embedded scenes are static previews.
- **If it disappears:** the files and links remain readable.

### translucent-bg (Windows 11 only)
Applies native Mica/Acrylic translucency on Windows 11. macOS uses the built-in Translucent window; Linux uses the styled solid look. Cosmetic only.

## Built-in Features You Should Know

- **Properties** — frontmatter form (see Basics guide).
- **Templates (core)** — template folder integration (Templater is the enhanced version).
- **Daily Notes** — wired to `90 Templates/Daily.md`.
- **Backlinks / Outgoing Links / Outline** — right sidebar panels.
- **Search** — `Ctrl+Shift+F`.
- **Graph View** — the vault as a network.
- **Command Palette** — `Ctrl+P`, the universal remote.
- **Workspaces / Canvas / File Recovery** — layout presets, infinite canvas, and automatic version snapshots.
- **Web Clipper (browser extension)** — clips web pages into the `Clippings/` folder.

## The Fallback Map

If any plugin ever breaks, the **knowledge survives** — plugins are conveniences, not the storage:

```text
Obsidian Git   → command-line Git
Dataview       → Bases + manual Markdown indexes
Templater      → core Templates + QuickAdd
QuickAdd       → command palette + core Templates
Tasks          → normal Markdown checkboxes
tldraw         → Markdown + SVG/images
Execute Code   → run code outside Obsidian
Eskolx Authorship → scripts/authorship.py (cache; dots are display only)
Notebook Navigator → default file explorer
Related Notes → manual link-walking
```

Fallbacks don't reproduce every feature — they guarantee the underlying knowledge stays recoverable and portable.

## Managing Plugins

Settings → **Community plugins** → browse / toggle / update. Rules:

- Don't add plugins casually — one note, one job applies to tooling too.
- If you add one, it should solve a recurring problem, be committed (its files live in `.obsidian/plugins/`), and its purpose documented here.

## Where To Go Next

[[Guide — Git and Sync]] — how the whole thing syncs, and what to do when it fights back.