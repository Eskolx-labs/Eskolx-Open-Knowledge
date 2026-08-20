---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Checklist.svg/500px-Checklist.svg.png
---

![Guide — Workflows cover](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f5/Checklist.svg/500px-Checklist.svg.png)

# Guide — Workflows

> How the vault is actually used day to day: the capture → create → review → publish loop. This is the "operating system" of the lab.

## The loop in one sentence

Capture everything → create atomic notes from templates → assign tasks → research and validate → review → publish. Nothing that matters is allowed to live only in someone's head.

## 1. Start the day: Home

`Ctrl+Shift+H` opens **Home**, the command center. Read it top to bottom:

- **My Tasks / Tasks** show what's assigned to you and to anyone (`#assignee/name`).
- **Recent Changes** lists the 20 most recently edited notes. This is how you catch up without asking.
- **Needs Attention** shows what's stuck (`publish-status: review`) and what's moving.
- **Research Papers Shelf / Published Shelf** show in-progress and published research.

## 2. Create: the command center

`Ctrl+Shift+A` opens the **Eskolx Command Center**. One menu for every kind of note:

| Choice | Creates | Lands in |
|---|---|---|
| New Project | project page | `01 Projects/` (Open) / `03 Projects/` (Core) |
| New Research | research note (abstract/keywords, Motivation→References) | `05 Research/` (Open) / `06 Research/` (Core) |
| New Concept | atomic concept note | `02 Knowledge/` (Open) / `04 Knowledge/` (Core) |
| New Resource | curated external resource | `04 Resources/` |
| New Tutorial | tutorial note | `03 Learning/` |
| New Daily Note | today's daily note | `00 Home/` |

Every choice asks for a name, applies the template, and **auto-routes the note to the right folder** (`Ctrl+T` opens the same template picker). Never hand-write a note from scratch. Always start from a template so the schema stays consistent.

## 3. Tasks

Tasks are plain checkboxes anywhere in a note. Eskolx makes them queryable:

```markdown
- [ ] Write the validation section #assignee/natnael 📅 2026-08-24
```

- `#assignee/name` says who owns it. This feeds Home's **Tasks** and **My Tasks**.
- `📅 date` says when it's due. Tasks with a date sort by urgency.
- Tasks belong **in the note about the work** (project, research note). Never in a separate todo list. Home surfaces them.

**Assignment isolation** works: a task tagged `#assignee/barkilign` shows in Tasks but not in Natnael's My Tasks.

## 4. Research → Publish

The pipeline is `private thought → research → validation → public rewrite → review → public knowledge`:

1. `Ctrl+Shift+A` → **New Research** → lands in `05 Research/` as `publish-status: draft`.
2. Work through the sections: abstract/keywords, Motivation, Approach, Results, Validation, References.
3. When it's ready to go public, set `publish-status: review`.
4. **The PR is the review** when a pull request to `main` with 1 review is the review step.
5. Set `publish-status: published`. It appears on the **Published Shelf** and in **Needs Attention** → review while pending.

## 5. The Daily Note

`Ctrl+P` → **"Daily notes: Open today's daily note"** gives you a dated note with Work / Research / Ideas / Tasks / Summary sections. Use it as scratch space; valuable pieces graduate into real notes via the command center.

## 6. The Sync Discipline

Because Git is the sync:

- **Pull before** long work sessions (`Ctrl+Shift+P`).
- **Commit in meaningful units** with prefixes like `research:`, `docs:`, `project:`, `ops:`.
- **Push when you finish** (`Ctrl+Shift+U`). Auto-sync also pulls/pushes every ~15 min.
- Don't leave uncommitted work sitting. The whole point is that the vault is the shared record.

See [[Guide — Git and Sync]] for the details and what to do on a conflict.

## Where to go next

[[Guide — Plugins]] explains every tool in the vault and what to do if one disappears.