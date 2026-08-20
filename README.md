# Eskolx-Open

**Version 0.0.1.** Public, continuously growing research publications + learning library for statistics, statistical computing, programming, and data analysis automation.

## System

The full system architecture lives in `spec.md` in the `Eskolx-labs/eskolx-tests` repo. This vault is the public learning library; the private org-management vault is Eskolx-Core.

## Quick Start (if you've never used Obsidian)

Obsidian is a free note-taking app that reads and writes plain Markdown files. This vault is just a folder of `.md` files, so everything is portable and version-controlled with Git.

1. **Install Obsidian** → https://obsidian.md/download (Windows / macOS / Linux). Version **1.9+** is required (for the card shelves). You do NOT need an Obsidian account or sync.
2. **Open this vault:** Obsidian → **Open another vault** → **Open folder as vault** → select the `Eskolx-Open` folder.
3. **Trust the author:** when prompted "Trust author and enable plugins?", click **Trust**. This enables the community plugins.
4. **Done.** The theme, accent, translucency, and the `eskolx` snippet load automatically. Your personal tweaks go in `.obsidian/snippets/eskolx-personal.css` (gitignored, stays yours).
5. **Start here:** press `Ctrl+Shift+H` to open Home, then `Ctrl+Shift+A` for the **Eskolx Command Center** menu.

**Never used Obsidian?** Open `00 Home/Eskolx Guide.md` in the vault. It's a five-guide course from "what is a vault?" to publishing research. There's also a guided verification tour in `USER_CHECKLIST.md` in the `eskolx-tests` repo.

## Folder Structure

```
00 Home/           entry point (Home.md, Eskolx Guide, Keybindings)
01 Projects/       public project pages
02 Knowledge/      settled atomic concept notes
03 Learning/       tutorials, learning paths, exercises
04 Resources/      curated external resources (books, papers, courses, tools)
05 Research/       exploratory, in-progress research + published papers
90 Attachments/    all attachments, including animations/
90 Templates/      Templater + QuickAdd templates (visible folder, not hidden)
99 Archive/        inactive material (incl. former community/org machinery)
Clippings/        web clippings from the Obsidian Web Clipper extension
```

No nesting beyond this.

## Git workflow

This repo lives in the **Eskolx Labs GitHub org** (`Eskolx-labs/Eskolx-Open-Knowledge`, public).

- **`main` is protected.** Only the merge-holders (the org owners, Natnael and Barkilign) can merge to `main`.
- **`develop` is the live shared branch.** Participants auto-push to `develop` and auto-pull from it. Everyone sees everyone's research and implementations live.
- Participants never push to `main`. Participant work reaches `main` through the merge-holders, using GitHub's native compare-and-merge. The merge is the review.
- **Merge ≠ publish.** Notes start `publish-status: draft`; a maintainer flips them to `published` after checking the quality gate below.
- Locked paths (`.obsidian/`, `90 Templates/`, `scripts/`, executable files) are only changed by merge-holders via `main`, so the executable surface everyone pulls from stays reviewed.

## Animation / tldraw portability rules

Agent-built tldraw scenes must survive a fresh `git pull` on another machine:

1. Every tldraw scene is saved as a real file in the vault (never left as unsaved local app state).
2. Files live under `90 Attachments/animations/` and are referenced with a normal relative embed link, in addition to being embedded.
3. No animation depends on a personal/local tldraw setting. Color palettes, fonts, and config are defined in the file itself or in this vault's shared config, never in a machine's local app preferences.
4. Each animation gets a one-line note (frontmatter or caption) describing what it shows and, if an agent built it, what prompt/process would regenerate it.
5. Before calling an animation "done", pull the vault fresh on a second machine and confirm it renders with zero manual setup.

## Public knowledge quality gate

Before publishing, a note must be: correct, understandable, referenced, self-contained, free of private information and secrets, and learnable by another student.

## License

Educational documentation: CC BY 4.0 (final choice recorded in an EDR when made).

## Plugins

Required: Obsidian Git, Dataview, Templater, QuickAdd, Tasks, tldraw, Execute Code, Eskolx Authorship, Notebook Navigator, Related Notes. Everything else is built-in. Add a plugin only when it solves a real recurring problem.

### Feature images (the embedding rule)

**Embed by URL by default; attachments only when necessary.** Every note has a feature image: an internet embed (`![Title](https://...)`), never a local file. The `cover` property points at the same URL. `scripts/covers.py` assigns one per note; pick a better descriptive image when the note deserves it.

- **Default:** URL embeddings (paper covers, reference diagrams, YouTube previews). Notebook Navigator fetches and thumbnails these into local IndexedDB. Nothing enters the repo, nothing grows git.
- **Local attachment ONLY when Eskolx itself created the media** (own diagrams, tldraw scenes) or the source must survive offline. `90 Attachments/` stays small.

### Authorship dots

Eskolx Authorship (in-repo plugin) shows a right-margin **dot per contiguous author chunk**, color-coded by author, silent until hovered. Hover reveals author, date, branch, merge status, and commit subject. It reads `.obsidian/eskolx-authorship/cache.json`, generated by `scripts/authorship.py`. The `participants` frontmatter property is machine-generated. Never edit it by hand. **Emails never appear anywhere.** Use the GitHub `username@users.noreply.github.com` commit address (Settings → Emails → keep my email private) so no personal email enters public git history. **Never share commit-emails or secrets in commit authors.** This vault is public.

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

These fallbacks don't reproduce every feature. They keep the underlying knowledge recoverable and portable.

## Visual Identity

One shared theme (`eskolx.css` snippet) with two modes: the same visual family, different atmosphere.

- **Dark** = Core palette (near-black, parchment, grape purple, harvest red, muted green). This is the private research lab and operations console.
- **Light** = Open palette (warm cream/beige, grape, clay, muted green). This is the public learning library.

Core defaults to **dark**; Open defaults to **light**. In either vault, switch Appearance → Theme (dark/light) to see the other palette. The snippet is identical in both vaults and version-controlled.

**Frosted glass / translucency** is platform-dependent, by design:

- **macOS**: Settings → Appearance → Translucent window (built-in) + the `eskolx.css` glass rules. Full liquid-glass look.
- **Windows 11**: the `translucent-bg` plugin applies native Mica/Acrylic materials (tinted to the Eskolx palette). Cycle with the ribbon icon or command palette.
- **Windows 10 / Linux**: not possible. Electron removed the API (Windows) and never had it (Linux). The vault keeps the styled solid look (vine-green surfaces).

The theme, accent color, translucency, and the enabled `eskolx` snippet ship in `.obsidian/appearance.json` (committed), so a fresh install looks right immediately with no manual setup. If you want to tweak the look, edit Appearance → Theme / Accent / Translucency; your personal tweaks stay in your local copy (the file is shared, so commit intentional changes).

## Python + LaTeX

- **Python**: use the Execute Code plugin. Put code in a ` ```python ` block and click the ▶ Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian (MathJax). Use `$...$` for inline, `$$...$$` for display. No plugin needed.