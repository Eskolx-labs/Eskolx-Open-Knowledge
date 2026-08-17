---
type: concept
status: active
area: community
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [dashboard, decisions]
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Scale_of_justice_2_new.jpeg/500px-Scale_of_justice_2_new.jpeg
---

![Decision Register cover](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Scale_of_justice_2_new.jpeg/500px-Scale_of_justice_2_new.jpeg)

# Decision Register

> Every decision (EDR) at a glance: what's open, what's been decided, and what's due for a second look.

## Open Decisions (need a decision)

```base
filters:
  and:
    - type == "decision"
    - status == "proposed"
views:
  - type: table
    name: Open Decisions
    order:
      - date
      - area
      - file.name
```

## Revisit Due

```base
filters:
  and:
    - type == "decision"
    - revisit != null
    - revisit <= now()
views:
  - type: table
    name: Revisit Due
    order:
      - revisit
      - status
      - file.name
```

## All Decisions

```base
filters:
  and:
    - type == "decision"
views:
  - type: table
    name: All Decisions
    order:
      - date
      - status
      - area
```

## How Decisions Work

1. **Create** an EDR with QuickAdd → **New Decision** (`Ctrl+Shift+A`). It lands in `06 Publishing/` with the `EDR — YYYY-MM-DD — Title` name and `status: proposed`.
2. **Write it up** — Context → Problem → Options Considered → Decision → Why → Consequences → Revisit Conditions. This is the decision log of the lab: if it's not in an EDR, it didn't happen.
3. **Close the loop** — change `status` when the call is made (approved / declined / archived). A decision that stays `proposed` forever is a decision that never happened.
4. **Set a `revisit:` date** (YYYY-MM-DD in frontmatter) when the call should be re-evaluated — it shows up under **Revisit Due** when the date passes. Use it for reversible or time-sensitive calls.
5. **Link it** — from the EDR's `## Related` section, and to any note that the decision affects.

## Related

- [[Contributor Guide]] · [[The Eskolx Labs Rules]] · [[Eskolx Guide]]