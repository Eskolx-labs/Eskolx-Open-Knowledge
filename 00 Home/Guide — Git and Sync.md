---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/a/a8/Lightning_bolt_simple.png
---

![Guide — Git and Sync cover](https://upload.wikimedia.org/wikipedia/commons/a/a8/Lightning_bolt_simple.png)

# Guide — Git and Sync

> Everything about how an Eskolx vault stays in sync, versioned, and safe — and what to do when Git needs your attention.

## Why Git?

The vault is a **Git repository** — every note is a versioned file, every change has an author and a timestamp, and the whole thing lives on GitHub as a backup. This gives you:

- **History** — any note can be rolled back to any past version.
- **Attribution** — authorship dots and `participants` come from git.
- **Sync without accounts** — no Obsidian account, no cloud; just `git pull` and `git push`.
- **Portability** — a fresh clone on any machine is a complete vault.

## The Sync Setup (automatic)

Obsidian Git handles the plumbing:

- **Pulls** on boot and every ~15 min.
- **Commits and pushes** every ~15 min (and on demand).
- The **status bar** (bottom right) shows the last sync time.

Your deliberate hotkeys:

| Hotkey | Command | When to use |
|---|---|---|
| `Ctrl+Shift+P` | Git: Pull | Before a long work session |
| `Ctrl+Shift+S` | Commit-and-sync | After finishing a chunk of work |
| `Ctrl+Shift+U` | Git: Push | When you want it on GitHub now |

## The Commit Discipline

Auto-sync handles trivial edits, but **deliberate commits win**:

- Commit **meaningful units** with a prefix: `research:`, `docs:`, `project:`, `decision:`, `ops:`, `chore:`.
  - Good: `research: summarize t-distribution tails`
  - Bad: `Update note`
- **Pull before you work** on shared notes so you're not editing a stale copy.
- **Don't leave uncommitted work sitting overnight** — the vault is the shared record; if it's not committed and pushed, it doesn't exist for anyone else.

## Who Can Change What

- **Core (private)** — trusted founders only. Commits go **straight to `main`**. Small group; pull → work → commit → push.
- **Open (public)** — **building phase**: commits also go straight to `main`. **When outside contributors arrive**: `main` becomes **protected** (PR-only, 1 review), and work moves to topic branches (`yourname/topic`). The PR *is* the review step.

## Conflicts — What They Are, What To Do

A **conflict** happens when two machines edit the same lines before either has pulled the other's change. You'll see conflict markers:

```text
<<<<<<< HEAD
my version
=======
their version
>>>>>>> branch-name
```

**Don't panic.** Follow the conflict protocol (the Core vault's Founder Working Agreement documents it):

1. **Stop** editing the conflicted file.
2. **Back up** the vault first.
3. **Inspect both versions** — read the markers, understand both sides.
4. **Resolve intentionally** — merge the ideas, delete the markers. Never blindly pick ours/theirs.
5. **Verify** the file renders and links work in Obsidian.
6. **Commit the resolution and push.**

**Prevention beats resolution:** pull before editing shared notes (`Home.md`, `Current Focus.md`, `Roadmap.md`), and don't have two people editing the same hot notes at once.

## What Must NEVER Go In The Vault

- **Secrets.** No passwords, API keys, SSH keys, tokens — ever. `Eskolx-Open` is **public**, so a leaked secret is a leaked secret to the world.
- Private files belong in a password manager, not the vault.
- Before pushing, grep: `rg -i "password|api[_-]?key|token|BEGIN.*PRIVATE KEY" .`
- Committed commit authors should use GitHub's **noreply** email (Settings → Emails → keep my email private) so no personal email enters public history.

## What's Gitignored (and why)

Some things are machine-specific and **never pushed**:

- `.obsidian/workspace.json` — your open tabs and layout.
- `.obsidian/snippets/eskolx-personal.css` — your personal theme tweaks.
- `.obsidian/plugins/highlightr-plugin/data.json` — your personal color choices.
- `.trash/` — Obsidian's local trash.
- `.obsidian/plugins/obsidian-git/obsidian_askpass.sh` — a runtime credential helper regenerated on sync.

The **shared** config (`.obsidian/appearance.json`, plugin files, snippets, templates) **is committed** so a fresh install looks right immediately.

## Backups

GitHub is a backup, not *the* backup. Target the 3-2-1 mindset: **Laptop A + Laptop B + private GitHub + periodic offline encrypted backup**. If a machine dies, a fresh clone rebuilds the vault.

## Diagnosing "It Won't Sync"

1. **Check the status bar** — is it stuck on "Pull failed" or "Push failed"?
2. **Authentication** — GitHub may be asking for credentials. Use a personal access token with repo scope, or SSH keys. Never paste a token into the vault.
3. **Conflicts** — see above; a conflicted file blocks sync until resolved.
4. **Network** — offline means no sync; everything still works locally.
5. Still stuck → run `bash tests/run_tests.sh` to check vault health, and read the git error in Settings → Obsidian Git.

## Where To Go Next

[[Guide — Rules and Structure]] — why the vault is organized the way it is, and the 15 rules that keep it healthy.