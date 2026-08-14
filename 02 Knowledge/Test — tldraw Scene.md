---
type: concept
status: draft
area: tooling
created: 2026-08-14
updated: 2026-08-14
publish-status: draft
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Standard_deviation_diagram_micro.svg/500px-Standard_deviation_diagram_micro.svg.png
---

![Test — tldraw Scene cover](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Standard_deviation_diagram_micro.svg/500px-Standard_deviation_diagram_micro.svg.png)

# Test — tldraw Scene

> [!insight] What this shows
> A minimal tldraw scene (one rectangle labeled "Eskolx") used to verify the portability rules: it must render on a fresh clone with zero manual setup. Regenerate with: tldraw plugin → new file → add a rectangle → save as `.tldr`.

![[Test Scene.tldr]]

## Portability Check

1. This scene is a real file in `90 Attachments/animations/` (not unsaved app state).
2. It is embedded here **and** linked: [[Test Scene.tldr]].
3. No local settings are required — colors/fonts are defined in the file itself.
4. If it renders on a fresh clone, the portability rules hold.

## Animation Support (checked 2026-08-14)

The tldraw Obsidian plugin embeds **static scene previews only** — it is a drawing/whiteboard tool, not an animation player. There is no animation playback in embeds (confirmed against the plugin's own docs: "Preview the drawing when a tldraw file is referenced in markdown").

Consequence: the "agent-generated animations in Obsidian" goal does not work with tldraw as-is. Options if we want motion later: export frames as images and embed them, or use a different tool (e.g. HTML/iframe embeds). For now, tldraw stays a static-diagram tool.
