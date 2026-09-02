# Contributing to Eskolx-Open

Anyone can contribute. This is a public learning library. Notes are written by learners, not experts. Errors and improvements are welcome.

## Ways to contribute

- Write or improve a concept note in `02 Knowledge/`
- Answer a research question in `04 Research/`
- Add a curated resource to `03 Resources/`
- Add or improve a project page in `01 Projects/`
- Draw a tldraw diagram for a note that lacks one
- Review open pull requests
- Point out errors in published notes. Open an issue or a PR
- Improve the docs in `docs/` (guides, workflows, how-tos)

## The quality gate

Before a note is published, it must be:

- Correct
- Understandable
- Referenced
- Self-contained
- Free of private information and secrets
- Learnable by another student

If any answer is no, keep it in draft/review.

## First contribution (under 30 minutes)

1. **Fork** the repo on GitHub: `Eskolx-labs/Eskolx-Open-Knowledge`.
2. **Clone your fork:**
   ```bash
   git clone https://github.com/<your-username>/Eskolx-Open-Knowledge.git
   cd Eskolx-Open-Knowledge
   git remote add upstream https://github.com/Eskolx-labs/Eskolx-Open-Knowledge.git
   ```
3. **Branch:**
   ```bash
   git checkout -b yourname/first-note
   ```
4. **Write a note.** Open the vault in Obsidian and use `Ctrl+Shift+A` → **New Concept** (or New Research). A good first contribution: a short atomic concept note in `02 Knowledge/`, e.g. *"What is the difference between a population and a sample?"* Fill in every section, even briefly.
5. **Commit:**
   ```bash
   git add .
   git commit -m "docs: add first contribution note"
   ```
6. **Push and PR:**
   ```bash
   git push -u origin yourname/first-note
   ```
   Open a pull request on GitHub against `main`. A maintainer reviews and merges.

## Note standards

Templates live in `90 Templates/` and self-route to the right folder. Use them. The sections below are the shape a good note takes, not a checklist you must fill every line of. Write what the note needs.

### Concept notes (`02 Knowledge/`)

Definition, Intuition, Why it matters, How it works, Example, Common Mistakes, Implementation, Related Concepts, References.

### Research notes (`04 Research/`)

Abstract, Motivation, Method, Results, Discussion, Open Questions, Related Concepts, References.

### Resource notes (`03 Resources/`)

What it is, Why we recommend it, How to use it, Related Concepts, Notes.

### Project notes (`01 Projects/`)

Purpose, Outcome, Current Status, Milestones, Current Work, Blockers, Open Questions, Knowledge, Decisions, Contributors, GitHub, Next Actions.

## Linking

**Link as much as you can.** Every note should connect to every other note it relates to. Use `[[Note Name]]` for anything already in the vault, and create the note if it does not exist yet. A note that links nothing is a dead end. The graph is the library's index; links are what make it navigable.

- Link related concepts, not just the obvious ones.
- Link the note that explains a term you use.
- Link the project a research note feeds into.
- Link the resource a concept note draws from.

## Diagrams

**Most notes should come with a tldraw diagram.** A picture of the idea beats a paragraph of text. Draw the concept, the flow, the relationship, the mistake. Save it as a real file under `90 Attachments/animations/` and embed it in the note.

- New to tldraw? See [docs/tldraw.md](docs/tldraw.md) for how to create, save, and embed a diagram.
- Diagrams must survive a fresh clone. Follow the portability rules in [docs/tldraw.md](docs/tldraw.md).
- If a note already has a diagram, improve it or leave it. Do not duplicate.

## Properties

Use only properties you will actually query:

```yaml
type: concept        # project | concept | resource | research
status: draft        # per-type controlled values
area: statistics     # statistics | numerical-methods | computing | ...
created: 2026-09-02
updated: 2026-09-02
publish-status: draft   # draft | review | published | archived
```

Never duplicate the same fact across folder + tag + property. Properties are canonical.

## Tags

Tags are only for topical/domain discovery that cuts across folders and projects. Never for anything already captured by a property. Starter set (expand only when a real gap shows up):

`#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding`

`type`, `status`, and `area` stay properties only; they never become tags too.

## Controlled values

- **Project status**: idea, planned, active, blocked, review, completed, archived
- **Research status**: question, active, needs-review, validated, published, archived
- **Publishing status**: draft, review, published, archived
- **Priority**: low, normal, high, critical

## Git

Branch-per-edit + PR, never direct to `main`. Commit with meaningful messages:

```text
research: investigate t-distribution tails
docs: explain inverse transform sampling
project: update distribution rebuild status
```

## Reviewing work

The PR is the review step. When reviewing:

1. Does it stand on its own for someone outside the room?
2. Correct, referenced, self-contained, no private info, no secrets?
3. Is it well linked? Does it connect to everything it relates to?
4. Does it have a diagram where one would help?
5. Is it atomic (one note, one job)?

## Code of conduct

Be excellent to each other. Learning in public is collaborative.

- Be respectful and constructive in reviews and discussion
- Critique ideas, not people
- Assume good faith. Public notes are written by learners, not experts
- Flag errors in a helpful way (open an issue, propose a fix)

Unacceptable: harassment, discrimination, personal attacks, publishing private information, spam, deliberately incorrect or misleading contributions.

Report issues to a maintainer through the Eskolx GitHub organization.
