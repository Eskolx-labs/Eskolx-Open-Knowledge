---
type: concept
status: active
area: community
created: 2026-08-13
updated: 2026-08-13
participants: ["Natnael-Getahun"]
participants: ["Natnael-Getahun"]
---

# Contributor Guide

The full guide for contributors to Eskolx-Open.

## Required Reading First

- [[Start Here]] — the non-negotiables (properties, tags, links, templates, note placement, atomic notes)
- [[How To Contribute]]

## Note Standards

### Concept notes (`02 Knowledge/`)

Definition → Intuition → Why It Matters → How It Works → Example → Common Mistakes → Implementation → Related Concepts → References

### Research notes (`07 Research/`)

Question → Why It Matters → Current Understanding → Mathematical Background → Experiment → Implementation → Validation → Findings → Open Questions → Related Concepts → References

### Project notes (`01 Projects/`)

Purpose → Outcome → Current Status → Milestones → Current Work → Blockers → Open Questions → Knowledge → Decisions → Contributors → GitHub → Next Actions

### Decision records (EDR) (`06 Publishing/`)

Context → Problem → Options Considered → Decision → Why → Consequences → Revisit Conditions → Related

## Properties

Use only properties you will actually query:

```yaml
type: concept        # project | research | concept | decision | meeting | person | resource | tutorial | idea
status: draft        # per-type controlled values
area: statistics     # statistics | numerical-methods | computing | ...
owner: natnaelg
created: 2026-08-13
updated: 2026-08-13
publish-status: draft   # draft | review | approved | published | archived
```

Never duplicate the same fact across folder + tag + property. Properties are canonical.

## Tags

Tags are only for topical/domain discovery that cuts across folders and projects — never for anything already captured by a property. Starter set (expand only when a real gap shows up):

`#distributions #monte-carlo #numerical-methods #agentic-ai #tooling #onboarding #core-only`

`type`, `status`, and `area` stay properties only; they never become tags too.

## Controlled Values

- **Project status**: idea, planned, active, blocked, review, completed, archived
- **Research status**: question, active, needs-review, validated, published, archived
- **Publishing status**: draft, review, approved, published, archived
- **Priority**: low, normal, high, critical

## Git

Branch-per-edit + PR, never direct to `main`. Commit with meaningful messages:

```text
research: investigate t-distribution tails
docs: explain inverse transform sampling
project: update distribution rebuild status
```

## Reviewing Work

The PR is the review step. When reviewing:

1. Does it stand on its own for someone outside the room?
2. Correct, referenced, self-contained, no private info, no secrets?
3. Properties and links follow the standards above?
4. Is it atomic (one note, one job)?
