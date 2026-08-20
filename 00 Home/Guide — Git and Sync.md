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

> Everything about how an Eskolx vault stays in sync, versioned, and safe, and what to do when Git needs your attention.

## Why Git?

The vault is a **Git repository**. Every note is a versioned file, every change has an author and a timestamp, and the whole thing lives on GitHub as a backup. This gives you:

- **History** so any note can be rolled back to any past version.
- **Attribution** because authorship dots and `participants` come from git.
- **Sync without accounts** because there's no Obsidian account and no cloud. Just `git pull` and `git push`.
- **Portability** because a fresh clone on any machine is a complete vault.

## The Sync Setup (automatic)

Obsidian Git handles the plumbing:

- **Pulls** on boot and every ~15 min.
- **Commits and pushes** every ~15 min (and on demand).
- The **status bar** (bottom right) shows the last sync time.
- **Obsidian closed?** `scripts/sync.sh` from the vault root does the same pull → commit → push via the command line (`gh` credential helper, no stored tokens).

Your deliberate hotkeys:

| Hotkey | Command | When to use |
|---|---|---|
| `Ctrl+Shift+P` | Git: Pull | Before a long work session |
| `Ctrl+Shift+S` | Git: Push (auto-commit covers saving) | When you want it on GitHub now |
| `Ctrl+Shift+U` | Git: Push (alias) | Same as above |

## The commit discipline

Auto-sync handles trivial edits, but **deliberate commits win**:

- Commit **meaningful units** with a prefix: `research:`, `docs:`, `project:`, `decision:`, `ops:`, `chore:`.
  - Good: `research: summarize variance estimation`
  - Bad: `Update note`
- **Pull before you work** on shared notes so you're not editing a stale copy.
- **Don't leave uncommitted work sitting overnight.** The vault is the shared record; if it's not committed and pushed, it doesn't exist for anyone else.

## Who can change what

Both vaults live in the **Eskolx Labs GitHub org** (`Eskolx-labs/Eskolx-Open-Knowledge` public, `Eskolx-labs/Eskolx-Core-Knowledge` private). Access:

- **Merge-holders** (Natnael + Barkilign, the org owners) merge to `main` in both repos.
- **Participants** have write access to Open: their own subbranch `participants/<username>`, never `main` or `develop`.
- **Core (private)** is for the core team only. Commits go **straight to `main`**. Small group; pull → work → commit → push.

**Open branch model:**

- `main` and `develop` are **protected**: only merge-holders push to them, via GitHub's native compare-and-merge. The merge is the review.
- Every participant works on their own subbranch `participants/<username>`, created by `scripts/install-hooks.sh` off `develop`. Auto-sync pulls `develop` (staying current with everyone) and pushes the subbranch.
- **Merge ≠ publish.** Merging gets a note into the library; a maintainer flips `publish-status` to `published` after checking the quality gate.
- **Locked paths** (`.obsidian/`, `90 Templates/`, `scripts/`, executable files) change only via `main`. Participants never modify them. The pre-push guard (`scripts/install-hooks.sh`) enforces this locally; CI re-checks on every push.

## Conflicts: what they are, what to do

A **conflict** happens when two machines edit the same lines before either has pulled the other's change. You'll see conflict markers:

```text
<<<<<<< HEAD
my version
=======
their version
>>>>>>> branch-name
```

**Don't panic.** Follow the conflict protocol:

1. **Stop** editing the conflicted file.
2. **Back up** the vault first.
3. **Inspect both versions.** Read the markers and understand both sides.
4. **Resolve intentionally.** Merge the ideas and delete the markers. Never blindly pick ours/theirs.
5. **Verify** the file renders and links work in Obsidian.
6. **Commit the resolution and push.**

**Prevention beats resolution.** Pull before editing shared notes (`Home.md`), and don't have two people editing the same hot notes at once. Auto-commit runs before auto-pull, so the working tree is always clean and a pull is a merge, never a reset.

## What must never go in the vault

- **Secrets.** No passwords, API keys, SSH keys, tokens, ever. `Eskolx-Open` is **public**, so a leaked secret is a leaked secret to the world.
- Private files belong in a password manager, not the vault.
- Before pushing, grep: `rg -i "password|api[_-]?key|token|BEGIN.*PRIVATE KEY" .`
- Committed commit authors should use GitHub's **noreply** email (Settings → Emails → keep my email private) so no personal email enters public history.

## What's Gitignored (and why)

Some things are machine-specific and **never pushed**:

- `.obsidian/workspace.json` (your open tabs and layout)
- `.obsidian/snippets/eskolx-personal.css` (your personal theme tweaks)
- `.obsidian/plugins/highlightr-plugin/data.json` (your personal color choices)
- `.trash/` (Obsidian's local trash)
- `.obsidian/plugins/obsidian-git/obsidian_askpass.sh` (a runtime credential helper regenerated on sync)

The **shared** config (`.obsidian/appearance.json`, plugin files, snippets, templates) **is committed** so a fresh install looks right immediately.

## Backups

GitHub is a backup, not *the* backup. Target the 3-2-1 mindset: **Laptop A + Laptop B + private GitHub + periodic offline encrypted backup**. If a machine dies, a fresh clone rebuilds the vault.

## Diagnosing "It Won't Sync"

1. **Check the status bar.** Is it stuck on "Pull failed" or "Push failed"?
2. **Authentication.** GitHub may be asking for credentials. Use a personal access token with repo scope, or SSH keys. Never paste a token into the vault.
3. **Conflicts.** A conflicted file blocks sync until resolved (see above).
4. **Guard block.** If `sync.sh` exits non-zero with "push blocked by the guard", a note contains a secret or a locked path was touched. `sync.sh` rolled back its own backup commit, so the blocked content is not in local history. The note is still on disk. Fix the flagged file (listed in the error output) and run `sync.sh` again.
5. **Network.** Offline means no sync; everything still works locally.
6. Still stuck → run `bash tests/run_tests.sh` to check vault health, and read the git error in Settings → Obsidian Git.

## Where to go next

[[Guide — Rules and Structure]] explains why the vault is organized the way it is and the 15 rules that keep it healthy.