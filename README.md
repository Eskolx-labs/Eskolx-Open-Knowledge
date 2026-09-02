# Eskolx-Open

**Public learning library** for statistics, statistical computing, programming, and data analysis automation. Notes are sourced from books and papers and feed the libraries Eskolx builds from scratch.

## Quick Start

1. **Install Obsidian** → https://obsidian.md/download (Windows / macOS / Linux). Version **1.9+** is required.
2. **Clone this repo:**
   ```bash
   git clone https://github.com/Eskolx-labs/Eskolx-Open-Knowledge.git
   ```
3. **Open the folder as a vault:** Obsidian → **Open another vault** → **Open folder as vault** → select the cloned folder.
4. **Trust the author:** when prompted, click **Trust**. This enables the plugins and theme.
5. **Done.** Press `Ctrl+Shift+A` for the **Eskolx Command Center** (new notes from templates).

That's it. No accounts, no sync setup, no tokens. Everything ships in the repo.

## Docs

The vault has a full set of guides in [docs/](docs/README.md). They build on each other, so you can read straight through:

1. [Getting started](docs/getting-started.md) — open the vault, trust the author, take your first look around.
2. [Keybindings](docs/keybindings.md) — the shortcuts that run this vault.
3. [Writing notes](docs/writing-notes.md) — templates, properties, tags, and linking.
4. [tldraw](docs/tldraw.md) — diagrams, the visual language of the library.
5. [Contributing](docs/contributing.md) — fork, write, open a pull request.

Start at the top. Each guide points to the next.

## Folder Structure

```
01 Projects/       public project pages
02 Knowledge/      settled atomic concept notes
03 Resources/      curated external resources (books, papers, courses, tools)
04 Research/       exploratory and in-progress research notes
90 Attachments/    all attachments, including animations/
90 Templates/      Templater + QuickAdd templates
99 Archive/        inactive material
Clippings/         web clippings from the Obsidian Web Clipper extension
docs/              guides and how-tos (tldraw, workflows, more as we add them)
```

No nesting beyond this.

## Contributing

Anyone can contribute. Fork the repo, make your changes, open a pull request against `main`. A maintainer reviews and merges.

- **`main` is protected.** Only the org owners (Natnael and Barkilign) can merge to it.
- Full instructions: [CONTRIBUTING.md](CONTRIBUTING.md) and the deeper [docs/contributing.md](docs/contributing.md).
- New to the vault? Read the [docs](docs/README.md) first. They take you from first open to first pull request.

## Plugins

The vault ships with: Obsidian Git, Dataview, Templater, QuickAdd, tldraw, Execute Code. Everything else is built-in (Properties, Bases, Backlinks, Search, Canvas, File Recovery). Add a plugin only when it solves a real recurring problem.

### tldraw

tldraw is a core part of this vault. Most notes should come with a diagram. Scenes live as real files under `90 Attachments/animations/` and are embedded in notes. New to tldraw? See [docs/tldraw.md](docs/tldraw.md). Agent-built scenes must survive a fresh clone on another machine:1. Every scene is saved as a real file in the vault (never left as unsaved local app state).
2. Files live under `90 Attachments/animations/` and are referenced with a normal relative embed link.
3. No animation depends on a personal/local tldraw setting. Palettes, fonts, and config are defined in the file itself, never in a machine's local app preferences.
4. Each animation gets a one-line note (frontmatter or caption) describing what it shows and, if an agent built it, what prompt/process would regenerate it.
5. Before calling an animation "done", clone the vault fresh on a second machine and confirm it renders with zero manual setup.

## Feature images (the embedding rule)

**Embed by URL by default; attachments only when necessary.** Every note has a feature image: an internet embed (`![Title](https://...)`), never a local file. The `cover` property points at the same URL.

- **Default:** URL embeddings (paper covers, reference diagrams, YouTube previews). Nothing enters the repo, nothing grows git.
- **Local attachment ONLY when Eskolx itself created the media** (own diagrams, tldraw scenes) or the source must survive offline. `90 Attachments/` stays small.
- **Cover style rule:** use a clean, flat, representative icon or diagram (like the Python logo), NOT a literal photo of people/places. Icons with dark strokes/silhouettes work best because the theme inverts them for dark mode, so they adapt to both light and dark themes.

## Public knowledge quality gate

Before a note is published, it must be: correct, understandable, referenced, self-contained, free of private information and secrets, and learnable by another student.

## Visual Identity

One shared theme (`eskolx.css` snippet) with two modes: the same visual family, different atmosphere.

- **Light** = Open palette (warm cream/beige, grape, clay, muted green). This is the public learning library.
- **Dark** = Core palette (near-black, parchment, grape purple, harvest red, muted green). Used by the private org vault.

The theme, accent color, translucency, and the enabled `eskolx` snippet ship in `.obsidian/appearance.json` (committed), so a fresh install looks right immediately with no manual setup. Personal tweaks go in `.obsidian/snippets/eskolx-personal.css` (gitignored, stays yours).

## Python + LaTeX

- **Python**: use the Execute Code plugin. Put code in a ` ```python ` block and click the ▶ Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian (MathJax). Use `$...$` for inline, `$$...$$` for display. No plugin needed.

## License

MIT. See [LICENSE](LICENSE).
