---
type: concept
status: active
area: tooling
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [onboarding, tooling]
cover: https://upload.wikimedia.org/wikipedia/commons/3/31/Key_enter_icon_02.png
---

![Guide — Obsidian Basics cover](https://upload.wikimedia.org/wikipedia/commons/3/31/Key_enter_icon_02.png)

# Guide — Obsidian Basics

> The absolute fundamentals, assuming you've never opened Obsidian. By the end you'll know what a vault is, how to navigate, and how to write and link notes.

## What Obsidian Is

Obsidian is a **note-taking app that reads and writes plain Markdown files** on your computer. There is no database, no lock-in, no account required.

- A **vault** is just a folder of `.md` files (plus a hidden `.obsidian/` folder with app config).
- Because notes are plain files, they are **portable and version-controlled** with Git — that's how the Eskolx vaults sync and back up.
- An **Eskolx vault** is a normal Obsidian vault plus a set of templates, plugins, and rules that make it a shared lab operating system. You only ever touch the `.md` files; everything else is pre-configured.

## First Launch

1. **Install** Obsidian → https://obsidian.md/download (Windows / macOS / Linux). Version **1.9+**.
2. **Open the vault:** Obsidian → **Open another vault** → **Open folder as vault** → select the vault folder (e.g. `Eskolx-Core`).
3. When prompted **"Trust author and enable plugins?"** → **Trust**. This enables the community plugins the vault relies on.
4. **Done.** The theme, accent, and layout load automatically. Your personal tweaks go in `.obsidian/snippets/eskolx-personal.css` — it's gitignored, so your look is yours and never pushed to others.

> Never open the vault without trusting the author, or links, shelves, and sync won't work.

## The Interface

- **Left sidebar**: file explorer (the folder tree — Eskolx folders are numbered `00 Home` … `99 Archive`), search, and quick switcher. The first time you open the vault a Notebook Navigator dual-pane explorer may appear — it's a friendlier view of the same files; the classic explorer is still there if you prefer it.
- **Center**: the editor. **Live Preview** shows formatted text while you type; `Ctrl+E` toggles between **edit** and **reading** view.
- **Right sidebar**: backlinks, outline, and Related Notes — panels that show how the current note connects to the rest of the vault.
- **Bottom status bar**: Git status (last pull/push time).

## The Two Most Important Shortcuts

1. **`Ctrl+P` — Command Palette.** Every single thing Obsidian can do is a command. Type to filter, press Enter to run. If you forget a hotkey, this is your memory.
2. **`Ctrl+O` — Quick Switcher.** Open any note by typing part of its name. This is faster than clicking folders.

## Markdown in 10 Minutes

Notes are plain text with light formatting. Everything below is what you'll actually use:

```markdown
# Big heading
## Medium heading
### Small heading

**bold**  *italic*  ==highlight==  ~~strikethrough~~

- bullet list
- second bullet
  - indented sub-item

1. numbered
2. list

- [ ] unchecked task
- [x] checked task

> [!note] Callout
> A colored box. `note`, `warning`, `insight`, `question` etc.

`inline code` and:

```python
print("code block")
```

$E[X] = \sum_x x \cdot P(X=x)$   (inline math)

$$  \int_{-\infty}^{\infty} f(x)\,dx = 1 $$   (display math)

[link text](https://example.com)   (external link)

![image alt](https://example.com/image.png)   (image embed)
```

### Internal links are the superpower

- `[[Note Name]]` — a **link to another note**. Click it to jump; Obsidian tracks it in Backlinks.
- `[[Note Name|alias]]` — a link that displays different text.
- `[[Note Name#Heading]]` — link to a specific heading.
- `![[Image.png]]` — **embed** a file's contents inline (images, other notes, even tldraw scenes).
- Eskolx convention: **embed by URL** (`![Title](https://…)`), not local files, for everything except Eskolx-made media. See the Rules guide.

When you type `[[`, Obsidian suggests existing notes — the vault is a graph, and linking is how the graph grows.

## Properties (frontmatter)

The block at the very top of every note between two `---` lines is **frontmatter** — structured metadata:

```yaml
---
type: concept
status: active
area: statistics
author: Natnael
created: 2026-08-17
tags: [distributions]
cover: https://…
---
```

- In edit mode it shows as raw YAML; in reading view and the **Properties** panel (top of the note) it's a friendly form.
- Properties are how the vault **organizes itself**: dashboards query `type`, `status`, `area`, etc. (see the Workflows guide).
- Eskolx rule: **properties are canonical** — don't repeat a fact in the folder, a tag, and a property. Keep the schema from [[Guide — Rules and Structure]].
- `participants` is machine-generated — never edit it by hand.

## Tags vs Links vs Properties

| Tool | Use for | Example |
|---|---|---|
| **Properties** | Canonical facts you query | `status: active`, `type: decision` |
| **Links** | Connections between notes | `[[Student t Distribution]]` |
| **Tags** | Topical discovery across folders | `#distributions`, `#tooling` |

Eskolx keeps these roles strict: `type`/`status`/`area` never become tags, and tags are topical only. That keeps the dashboards reliable.

## Searching

- **`Ctrl+Shift+F`** — full-text search across the vault.
- The search box on the left also searches filenames as you type.
- Advanced: `path:"04 Knowledge"` or `tag:#tooling` or `"exact phrase"`. Most of the time plain words are enough.

## Graph View

Open **Graph view** (command palette or the left ribbon) to see the whole vault as a network — each note a node, each link an edge. It's a map of the lab's thinking. Clusters you didn't create are usually concepts you *should* link.

## Where To Go Next

You now know enough to read and write notes. Next: [[Guide — Workflows]] — how the Eskolx loop actually works day to day.