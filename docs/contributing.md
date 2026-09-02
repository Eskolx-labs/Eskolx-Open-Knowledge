# Contributing

The full contribution workflow. If you just want to write a note, the short version is in the [main CONTRIBUTING.md](../CONTRIBUTING.md). This guide goes deeper: the workflow, the standards, and how to review.

## The model

Fork, branch, write, pull request. `main` is protected. Only the org owners (Natnael and Barkilign) merge to it. Everyone else works on a fork and opens a pull request. The PR is the review.

## First contribution

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
4. **Write a note.** Open the vault in Obsidian and use `Mod+Shift+A` → **New Concept** (or New Research). A good first contribution: a short atomic concept note in `02 Knowledge/`, e.g. *"What is the difference between a population and a sample?"* Fill in every section, even briefly.
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

## Standards

- **Properties**: use only what you will query. `type`, `status`, `area`, `created`, `updated`, `publish-status`. Never duplicate a fact in folder, tag, and property.
- **Tags**: topical only. `type`/`status`/`area` never become tags.
- **Linking**: link as much as you can. A note that links nothing is a dead end.
- **Diagrams**: most notes should come with a tldraw diagram. See [tldraw](tldraw.md).
- **Atomic**: one note, one job.

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
