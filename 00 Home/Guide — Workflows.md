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

> How the vault is actually used day to day: the capture → inbox → create → decide → review loop. This is the "operating system" of the lab.

## The Loop In One Sentence

Capture everything → process the inbox → create atomic notes from templates → assign tasks → decide in EDRs → review weekly. Nothing that matters is allowed to live only in someone's head.

## 1. Start The Day: Home

`Ctrl+Shift+H` opens **Home**, the command center. Read it top to bottom:

- **My Tasks / Tasks** — what's assigned to you and to anyone (`#assignee/name`).
- **Recent Changes** — the 20 most recently edited notes. This is how you catch up without asking.
- **Blocked / Active Projects** — what's stuck and what's moving.
- **Open Decisions / Open Questions** — what needs a call, what needs an answer.

Core founders also have per-person dashboards (My Work — Natnael and My Work — Barkilign) in the private vault.

## 2. Capture: Send To Inbox

Anything that crosses your mind but isn't a full note yet — `Ctrl+Shift+A` → **Send to Inbox**. It lands as a checkbox in the **Founder Inbox** (Core) or **Community Inbox** (Open).

**Process the inbox regularly** (daily-ish): each line is a checkbox.

- Tick it when dealt with — it moves to **Attended** and out of **Needs Attention**.
- Untick to bring it back.
- The goal is **zero unprocessed captures**: either it becomes a real note, a task, or it's deleted.

## 3. Create: The Command Center

`Ctrl+Shift+A` opens the **Eskolx Command Center** — one menu for every kind of note:

| Choice | Creates | Lands in |
|---|---|---|
| New Project | project page | `01 Projects/` (Open) / `03 Projects/` (Core) |
| New Research | research note (abstract/keywords, Motivation→References) | `07 Research/` |
| New Concept | atomic concept note | `02 Knowledge/` (Open) / `04 Knowledge/` (Core) |
| New Decision | decision record (EDR) | `06 Publishing/` (Open) / `06 Decisions/` (Core) |
| New Meeting | meeting note with Actions | `04 Community/` (Open) / `02 Operations/` (Core) |
| New Person / Resource / Idea / Tutorial | their note types | per the folder map |
| New Daily Note | today's daily note | `00 Home/` |
| New Weekly Review | self-populating review of the last 7 days | `00 Home/` |
| Send to Inbox | a capture checkbox | the inbox |

Every choice asks for a name, applies the template, and **auto-routes the note to the right folder** (`Ctrl+T` opens the same template picker). Never hand-write a note from scratch — always start from a template so the schema stays consistent.

## 4. Tasks

Tasks are plain checkboxes anywhere in a note — but Eskolx makes them queryable:

```markdown
- [ ] Write the validation section #assignee/natnael 📅 2026-08-24
```

- `#assignee/name` — who owns it. This feeds Home's **Tasks** and **My Tasks**, and the per-person My Work dashboards.
- `📅 date` — when it's due. Tasks with a date sort by urgency.
- Tasks belong **in the note about the work** (project, decision, meeting) — never in a separate todo list. Home surfaces them.

**Assignment isolation** works: a task tagged `#assignee/barkilign` shows in Tasks but not in Natnael's My Tasks.

## 5. Decide: EDRs And The Decision Register

Decisions are logged as **EDRs** (decision records), not made in chat:

1. `Ctrl+Shift+A` → **New Decision** → lands as `EDR — YYYY-MM-DD — Title`, `status: proposed`.
2. Fill Context → Problem → Options Considered → Decision → Why → Consequences → Revisit Conditions.
3. When the call is made, set `status` (approved / declined / archived).
4. Set a **`revisit:`** date when the call should be re-evaluated.
5. **[[Decision Register]]** shows everything: open decisions, revisit-due, and the full log.

> If it's not in an EDR, it didn't happen — and a `proposed` EDR that stays open forever is a decision that was never made.

## 6. Review Weekly

`Ctrl+Shift+A` → **New Weekly Review**. The note is **pre-populated by queries** — you don't write from a blank page:

- **This Week's Changes** — every note edited in the last 7 days.
- **Decisions Made This Week** — EDRs dated in the last 7 days.
- **My Tasks** and **Blocked** — what's outstanding.
- Then you fill in the short manual sections: Carry-Over, Completed, Blockers, Next Week Focus, Decisions To Make Next Week.

The weekly review is the heartbeat: it converts a pile of commits into a short, honest status.

## 7. The Daily Note

`Ctrl+P` → **"Daily notes: Open today's daily note"** gives you a dated note with Work / Decisions / Research / Ideas / Tasks / Summary sections. Use it as scratch space; valuable pieces graduate into real notes via the command center.

## 8. The Sync Discipline

Because Git is the sync:

- **Pull before** long work sessions (`Ctrl+Shift+P`).
- **Commit in meaningful units** — `research:`, `docs:`, `project:`, `decision:`, `ops:`.
- **Push when you finish** (`Ctrl+Shift+U`). Auto-sync also pulls/pushes every ~15 min.
- Don't leave uncommitted work sitting — the whole point is that the vault is the shared record.

See [[Guide — Git and Sync]] for the details and what to do on a conflict.

## Where To Go Next

[[Guide — Plugins]] explains every tool in the vault and what to do if one disappears.