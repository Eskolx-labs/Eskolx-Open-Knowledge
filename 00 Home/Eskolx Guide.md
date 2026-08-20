---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/8/8c/Books_icon.png
participants: ["Natnael-Getahun"]
---

![Eskolx Guide cover](https://upload.wikimedia.org/wikipedia/commons/8/8c/Books_icon.png)

# Eskolx Guide

> Everything you need to use an Eskolx vault, from "what is Obsidian?" to publishing research. New to Obsidian? Start with **Guide — Obsidian Basics** and work through in order.

## Reading Path

Start here and follow the order. Each guide assumes the previous one:

1. [[Guide — Obsidian Basics]]. What Obsidian is, the interface, Markdown, links, properties, searching. Zero prior knowledge needed.
2. [[Guide — Workflows]]. The daily loop: capture → create → decide → review. How the vault actually gets used.
3. [[Guide — Plugins]]. Every plugin and built-in feature, what it does, its hotkey, and its fallback.
4. [[Guide — Git and Sync]]. How Git backs everything up and syncs it, and what to do when things conflict.
5. [[Guide — Rules and Structure]]. The 15 rules, folder map, note types, property schema, and why the vault is built this way.

## The one-minute orientation

| Thing | How |
|---|---|
| Open Home | `Ctrl+Shift+H` |
| Any command | `Ctrl+P` (command palette) |
| Open any note | `Ctrl+O` (quick switcher) |
| Create a note | `Ctrl+Shift+A` → Eskolx Command Center |
| Capture a thought | `Ctrl+Shift+A` → New Daily Note |
| Create from template | `Ctrl+T` |
| Daily note | `Ctrl+P` → "Daily notes: Open today's daily note" |
| Pull / commit-sync / push | `Ctrl+Shift+P` / `Ctrl+Shift+S` / `Ctrl+Shift+U` |
| Highlight text | `Ctrl+H` (native) · `Ctrl+Shift+E` (color menu) |
| Toggle edit / reading | `Ctrl+E` |

Full map: [[Keybindings]].

## Built for research publications

- **Research → published pipeline.** Notes start `publish-status: draft`, move through review, and become `published` (the PR is the review). See **Guide — Workflows**.
- **Vault Health / Reviews.** The PR review queue. Nothing informal lives here anymore.
- **Manual sync.** If Obsidian isn't open, `scripts/sync.sh` pulls/commits/pushes for you.

## Vault-specific entry points

- **This vault is Eskolx-Open** (public research publications + learning library). Start with [[Home]], [[Eskolx Guide]], [[Keybindings]].
- The private sibling vault (Eskolx-Core) is for founders only. The two vaults share the same tooling and rules; only the content is private vs public.

## Reference

- [[Keybindings]] · [[Obsidian CLI]] · [[The Eskolx Labs Rules]]
- Verification checklist for fresh installs: `USER_CHECKLIST.md` at the repository root.
- **The test suite** `bash tests/run_tests.sh` (from the repo root) runs 300+ checks against fresh clones in a container. If you're ever unsure whether the vault is healthy, run it.