# Eskolx-Open — Agent Guide

This is the **public** Eskolx knowledge vault. Agents working here must follow these rules.

## Identity

- **Vault**: Eskolx-Open (public: statistics/computing knowledge, tutorials, learning paths, community)
- **Repo**: `Natnael-Getahun/Eskolx-Open-Knowledge` (public)
- **Git flow**: **one topic branch per contribution** (`natnael/student-t`, `barkilign/distributions`, ...). `main` is protected — PR-only, 1 review required. Never push to `main`.
- **Auto-sync**: Obsidian Git auto-commits/pushes to your current branch every ~15 min. To publish: open a PR from your branch → `main`.

## Non-negotiables

1. **Never store secrets** — no passwords, API keys, tokens, SSH keys in any file. Ever. This repo is PUBLIC.
2. **Public knowledge must stand on its own** — a note must be understandable by someone who wasn't in the room. No "internal notes copy-pasted".
3. **One note, one job** — atomic notes.
4. **Properties are canonical** — `type`, `status`, `area`, `owner`, `author`, `created`, `updated`, `tags`, `publish-status`. Never duplicate a fact.
5. **Always work from a template** — templates live in `90 Templates/` and self-route via `tp.file.move`. Never hand-write from scratch.
6. **Folders are broad buckets** — never deep subfolders.
7. **Tags are topical only** — `#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding`. `type`/`status`/`area` never become tags.
8. **Publishing pipeline** — new notes start `publish-status: draft`. They become `published` only after review (the PR is the review).
9. **Run the test suite before finishing** — `bash tests/run_tests.sh` from the repo root.
10. **Grep for secrets before any push** — `rg -i "password|api[_-]?key|token|BEGIN.*PRIVATE KEY" .`

## Note types and folders

| type | folder |
|---|---|
| project | `01 Projects/` |
| concept | `02 Knowledge/` |
| research | `07 Research/` |
| decision | `06 Publishing/` |
| meeting | `04 Community/` |
| person | `04 Community/` |
| resource | `05 Resources/` |
| tutorial | `03 Learning/` |
| idea | `08 Lounge/` |
| daily | `00 Home/` |

## Template routing

Templates contain `<%* await tp.file.move("<folder>/" + tp.file.title + ".md") %>` — they move the created note to the right folder automatically. When creating notes directly (CLI or file write), place them per the table above.

## Obsidian CLI

The official CLI is available when Obsidian is running:

```bash
obsidian search query="..."          # find notes
obsidian read                         # read current file
obsidian create name="X" template=Concept   # create from template
obsidian unresolved                   # find broken links
obsidian tags counts                  # tag frequency
```

## Verification checklist (before calling work done)

1. `bash tests/run_tests.sh` — all pass
2. `obsidian unresolved` — no broken links (or intentional)
3. No raw `<% tp. %>` tags in created notes (templates only)
4. Frontmatter has `type`, `status`, `author`, `created`, `updated`, `tags`, `publish-status`
5. Note is in the correct folder per the table above
6. No secrets grep hits
7. Work is on a topic branch (`yourname/topic`), not `main`
