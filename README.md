# Eskolx-Open

**Version 0.0.1** — public, continuously growing learning library for statistics, statistical computing, programming, and data analysis automation.

## Quick Start (if you've never used Obsidian)

Obsidian is a free note-taking app that reads and writes plain Markdown files — this vault is just a folder of `.md` files, so everything is portable and version-controlled with Git.

1. **Install Obsidian** → https://obsidian.md/download (Windows / macOS / Linux). Version **1.9+** is required (for the card shelves). You do NOT need an Obsidian account or sync.
2. **Open this vault:** Obsidian → **Open another vault** → **Open folder as vault** → select the `Eskolx-Open` folder.
3. **Trust the author:** when prompted "Trust author and enable plugins?", click **Trust**. This enables the 12 community plugins.
4. **Done.** The theme, accent, translucency, and the `eskolx` snippet load automatically. Your personal tweaks go in `.obsidian/snippets/eskolx-personal.css` (gitignored, stays yours).
5. **Start here:** press `Ctrl+Shift+H` to open Home, then `Ctrl+Shift+A` for the **Eskolx Command Center** menu (new notes, send to inbox, etc.).

**Never used Obsidian?** Open `00 Home/Eskolx Guide.md` in the vault — a five-guide course from "what is a vault?" to running the weekly review. There's also a guided verification tour in `USER_CHECKLIST.md` at the repository root.

## Org Tools (built-in)

The vault also runs the lab's public operations: **[[Decision Register]]** (every EDR at a glance), **[[Review Queue]]** (open PRs and what's waiting on your review), and a self-populating **Weekly Review** (`Ctrl+Shift+A` → New Weekly Review). See `00 Home/Eskolx Guide.md`.

## System

Read the system plan documents at the repository root (one level up from this vault) — the newer plan is authoritative; the earlier draft is kept for reference.

## Folder Structure

```
00 Home/           entry point (Home.md, Start Here.md, Learning Paths.md)
01 Projects/       public project pages
02 Knowledge/      settled atomic concept notes
03 Learning/       tutorials, learning paths, exercises
04 Community/      contributor docs, meetings, people
05 Resources/      curated external resources (books, papers, courses, tools)
06 Publishing/     drafts, editorial review, published material
07 Research/       exploratory, in-progress research
08 Lounge/         informal community discussion (template-free, no review needed)
90 Attachments/    all attachments, including animations/
90 Templates/      Templater + QuickAdd templates (visible folder, not hidden)
99 Archive/        inactive public material
Clippings/        web clippings from the Obsidian Web Clipper extension
```

No nesting beyond this — except `06 Publishing/` may use draft/review/published subfolders because publication state is operationally meaningful.

## Git Workflow (Building Phase)

**While we're building, commits go straight to `main`** — same as Core. Small trusted group, pull → work → commit → push. No branch ceremony yet.

**Later (when outside contributors arrive):** `main` becomes protected (PR-only, 1 review required), and work moves to topic branches (`yourname/topic`). The PR *is* the review step of the `private thought → research → validation → public rewrite → review → public knowledge` pipeline. We'll flip that switch when the first outside contributor shows up — the docs and tests already cover it.

## Animation / tldraw Portability Rules

Agent-built tldraw scenes must survive a fresh `git pull` on another machine:

1. Every tldraw scene is saved as a real file in the vault (never left as unsaved local app state).
2. Files live under `90 Attachments/animations/` and are referenced with a normal relative embed link, in addition to being embedded.
3. No animation depends on a personal/local tldraw setting — color palettes, fonts, and config are defined in the file itself or in this vault's shared config, never in a machine's local app preferences.
4. Each animation gets a one-line note (frontmatter or caption) describing what it shows and, if an agent built it, what prompt/process would regenerate it.
5. Before calling an animation "done", pull the vault fresh on a second machine and confirm it renders with zero manual setup.

## Public Knowledge Quality Gate

Before publishing, a note must be: correct, understandable, referenced, self-contained, free of private information and secrets, and learnable by another student.

## License

Educational documentation: CC BY 4.0 (final choice recorded in an EDR when made).

## Plugins

Required: Obsidian Git, Dataview, Templater, QuickAdd, Tasks, tldraw, Execute Code, Eskolx Authorship, Notebook Navigator, Related Notes. Everything else is built-in. Add a plugin only when it solves a real recurring problem.

### Feature images (the embedding rule)

**Embed by URL by default; attachments only when necessary.** Every note has a feature image — an internet embed (`![Title](https://...)`), never a local file — and the `cover` property points at the same URL. `scripts/covers.py` assigns one per note; pick a better descriptive image when the note deserves it.

- **Default:** URL embeddings (paper covers, reference diagrams, YouTube previews). Notebook Navigator fetches and thumbnails these into local IndexedDB — nothing enters the repo, nothing grows git.
- **Local attachment ONLY when Eskolx itself created the media** (own diagrams, tldraw scenes) or the source must survive offline. `90 Attachments/` stays small.

### Authorship dots

Eskolx Authorship (in-repo plugin) shows a right-margin **dot per contiguous author chunk**, color-coded by author, silent until hovered. Hover reveals author, date, branch, merge status, and commit subject. It reads `.obsidian/eskolx-authorship/cache.json`, generated by `scripts/authorship.py`. The `participants` frontmatter property is machine-generated — never edit by hand. **Emails never appear anywhere** — use the GitHub `username@users.noreply.github.com` commit address (Settings → Emails → keep my email private) so no personal email enters public git history. **Never share commit-emails or secrets in commit authors** — this vault is public.

### Fallback map (if a plugin disappears, the knowledge survives)

```text
Obsidian Git   → command-line Git
Dataview       → Bases + manual Markdown indexes
Templater      → core Templates + QuickAdd
QuickAdd       → command palette + core Templates
Tasks          → normal Markdown checkboxes
tldraw         → Markdown + SVG/images
Execute Code   → run code outside Obsidian
Eskolx Authorship → scripts/authorship.py (cache only; dots are a display layer)
Notebook Navigator → default file explorer
Related Notes → manual link-walking
```

These fallbacks don't reproduce every feature — they ensure the underlying knowledge stays recoverable and portable.

## Visual Identity

One shared theme (`eskolx.css` snippet) with two modes — the same visual family, different atmosphere:

- **Dark** = Core palette (near-black, parchment, grape purple, harvest red, muted green) — the private research lab / operations console
- **Light** = Open palette (warm cream/beige, grape, clay, muted green) — the public learning library

Core defaults to **dark**; Open defaults to **light**. In either vault, switch Appearance → Theme (dark/light) to see the other palette. The snippet is identical in both vaults and version-controlled.

**Frosted glass / translucency** — platform-dependent, by design:

- **macOS**: Settings → Appearance → Translucent window (built-in) + the `eskolx.css` glass rules. Full liquid-glass look.
- **Windows 11**: the `translucent-bg` plugin applies native Mica/Acrylic materials (tinted to the Eskolx palette). Cycle with the ribbon icon or command palette.
- **Windows 10 / Linux**: not possible — Electron removed the API (Windows) and never had it (Linux). The vault keeps the styled solid look (vine-green surfaces).

The theme, accent color, translucency, and the enabled `eskolx` snippet ship in `.obsidian/appearance.json` (committed), so a fresh install looks right immediately — no manual setup. If you want to tweak the look, edit Appearance → Theme / Accent / Translucency; your personal tweaks stay in your local copy (the file is shared, so commit intentional changes).

## Python + LaTeX

- **Python**: use the Execute Code plugin — put code in a ` ```python ` block and click the ▶ Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian (MathJax) — `$...$` for inline, `$$...$$` for display. No plugin needed.
