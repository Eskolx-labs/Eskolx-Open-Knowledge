---
type: concept
status: draft
area: tooling
created: 2026-08-14
updated: 2026-08-14
publish-status: draft
---

# Test — tldraw Scene

> [!insight] What this shows
> A minimal tldraw scene (one rectangle labeled "Eskolx") used to verify the portability rules: it must render on a fresh clone with zero manual setup. Regenerate with: tldraw plugin → new file → add a rectangle → save as `.tldr`.

![[Test Scene.tldr]]

## Portability Check

1. This scene is a real file in `90 Attachments/animations/` (not unsaved app state).
2. It is embedded here **and** linked: [[Test Scene.tldr]].
3. No local settings are required — colors/fonts are defined in the file itself.
4. If it renders on a fresh clone, the portability rules hold.
