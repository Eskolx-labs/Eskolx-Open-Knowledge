---
type: concept
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Git-logo.svg/500px-Git-logo.svg.png
featured: false
status: draft
area: tooling
topic: git
created: 2026-08-22
updated: 2026-08-22
author: restinbark
tags: [tooling]
participants: [restinbark]
publish-status: draft
---

# Sync Test Note

A throwaway note created to verify vault-to-GitHub synchronization on
`participants/restinbark`. Safe to delete after verification passes.

## Definition

Sync means changes made in this Obsidian vault are committed by the Obsidian Git
plugin (or `scripts/sync.sh`) and pushed to the participant subbranch on GitHub,
while pulls keep the vault current with `develop`.

## Why it matters

Without verified sync, notes written here stay trapped on one machine.

## How it works

1. Obsidian Git auto-commits changed notes every few minutes.
2. The pre-push guard blocks anything touching `main`, `develop`, locked paths, or secrets.
3. Pushes land on `participants/<username>` only.

Edit made at 07:50:03 to test automatic sync.
