# Getting started

Five minutes to a working vault. Follow these steps in order.

## 1. Install Obsidian

Download Obsidian from https://obsidian.md/download (Windows, macOS, Linux). Version 1.9 or newer is required. You do not need an Obsidian account or the paid sync.

## 2. Clone the repo

```bash
git clone https://github.com/Eskolx-labs/Eskolx-Open-Knowledge.git
```

## 3. Open the folder as a vault

Obsidian → **Open another vault** → **Open folder as vault** → select the cloned folder.

## 4. Trust the author

When Obsidian asks **"Trust author and enable plugins?"**, click **Trust**. This enables the community plugins and the theme. Without trust, plugins stay disabled and the vault looks plain.

## 5. Take a look around

- Press `Ctrl+Shift+H` to open Home, the dashboard.
- Press `Ctrl+Shift+A` to open the **Eskolx Command Center**, the menu for creating new notes.
- Press `Ctrl+O` to jump to any note by name.

That is it. No accounts, no sync setup, no tokens. Everything ships in the repo.

## What you have now

- A themed vault with the Eskolx look.
- Templates for the four note types: Concept, Project, Research, Resource.
- tldraw for diagrams.
- Execute Code for running Python inside notes.
- Obsidian Git for version control. It auto-commits your changes locally. Nothing leaves your machine until you push.

## Next

Learn the shortcuts in [Keybindings](keybindings.md), then how notes are made in [Writing notes](writing-notes.md).

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Plugins greyed out, theme not applied | Community plugins not trusted | Settings → Community plugins → enable, or reopen the vault and click **Trust** |
| Template picker empty | Templater not enabled or templates folder unset | enable Templater; Settings → Templater → Template folder location: `90 Templates` |
| Vault shows wrong colors | appearance.json overwritten | `git checkout -- .obsidian/appearance.json` then reopen the vault |
