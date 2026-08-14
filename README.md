# Eskolx-Open

Public, continuously growing learning library for statistics, statistical computing, programming, and data analysis automation.

## System

Read the system documents at the repository root (one level up from this vault):

- `Eshkolx_Labs_Obsidian_Knowledge_System(newer plan).md` — **the authoritative plan**
- `Eshkolx_Labs_Obsidian_Knowledge_System(base plan slightly outdated).md` — earlier draft, kept for reference

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

This vault uses **branch-per-edit + PR**:

1. Pull latest `main`
2. Create a branch: `git checkout -b yourname/topic`
3. Write your note (always from a template via QuickAdd)
4. Commit with a meaningful message
5. Push the branch and open a **pull request** against the public GitHub repo
6. A maintainer reviews and merges

The PR *is* the review step of the `private thought → research → validation → public rewrite → review → public knowledge` pipeline. Never commit directly to `main`.

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

## Python + LaTeX

- **Python**: use the Execute Code plugin — put code in a ` ```python ` block and click the ▶ Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian (MathJax) — `$...$` for inline, `$$...$$` for display. No plugin needed.
