# tldraw in this vault

tldraw is the diagram tool built into this vault. Most notes should come with a diagram. This guide covers the basics: create, save, embed, and keep diagrams portable.

## What tldraw is

tldraw is an Obsidian plugin that gives you an infinite whiteboard. You draw shapes, arrows, text, and freehand sketches. Scenes are saved as real files in the vault, so they live in git like any other note.

## Create a diagram

1. Open the command palette (`Ctrl+P`).
2. Run **tldraw: Create new tldrawing**.
3. A new tldraw file opens. Draw.

The file is created in the vault root by default. Move it to `90 Attachments/animations/` before you embed it (see below).

## The basics

- **Select** (`V`): click and drag to select shapes.
- **Draw** (`D`): freehand sketch.
- **Box** (`R`): rectangle.
- **Ellipse** (`O`): circle or ellipse.
- **Arrow** (`A`): connect two shapes.
- **Text** (`T`): add a label.
- **Hand** (`H`): pan the canvas.
- **Zoom**: scroll to zoom, or use the zoom tool.
- **Delete**: select a shape and press `Delete`.

Press `?` on the canvas for the full shortcut list.

## Save

tldraw autosaves to the file. There is no save button. The file is a real `.tldr` file in the vault, so it is versioned with git like any other note.

## Embed in a note

1. Move the file to `90 Attachments/animations/` (drag it in the file explorer).
2. In the note, type `![[filename.tldr]]` or use the embed command.
3. The diagram renders inline in the note.

The embed is a normal relative link. Anyone who clones the vault sees the diagram.

## Portability rules

Diagrams must survive a fresh clone on another machine. Follow these rules:

1. Every scene is saved as a real file in the vault. Never leave a diagram as unsaved local app state.
2. Files live under `90 Attachments/animations/` and are referenced with a normal relative embed link.
3. No diagram depends on a personal or local tldraw setting. Palettes, fonts, and config are defined in the file itself, never in a machine's local app preferences.
4. Each diagram gets a one-line note (frontmatter or caption) describing what it shows and, if an agent built it, what prompt or process would regenerate it.
5. Before calling a diagram done, clone the vault fresh on a second machine and confirm it renders with zero manual setup.

## When to use a diagram

- A concept that is easier to see than to read. Draw it.
- A flow or process. Draw the steps.
- A relationship between ideas. Draw the connection.
- A common mistake. Draw the wrong way and the right way.

If a note already has a diagram, improve it or leave it. Do not duplicate.
