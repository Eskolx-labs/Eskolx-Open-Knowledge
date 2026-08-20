---
type: concept
status: active
area: tooling
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Gear_icon.svg/500px-Gear_icon.svg.png
tags: [tooling, onboarding]
publish-status: published
---

# Correct Setup Instructions for Agents

![Correct Setup Instructions cover](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Gear_icon.svg/500px-Gear_icon.svg.png)

Purpose: bring a fresh clone of an Eskolx vault on a new machine to a fully working state: correct branch, authenticated git sync, all plugins enabled, correct theme, working tldraw, templates, QuickAdd, authorship dots. Follow every step. Do not skip verification.

Applies to both vaults. This file exists in `Eskolx-Core` and `Eskolx-Open`; the vault-specific facts are in the tables below. Determine which vault you are in first: check the git remote.

```bash
git remote get-url origin
```

| Vault | Repo | Branch to work on | Theme | Accent |
|---|---|---|---|---|
| Eskolx-Core | `Eskolx-labs/Eskolx-Core-Knowledge` (private) | `main` | dark (`obsidian`) | `#6F3A67` |
| Eskolx-Open | `Eskolx-labs/Eskolx-Open-Knowledge` (public) | `develop` (never `main`) | light (`moonstone`) | `#6E3B68` |

---

## Step 1 - Preflight (check before touching anything)

Run from the vault root:

```bash
git status
git branch --show-current
git --version
gh --version
gh auth status
```

Requirements:

- Git installed and configured with an identity:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your-github-username@users.noreply.github.com"
  ```
  The noreply address is mandatory for this public vault (never a personal email - this repo is public, everything lands in git history).
- `gh` installed and authenticated as the user's GitHub account:
  ```bash
  gh auth login
  ```
  Follow the interactive prompt (HTTPS, authenticate via browser or token). The account must be a member of the `Eskolx-labs` org with access to the Open repo.
- Obsidian 1.9 or newer installed (https://obsidian.md/download). Required for Bases/card shelves.

If any requirement is missing, install it before continuing. Do not proceed with a broken auth.

---

## Step 2 - Correct branch (critical)

**Eskolx-Open: must be on `develop`, never `main`.** A fresh clone lands on `main`; fix it:

```bash
git fetch origin develop:refs/remotes/origin/develop
git checkout -B develop origin/develop
```

Never push to `main`. `main` is protected: only the merge-holders (Natnael, Barkilign) merge to it via GitHub's compare-and-merge (a PR). Everyone else works on `develop` and auto-syncs to it.

Then install the guard hooks:

```bash
bash scripts/install-hooks.sh
```

Expected output: `installed .git/hooks/pre-push` and `on develop (live shared branch)`.

What the guard does (do not disable it):

- Blocks any push to `main`.
- Blocks changes to locked paths on any branch: `.obsidian/`, `90 Templates/`, `scripts/`, any `*.py`, `*.sh`, `*.js`, `**/cache.json`. The executable surface changes only via `main` (merge-holders).
- Blocks pushes containing obvious secrets.

**Eskolx-Core:** must be on `main`.

```bash
git checkout main
git pull origin main
```

Core has no guards; it is the private org vault and only the core team has access.

---

## Step 3 - Git sync configuration

The vault ships its own Obsidian Git config in `.obsidian/plugins/obsidian-git/data.json`. Verify it is intact (all must be true/set):

| Setting | Expected |
|---|---|
| `autoBackupAfterFileChange` | `True` |
| `autoPullOnBoot` | `True` |
| `autoPullInterval` | `15` |
| `autoPushInterval` | `15` |
| `pullBeforePush` | `True` |

If `data.json` is missing or corrupt, restore it from git: `git checkout -- .obsidian/plugins/obsidian-git/data.json`.

Test that sync actually works before opening Obsidian. A clean round-trip:

```bash
bash scripts/sync.sh
```

Expected: a pull happens; if there are local changes they are committed and pushed. On Open while on `main` it prints `sync.sh: on main - pulling read-only` and exits 0 - that is correct behavior, but you must still switch to `develop` (Step 2).

The user must also add a GitHub Personal Access Token for Obsidian Git if `gh` is not usable inside Obsidian's terminal. Do this only if the in-app push fails:

1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic), scope `repo`.
2. Obsidian → Settings → Community plugins → Obsidian Git → authentication: paste the token, or set the system git credential helper to `gh auth git-credential`.

Token hygiene: the token must be scoped to the Open repo only if it is a fine-grained token, and it must live in the OS keychain, never in a vault file. This repo is public.

---

## Step 4 - First Obsidian launch (the step everyone gets wrong)

Open Obsidian → **Open another vault** → **Open folder as vault** → select the vault folder.

When the dialog asks **"Trust author and enable plugins?"** the user MUST click **Trust**. Without trust, every community plugin stays disabled and the theme/snippets do not load. If the dialog was dismissed with "Don't trust", fix it:

- Obsidian → Settings → Community plugins → **Turn on community plugins** (toggle), then ensure the 12 plugins below are all **Enabled**.
- If prompted to confirm enabling plugins from the vault, accept.

After trust, wait for the plugin list to settle, then verify (Step 5).

---

## Step 5 - Verification checklist (run all of it)

### 5a. Community plugins - exactly these 12, all enabled

| Plugin | Check |
|---|---|
| Obsidian Git | Settings → Community plugins → enabled; Status bar shows branch (bottom-right) |
| Dataview | enabled |
| Templater | enabled; Settings → Templater → "Trigger Templater on new file creation" ON |
| QuickAdd | enabled; `Ctrl+Shift+A` opens "Eskolx Command Center" |
| tldraw | enabled; `90 Attachments/animations/` files open as scenes |
| Execute Code | enabled; python3 configured (Settings → Execute Code → Python binary: `python3`) |
| Tasks | enabled |
| Translucent BG | enabled |
| Highlightr | enabled; `Ctrl+Shift+E` shows the color menu |
| Eskolx Authorship | enabled; dots appear in the right margin of edited notes |
| Notebook Navigator | enabled |
| Related Notes | enabled |

Verify programmatically (plugin manifests present):

```bash
python3 - <<'EOF'
import json, os
cp = json.load(open('.obsidian/community-plugins.json'))
missing = [p for p in cp if not os.path.exists(f'.obsidian/plugins/{p}/main.js')]
print('plugins:', len(cp), 'missing:', missing)
EOF
```

Expected: `plugins: 12 missing: []`.

### 5b. Appearance (theme)

```bash
python3 -c "
import json
ap = json.load(open('.obsidian/appearance.json'))
print('theme:', ap['theme'], 'accent:', ap['accentColor'], 'snippets:', ap['enabledCssSnippets'])
"
```

Expected: Core = `theme: obsidian`, accent `#6F3A67`. Open = `theme: moonstone`, accent `#6E3B68`. Snippets contain `eskolx` and `eskolx-personal`.

In Obsidian, Appearance → Theme shows dark (Core) / light (Open), and the grape accent is applied.

The `eskolx-personal.css` snippet is gitignored, so a fresh clone has no such file. Create an empty one so the snippet toggle is not missing:

```bash
touch .obsidian/snippets/eskolx-personal.css
```

### 5c. Core plugins

Settings → Core plugins: file explorer, global search, switcher, graph, backlink, outgoing link, tag pane, page preview, daily notes, command palette, editor status, bookmarks, outline, file recovery, workspaces, canvas, properties, bases must be enabled. Sync and Templates core plugins must be OFF (Git is the sync; Templater replaces core templates).

### 5d. Git sync round-trip (the real proof)

```bash
git status --short          # expect: empty or only personal gitignored files
bash scripts/sync.sh        # expect: pull, commit if needed, "ok: pushed" or "up to date"
```

Then in Obsidian: bottom-right status bar shows the branch name (`develop`). Open the command palette (`Ctrl+P`) → "Git: Pull" → green notice "Pulled" or "Already up to date".

### 5e. Templates, QuickAdd, routing

- `Ctrl+T` opens the template picker with the vault's templates (Core: Daily, Idea, Meeting, Person, Project, Decision. Open: Concept, Daily, Person, Project, Research, Resource, Tutorial).
- `Ctrl+Shift+A` opens the Eskolx Command Center with the vault's choices.
- Create one test note from a template; it must auto-route to the correct folder and contain no raw `<% %>` text. Delete the test note afterwards (right-click → delete) and push the deletion.

### 5f. tldraw

- Plugin enabled (5a).
- Open `90 Attachments/animations/` in the file explorer; `.tldr` scenes open as tldraw canvases.
- No scene may depend on local machine settings; if one renders blank, pull again (`Ctrl+Shift+P`), do not create a local config to "fix" it.

### 5g. Authorship dots

- The plugin is enabled; `.obsidian/eskolx-authorship/cache.json` exists (it is tracked; if missing run `python3 scripts/authorship.py .` from the repo root of the eskolx-tests checkout, or restore: `git checkout -- .obsidian/eskolx-authorship/cache.json`).
- Open a note that has `participants:` in frontmatter - colored dots appear in the right margin.

### 5h. The guard (Open only)

```bash
git push origin main 2>&1 | grep -qi "BLOCKED" && echo "guard blocks main" || echo "GUARD FAILED"
```

Expected: `guard blocks main`. If it prints `GUARD FAILED`, re-run `bash scripts/install-hooks.sh` and check that `.git/hooks/pre-push` exists and is executable.

---

## Step 6 - Report

When everything above passes, report to the user:

```
Setup complete:
- vault: <Core|Open>, branch: <main|develop>
- plugins: 12/12 enabled
- theme: <dark|light>, accent applied
- sync: pull/commit/push verified (<message>)
- templates + QuickAdd routing verified
- tldraw: scenes open
- authorship dots: visible
```

If any check fails, fix the cause before reporting. Do not report success with a known failure.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Plugins greyed out / theme not applied | Community plugins not trusted | Settings → Community plugins → enable, or reopen vault and click **Trust** |
| `Push to main` rejected (Open) | main is protected | Work on `develop`. Only merge-holders merge main via PR |
| Guard blocks my push (Open) | pre-push hook | `scripts/install-hooks.sh` should already have installed it; read the block message: main push, locked path (`.obsidian/`, `90 Templates/`, `scripts/`, `*.py`, `*.sh`, `*.js`, `cache.json`), or a possible secret. Fix the cause and push again |
| `gh` not authenticated | no login | `gh auth login` |
| `sync.sh: gh: not found` | gh not on PATH for the script | install gh, or run the sync from Obsidian Git instead |
| `error: src refspec develop does not match any` | branch missing locally | `git fetch origin develop:refs/remotes/origin/develop && git checkout -B develop origin/develop` |
| Vault shows wrong theme colors | appearance.json overwritten | `git checkout -- .obsidian/appearance.json` then reopen vault |
| Dots missing | cache missing or plugin off | restore cache from git; ensure Eskolx Authorship enabled |
| Template picker empty | Templater not enabled or templates folder unset | enable Templater; Settings → Templater → Template folder location: `90 Templates` |
