---
type: concept
status: active
area: community
created: 2026-08-13
updated: 2026-08-13

cover: https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png

tags: [onboarding]
participants: ["Natnael-Getahun"]
---

![Start Here cover](https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png)

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

Use the **QuickAdd** menu (`Mod+Shift+A`): New Research / New Concept / New Project / New Decision / New Tutorial / Send to Inbox. Never hand-write a new note from scratch.

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

## The Git Workflow (Building Phase)

**While we're building, commits go straight to `main`** — pull → work → commit → push. No branch ceremony yet.

**Later (when outside contributors arrive):** `main` becomes protected (PR-only, 1 review required) and work moves to topic branches (`yourname/topic`). The PR *is* the review step. We'll flip that switch when the first outside contributor shows up.

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
4. **Set your git identity** (if not already): `git config --global user.name "Your Name"` and `git config --global user.email "you@example.com"` — this is what shows up in commit attribution and the line-author gutter.
