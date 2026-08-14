---
type: concept
status: active
area: community
created: 2026-08-13
updated: 2026-08-13
---

# Start Here

Welcome to Eskolx. Read this before contributing.

> [!insight] It's always **Eskolx Labs** — never Eskol or Eskolx. [[It's Always Eskolx Labs]]

## What Eskolx Is

[[What Is Eskolx]]

## The 3 Rules

1. **If it matters, write it down.**
2. **One note, one job** — atomic notes.
3. **Properties are the canonical metadata** — `type`, `status`, `area`, `owner`, `created`, `updated`.

## How Notes Work

- **Folders** are broad domain buckets — `02 Knowledge/`, `07 Research/`, `01 Projects/` etc. Never deep subfolders.
- **Properties** (YAML frontmatter) say what a note is. Query them with Bases and Dataview.
- **Links** say what a note connects to — link meaningful concepts as you write: `[[Student t distribution]]`.
- **Tags** are only for cross-cutting topical discovery: `#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding #core-only`. `type`, `status`, `area` never become tags.

## Always Work From A Template

Use the **QuickAdd** menu (`Mod+Shift+A`): New Research / New Concept / New Project / New Decision / New Tutorial / Quick Capture. Never hand-write a new note from scratch.

## Where Each Note Type Lives

| Type | Folder |
|---|---|
| project | `01 Projects/` |
| concept | `02 Knowledge/` |
| tutorial | `03 Learning/` |
| meeting, person | `04 Community/` |
| resource | `05 Resources/` |
| decision | `06 Publishing/` |
| research | `07 Research/` |
| idea | `08 Lounge/` |

## The Git Workflow (Important)

This vault uses **topic branches + PR**. Every piece of work goes on its own branch; when done, you open a **pull request** against the public GitHub repo, and a maintainer reviews and merges it (1 approval required). The PR *is* the review step. Never commit directly to `main`.

1. Pull the latest `main`
2. Create a topic branch: `git checkout -b yourname/topic` (e.g. `natnael/student-t`)
3. Write your note (from a template)
4. Commit with a meaningful message
5. Push the branch and open a PR

## How To Learn With Eskolx

[[How To Learn With Eskolx]]

## Next Steps

1. Read the [[Contributor Guide]]
2. Create a tiny test note via QuickAdd
3. Make a real contribution

## One-Time Setup (every machine)

These are per-machine, so every new machine needs them once:

1. **Enable the CLI**: Settings → General → **Command line interface** → follow the on-screen instructions to register `obsidian` on your PATH. See [[Obsidian CLI]].
2. **Enable plugins**: when Obsidian asks "Trust author and enable plugins?" → **Trust**.
3. **Set your git identity** (if not already): `git config --global user.name "Your Name"` and `git config --global user.email "you@example.com"` — this is what shows up in commit attribution and the line-author gutter.
4. **Create a topic branch** (Open vault only): `git checkout -b yourname/topic` — one branch per piece of work, e.g. `natnael/student-t`.
