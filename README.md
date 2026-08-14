# Eskolx-Open

**Version 0.2** — public, continuously growing learning library for statistics, statistical computing, programming, and data analysis automation.

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

## Git Workflow (Important)

**One topic branch per contribution. `main` is protected (PR-only, 1 review required).**

1. Clone the repo. GitHub does **not** give you push access to `main`.
2. For each piece of work, create a topic branch: `git checkout -b yourname/topic` (e.g. `natnael/student-t`).
3. Work on that branch. Obsidian Git's auto-sync (every 15 min) commits and pushes to *your current* branch automatically — never to `main`.
4. When the work is ready, open a **pull request** from your branch against `main`. A maintainer reviews and merges (1 approval required).

Why topic branches, not one branch per person: each PR stays small, reviewable, and mergeable on its own — you can publish a finished `student-t` note without dragging along an unrelated half-finished `distributions` note. Attribution comes from git history + the `author` property on every note + git line author.

The PR *is* the review step of the `private thought → research → validation → public rewrite → review → public knowledge` pipeline. Never commit directly to `main` — it's blocked at GitHub, not just by convention.

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

Required: Obsidian Git, Dataview, Templater, QuickAdd, Tasks, tldraw, Execute Code. Everything else is built-in. Add a plugin only when it solves a real recurring problem.

### Fallback map (if a plugin disappears, the knowledge survives)

```text
Obsidian Git   → command-line Git
Dataview       → Bases + manual Markdown indexes
Templater      → core Templates + QuickAdd
QuickAdd       → command palette + core Templates
Tasks          → normal Markdown checkboxes
tldraw         → Markdown + SVG/images
Execute Code   → run code outside Obsidian
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

Your theme/translucency choice is personal and stays local (`.obsidian/appearance.json` is gitignored, never pushed).

## Python + LaTeX

- **Python**: use the Execute Code plugin — put code in a ` ```python ` block and click the ▶ Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian (MathJax) — `$...$` for inline, `$$...$$` for display. No plugin needed.
