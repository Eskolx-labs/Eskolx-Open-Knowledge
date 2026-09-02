# Writing notes

How notes are made in this vault. Templates do the heavy lifting; you fill in the content.

## Start from a template

Every note starts from a template. Press `Mod+Shift+A` and pick a type, or `Mod+T` for the template picker. The template creates the note, fills in the frontmatter, and moves it to the right folder. You never hand-write a note from scratch.

The four types:

| Type | Folder | What it is |
|---|---|---|
| Concept | `02 Knowledge/` | a settled idea, explained |
| Research | `04 Research/` | an open question, in progress |
| Resource | `03 Resources/` | a book, paper, course, or tool |
| Project | `01 Projects/` | a project page |

## The shape of a note

Templates give each type a set of sections. They are guidance, not a checklist. Write what the note needs. A short note that says one thing well beats a long note that says nothing.

- **Concept**: Definition, Intuition, Why it matters, How it works, Example, Common Mistakes, Implementation, Related Concepts, References.
- **Research**: Abstract, Motivation, Method, Results, Discussion, Open Questions, Related Concepts, References.
- **Resource**: What it is, Why we recommend it, How to use it, Related Concepts, Notes.
- **Project**: Purpose, Outcome, Current Status, Milestones, Current Work, Blockers, Open Questions, Knowledge, Decisions, Contributors, GitHub, Next Actions.

## Properties

Frontmatter is the metadata at the top of every note. The template fills most of it. The ones you set by hand:

- `type`: concept, research, resource, or project. The template sets it.
- `status`: where the note is in its lifecycle. See [Contributing](contributing.md) for the values.
- `area`: the domain, e.g. `statistics`, `numerical-methods`, `computing`.
- `tags`: topical tags for discovery across folders.
- `publish-status`: draft, review, published, or archived.

Never duplicate a fact in folder, tag, and property. Properties are canonical.

## Tags

Tags are for topical discovery that cuts across folders. They are not for anything a property already captures. `type`, `status`, and `area` stay properties; they never become tags. Starter set: `#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding`. Add a tag only when a real gap shows up.

## Linking

**Link as much as you can.** Every note connects to every other note it relates to. Type `[[` and pick the note. If the note does not exist yet, create it. A note that links nothing is a dead end. The graph is the library's index; links are what make it navigable.

- Link related concepts, not only the obvious ones.
- Link the note that explains a term you use.
- Link the project a research note feeds into.
- Link the resource a concept note draws from.

## Diagrams

**Most notes should come with a tldraw diagram.** A picture of the idea beats a paragraph of text. Draw the concept, the flow, the relationship, the mistake. Save it under `90 Attachments/animations/` and embed it in the note. See [tldraw](tldraw.md) for how.

## Feature images

Every note has a feature image: an internet embed, never a local file. Set the `cover` property to the same URL. Embed by URL by default; use a local attachment only when Eskolx created the media (own diagrams, tldraw scenes) or the source must survive offline.

## Python and LaTeX

- **Python**: put code in a ` ```python ` block and click the Run button. Configured to use `python3`.
- **LaTeX math**: built into Obsidian. Use `$...$` for inline, `$$...$$` for display.

## Next

Notes are text. Diagrams are the visual layer. Learn them in [tldraw](tldraw.md), then how to give back in [Contributing](contributing.md).
