---
type: concept
status: active
area: community
created: 2026-08-14
updated: 2026-08-14
author: Natnael
tags: [tooling, onboarding, agentic-ai]
publish-status: published
participants: ["Natnael-Getahun"]
participants: ["Natnael-Getahun"]
---

# Obsidian CLI

Obsidian ships an official CLI — anything you can do in Obsidian, you can do from the terminal. This is how agents (and you) script the vaults.

## Setup (one time)

1. Update Obsidian to the latest version.
2. Enable **Command line interface** in **Settings → General**.
3. Follow the on-screen instructions to register the CLI on your PATH:
   - Linux: `~/.local/bin/obsidian` (make sure it's in PATH)
   - macOS: symlink at `/usr/local/bin/obsidian`
   - Windows: `Obsidian.com` terminal redirector
4. Restart your terminal. The Obsidian app must be **running** for CLI commands to work.

## Everyday commands

```bash
obsidian help                          # all commands
obsidian daily                         # open today's daily note
obsidian daily:append content="- [ ] Buy groceries"
obsidian search query="meeting notes"
obsidian read                           # read the current file
obsidian tasks daily                    # list tasks from daily note
obsidian create name="Trip to Paris" template=Travel
obsidian tags counts                    # all tags with frequency
obsidian diff file=README from=1 to=3   # compare versions
obsidian unresolved                     # find broken links
obsidian files sort=modified limit=5 --copy
```

## Developer / agent commands

```bash
obsidian eval "app.vault.getFiles().length"   # run JS in the app
obsidian dev:errors                            # review JS errors
obsidian dev:css selector=".workspace"         # inspect CSS
obsidian dev:dom selector=".nav"               # query DOM
obsidian dev:screenshot file=shot.png
obsidian plugin:reload my-plugin
```

## Agent usage

Agents (opencode, Claude, etc.) can drive the vaults through the CLI:

- **Read**: `obsidian search query="..."` / `obsidian read`
- **Write**: `obsidian create name="..." template=Concept` (uses the Eskolx templates)
- **Verify**: `obsidian unresolved` (broken links), `obsidian tags counts`
- **Automate**: cron jobs, morning routines, weekly summaries

Rules for agents: always work from a template, respect the folder routing in the templates, never commit secrets, and run `obsidian unresolved` before calling a note done.

## Headless Sync

Obsidian Sync can run without a GUI (headless) — useful for automated backups and server-side vault access. See https://obsidian.md/help/sync/headless
