# Eskolx-Open Agent Guide

This is the **public** Eskolx learning library. Agents working here must follow these rules.

For the human-facing guides, see [docs/](docs/README.md). They cover setup, keybindings, writing notes, tldraw, and contributing.

## Identity

- **Vault**: Eskolx-Open (public: statistics/computing knowledge, research, tutorials)
- **Repo**: `Eskolx-labs/Eskolx-Open-Knowledge` (public, GitHub org)
- **Git flow**: `main` is protected. Only merge-holders (the org owners, Natnael and Barkilign) merge to it. Everyone else works on a fork and opens a pull request against `main`. The PR is the review.
- **Merge ≠ publish.** A note that reaches `main` is in the library. It is only `published` when a maintainer has reviewed it against the quality gate and flipped `publish-status`.

## Setup (fresh clone, one time)

Bring a fresh clone to a working state. Follow every step; do not skip verification.

1. **Preflight.** Git installed with an identity, `gh` installed and authenticated (`gh auth login`), Obsidian 1.9+ installed.
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your-github-username@users.noreply.github.com"
   ```
   The noreply address is mandatory for this public vault. Never use a personal email; this repo is public and everything lands in git history.
2. **Clone.**
   ```bash
   git clone https://github.com/Eskolx-labs/Eskolx-Open-Knowledge.git
   ```
3. **Open in Obsidian.** Obsidian → **Open another vault** → **Open folder as vault** → select the folder. When asked **"Trust author and enable plugins?"** click **Trust**. Without trust, every community plugin stays disabled and the theme/snippets do not load.
4. **Verify plugins.** Settings → Community plugins: Obsidian Git, Dataview, Templater, QuickAdd, tldraw, Execute Code must all be **Enabled**.
5. **Verify appearance.** Settings → Appearance: light theme, grape accent (`#6E3B68`), `eskolx` snippet enabled. If `eskolx-personal.css` is missing, create an empty one so the snippet toggle is not missing:
   ```bash
   touch .obsidian/snippets/eskolx-personal.css
   ```
6. **Verify templates.** `Ctrl+T` opens the template picker (Concept, Project, Research, Resource). `Ctrl+Shift+A` opens the Eskolx Command Center. Create one test note from a template; it must auto-route to the correct folder and contain no raw `<% %>` text. Delete the test note afterwards.
7. **Verify tldraw.** Open `90 Attachments/animations/` in the file explorer; `.tldr` scenes open as tldraw canvases. No scene may depend on local machine settings; if one renders blank, pull again, do not create a local config to "fix" it.

### Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Plugins greyed out / theme not applied | Community plugins not trusted | Settings → Community plugins → enable, or reopen vault and click **Trust** |
| Template picker empty | Templater not enabled or templates folder unset | enable Templater; Settings → Templater → Template folder location: `90 Templates` |
| Vault shows wrong theme colors | appearance.json overwritten | `git checkout -- .obsidian/appearance.json` then reopen vault |
| Push to `main` rejected | `main` is protected | Work on a fork and open a pull request. Only merge-holders merge to `main` |

## Non-negotiables

1. **Never store secrets.** No passwords, API keys, tokens, SSH keys in any file. Ever. This repo is PUBLIC. Leaked secrets cannot be unwritten from history.
2. **Public knowledge must stand on its own.** A note must be understandable by someone who wasn't in the room. No "internal notes copy-pasted".
3. **One note, one job.** Atomic notes.
4. **Properties are canonical.** `type`, `status`, `area`, `owner`, `author`, `created`, `updated`, `tags`, `publish-status`. Never duplicate a fact in folder + tag + property.
5. **Embeddings by URL are the default; attachments only when necessary.** Every note has a feature image, an internet embed (`![Title](https://...)`), never a local file. Set the `cover` property to the same URL.
   - Default: embed by URL (papers, reference diagrams, YouTube previews, covers).
   - Local attachment ONLY when Eskolx itself created the media (own diagrams, tldraw scenes) or the source must survive offline. Everything else embeds from the internet.
   - **Cover style rule:** use a clean, flat, representative icon or diagram (like the Python logo), NOT a literal photo of people/places. The image should be a simple symbol for the topic, easy to read at small size. Icons with dark strokes/silhouettes work best because the theme inverts them for dark mode (see `eskolx.css`), so they adapt to both light and dark themes.
6. **Always work from a template.** Templates live in `90 Templates/` and self-route via `tp.file.move`. Never hand-write from scratch.
7. **Folders are broad buckets.** Never deep subfolders.
8. **Tags are topical only.** `#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding`. `type`/`status`/`area` never become tags.
9. **Link as much as you can.** Every note connects to every other note it relates to, with `[[Note Name]]`. A note that links nothing is a dead end. Create the linked note if it does not exist yet.
10. **Most notes come with a tldraw diagram.** Draw the concept, flow, or relationship. Save it under `90 Attachments/animations/` and embed it. See `docs/tldraw.md` for how.
11. **Review flow.** New notes start `publish-status: draft`. A maintainer flips to `review` when they start checking the note against the quality gate, then to `published` when it passes. Home's Needs Attention shelf surfaces notes in `review`.
12. **Grep for secrets before any push.** `rg -i "password|api[_-]?key|token|BEGIN.*PRIVATE KEY" .`

## Note types and folders

| type | folder |
|---|---|
| project | `01 Projects/` |
| concept | `02 Knowledge/` |
| resource | `03 Resources/` |
| research | `04 Research/` |

## Template routing

Templates contain `<%* await tp.file.move("<folder>/" + tp.file.title + ".md") %>`. They move the created note to the right folder automatically. When creating notes directly (CLI or file write), place them per the table above.

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

13. `obsidian unresolved` shows no broken links (or intentional)
14. No raw `<% tp. %>` tags in created notes (templates only)
15. Frontmatter has `type`, `status`, `author`, `created`, `updated`, `tags`, `publish-status`
16. Note is in the correct folder per the table above
17. Note links to everything it relates to
18. Note has a tldraw diagram where one helps
19. No secrets grep hits
20. Never on `main`; your work is on a fork branch, submitted as a PR
