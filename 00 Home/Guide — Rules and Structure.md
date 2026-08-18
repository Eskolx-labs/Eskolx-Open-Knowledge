---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Colibre_%E2%80%93_flowchartshapes.flowchart-decision.svg/500px-Colibre_%E2%80%93_flowchartshapes.flowchart-decision.svg.png
---

![Guide — Rules and Structure cover](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Colibre_%E2%80%93_flowchartshapes.flowchart-decision.svg/500px-Colibre_%E2%80%93_flowchartshapes.flowchart-decision.svg.png)

# Guide — Rules and Structure

> The design of the vault: the 15 rules, the folder map, note types, the property schema, and the conventions that keep it queryable. If you write one note, this page is what you need to get right.

## The 15 Rules

The vault runs on a small set of rules (full text: [[The Eskolx Labs Rules]]). The ones that matter most when writing:

1. **If it matters, write it down** — the vault is the lab's memory.
2. **One note, one job** — atomic notes. Never "Everything about X.md".
3. **Properties are canonical** — `type`, `status`, `area`, `owner`, `author`, `created`, `updated`, `tags`. Never duplicate a fact in folder + tag + property. `participants` is machine-generated — never hand-edit.
4. **Embed by URL by default** — every note has a feature image embedded from the internet (`![Title](https://…)`), and the `cover` property holds the same URL. Local attachments **only** for Eskolx-made media (own diagrams, tldraw scenes). Cover style: a clean, flat icon or diagram — **not** a literal photo of people/places.
5. **Always work from a template** — templates live in `90 Templates/` and self-route. Never hand-write from scratch.
6. **Folders are broad buckets** — no deep nesting. `04 Knowledge/`, never `04 Knowledge/Statistics/Probability/…`.
7. **Tags are topical only** — `#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding`. `type`/`status`/`area` never become tags.
8. **Link meaningful concepts** — `[[Student t Distribution]]`, not every common word.
9. **Tasks live in their note** — in the project/decision/meeting note they're about, with `#assignee/name` and `📅` dates. Home surfaces them.
10. **Run the test suite before finishing** — `bash tests/run_tests.sh`.
11. **Grep for secrets before any push.**

## Folder Map

**Eskolx-Core (private):**

```text
00 Home/        command center (Home, Current Focus, dashboards)
01 Direction/   mission, vision, roadmap, long-term goals
02 Operations/  working agreement, security policy, meetings
03 Projects/    private project pages
04 Knowledge/   settled atomic concept notes
05 People/      private people info
06 Research/    exploratory, in-progress research
90 Attachments/ attachments + animations/
90 Templates/   Templater + QuickAdd templates
99 Archive/     inactive material
Clippings/      web clippings
```

**Eskolx-Open (public):**

```text
00 Home/        entry point (Home, Eskolx Guide, Keybindings)
01 Projects/    public project pages
02 Knowledge/   settled atomic concept notes
03 Learning/    tutorials, learning paths, exercises
04 Resources/   curated external resources
05 Research/    exploratory, in-progress research + published papers
90 Attachments/ + animations/ · 90 Templates/ · 99 Archive/ · Clippings/
```

## Note Types And Where They Go

| type | Core folder | Open folder |
|---|---|---|
| project | `03 Projects/` | `01 Projects/` |
| research | `06 Research/` | `05 Research/` |
| concept | `04 Knowledge/` | `02 Knowledge/` |
| resource | `04 Knowledge/` | `04 Resources/` |
| tutorial | `04 Knowledge/` | `03 Learning/` |
| idea | `00 Home/` | `00 Home/` |
| daily | `00 Home/` | `00 Home/` |

Templates self-route to these folders — you almost never choose.

## The Property Schema

Canonical properties every note can carry:

```yaml
type:        concept   # project | research | concept | resource | tutorial | idea | daily
status:      active    # controlled per type (see below)
area:        statistics # domain bucket — statistics | numerical-methods | computing | …
owner:       natnaelg  # who owns it (when relevant)
author:      Natnael   # who wrote it
created:     2026-08-17
updated:     2026-08-17
tags:        [distributions]   # topical only
cover:       https://…   # same URL as the note's feature-image embed
featured:    false     # true = appears on the Featured shelf
publish-status: draft  # Open only: draft | review | approved | published | archived
participants: []       # machine-generated — never edit
```

### Controlled values

- **Project status**: idea, planned, active, blocked, review, completed, archived
- **Research status**: question, active, needs-review, validated, published, archived
- **Publishing status** (Open): draft, review, approved, published, archived
- **Priority**: low, normal, high, critical

The automated suite enforces these — a note with `status: maybe` fails the build.

## Why It's Built This Way

- **Queryable** — dashboards (Home, Research Papers Shelf, Published Shelf) are just property queries. Messy properties = broken dashboards.
- **Portable** — plain Markdown + Git means the knowledge outlives any tool.
- **Honest** — `publish-status` makes the lab's publication state visible instead of assumed.
- **Testable** — 300+ checks run in a container against fresh clones, so a "fresh install" is guaranteed to work, not hoped to.

## The Quality Gate (Open)

Before a knowledge note is **published**, it must be: **correct, understandable, referenced, self-contained, free of private information and secrets, and learnable by another student.** If any answer is no, keep it in draft/review. The PR is the review.

## Where To Go Next

You've completed the guide. Put it to work: open **[[Home]]**, and if you're verifying a fresh install, walk through `USER_CHECKLIST.md`.