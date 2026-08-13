---
cssclasses:
  - eskolx-open
  - dashboard
---

# Eskolx Lab — Open

> **Build. Understand. Share.** A public learning library for statistics, statistical computing, and data analysis automation.

## Start Here

- [[Start Here]]
- [[What Is Eskolx]]
- [[How To Learn With Eskolx]]
- [[How To Contribute]]

## Learning

[[Learning Paths]]

## Projects

```base
filters:
  and:
    - type == "project"
    - status != "archived"
views:
  - type: table
    name: Projects
    order:
      - status
      - file.name
      - area
      - updated
```

## Recent Knowledge

```base
filters:
  and:
    - type == "concept"
    - publish-status == "published"
views:
  - type: table
    name: Recently Published Knowledge
    order:
      - updated
      - area
      - file.name
    direction: DESC
```

## Recently Published

```base
filters:
  and:
    - publish-status == "published"
views:
  - type: table
    name: Recently Published
    order:
      - updated
      - file.folder
      - type
    direction: DESC
```

## Open PRs Awaiting Review

PRs on the public GitHub repository are the review step of the knowledge pipeline. Check them at the repo's **Pull Requests** tab.

## Lounge Highlights

```base
filters:
  and:
    - file.folder == "08 Lounge"
views:
  - type: list
    name: Lounge
    order:
      - file.mtime
    direction: DESC
```

## Contribute

- [[Contributor Guide]] · [[First Contribution]] · [[Code of Conduct]]
- Community Inbox: [[Community Inbox]]
