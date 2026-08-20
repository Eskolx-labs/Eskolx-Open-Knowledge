---
cssclasses:
  - eskolx-open
  - dashboard

cover: https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png

tags: [dashboard]
participants: ["Natnael-Getahun"]
---

![Home cover|78](https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png)

# Eskolx Labs Open

> **Build. Understand. Share.** A public learning library for statistics, statistical computing, and data analysis automation.

> [!insight] It's always **Eskolx Labs**, never "Eskol" or "Eskolx" alone. [[It's Always Eskolx Labs]]

## Start Here

- [[Keybindings]]
- New to Obsidian? Start with the [[Eskolx Guide]].

## My Tasks

```tasks
not done
tag includes #assignee/natnael
sort by urgency
```

## Tasks

```tasks
not done
sort by urgency
```

## Vault Health

> [!tip] **Learning library.** Source-grounded notes behind everything Eskolx builds. See [[Eskolx Guide]].

## Needs Attention

```base
filters:
  and:
    - note["publish-status"] == "review"
views:
  - type: table
    name: Awaiting Review
    order:
      - updated
      - file.folder
      - file.name
```

## What Eskolx Is

A small lab rebuilding statistical and computing tools from first principles. Participants record notes from books and papers before implementing anything in our libraries. Code lives in the Eskolx GitHub repos; this vault holds the sourced notes that drive the libraries.

## Featured

```base
filters:
  and:
    - featured == true
views:
  - type: cards
    name: Featured
    order:
      - updated
```

## Recent Changes

The 20 most recently edited notes. Scroll the table to see further back. It lists every change, not just since your last visit.

```base
filters:
  and:
    - file.mtime > now() - "1 year"
views:
  - type: table
    name: Recent Changes
    limit: 20
    order:
      - file.mtime
      - file.folder
      - type
      - author
```

## Research Shelf

```base
filters:
  and:
    - type == "research"
views:
  - type: cards
    name: Research Notes
    order:
      - updated
```

## Published Shelf

```base
filters:
  and:
    - note["publish-status"] == "published"
views:
  - type: cards
    name: Published Notes
    order:
      - updated
```

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


