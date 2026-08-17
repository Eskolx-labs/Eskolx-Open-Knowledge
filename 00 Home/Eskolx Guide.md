---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/8/8c/Books_icon.png
---

![Eskolx Guide cover](https://upload.wikimedia.org/wikipedia/commons/8/8c/Books_icon.png)

# Eskolx Guide

> Everything you need to use an Eskolx vault — from "what is Obsidian?" to running the weekly review. New to Obsidian? Start with **Guide — Obsidian Basics** and work through in order.

## Reading Path

Start here and follow the order — each guide assumes the previous one:

1. [[Guide — Obsidian Basics]] — what Obsidian is, the interface, Markdown, links, properties, searching. Zero prior knowledge needed.
2. [[Guide — Workflows]] — the daily loop: capture → inbox → create → decide → review. How the vault actually gets used.
3. [[Guide — Plugins]] — every plugin and built-in feature, what it does, its hotkey, and its fallback.
4. [[Guide — Git and Sync]] — how Git backs everything up and syncs it, and what to do when things conflict.
5. [[Guide — Rules and Structure]] — the 15 rules, folder map, note types, property schema, and why the vault is built this way.

## The One-Minute Orientation

| Thing | How |
|---|---|
| Open Home | `Ctrl+Shift+H` |
| Any command | `Ctrl+P` (command palette) |
| Open any note | `Ctrl+O` (quick switcher) |
| Create a note | `Ctrl+Shift+A` → Eskolx Command Center |
| Capture a thought | `Ctrl+Shift+A` → Send to Inbox |
| Create from template | `Ctrl+T` |
| Daily note | `Ctrl+P` → "Daily notes: Open today's daily note" |
| Pull / commit-sync / push | `Ctrl+Shift+P` / `Ctrl+Shift+S` / `Ctrl+Shift+U` |
| Highlight text | `Ctrl+H` (native) · `Ctrl+Shift+E` (color menu) |
| Toggle edit / reading | `Ctrl+E` |

Full map: [[Keybindings]].

## Org Tools (built for how the lab works)

- **[[Decision Register]]** — every EDR at a glance: open, approved, and revisit-due decisions.
- **My Work — Natnael / Barkilign** (Core vault) — per-person dashboards: your tasks, blockers, decisions, questions, and review queue.
- **[[Review Queue]]** — open PRs and what's waiting on your review.
- **Weekly Review** — `Ctrl+Shift+A` → **New Weekly Review**: a self-populating note of the last 7 days' changes, decisions, tasks, and blockers.

## Vault-Specific Entry Points

- **This vault is Eskolx-Open** (public — the learning library). Your starting notes: [[Start Here]], [[How To Contribute]], [[Community Inbox]].
- The private sibling vault (Eskolx-Core) is for founders only. The two vaults share the same tooling and rules; only the content is private vs public.

## Reference

- [[Keybindings]] · [[Obsidian CLI]] · [[The Eskolx Labs Rules]] · [[Contributor Guide]] · [[First Contribution]]
- Verification checklist for fresh installs: `USER_CHECKLIST.md` at the repository root.
- **The test suite** — `bash tests/run_tests.sh` (from the repo root) runs 300+ checks against fresh clones in a container. If you're ever unsure whether the vault is healthy, run it.