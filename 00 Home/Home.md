---
cssclasses:
  - eskolx-open
  - dashboard

cover: https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png

tags: [dashboard]
participants: ["Natnael-Getahun"]
---

![Home cover|78](https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg/500px-Target_with_archery_arrow_at_bullseye_Pinhead_icon.svg.png)

# Eskolx Labs — Open

> **Build. Understand. Share.** A public learning library for statistics, statistical computing, and data analysis automation.

> [!insight] It's always **Eskolx Labs** — never Eskol or Eskolx. [[It's Always Eskolx Labs]]

## Start Here

- [[Start Here]]
- [[What Is Eskolx]]
- [[How To Learn With Eskolx]]
- [[How To Contribute]]
- [[Keybindings]]

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

A small lab rebuilding statistical/computing tools from first principles and publishing what it learns. Code lives in the Eskolx GitHub repos; this vault is the knowledge. See [[What Is Eskolx]].

## Learning

[[Learning Paths]]

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

The 20 most recently edited notes. Scroll the table to see further back — it lists every change, not just since your last visit.

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

## Research Papers Shelf

```base
filters:
  and:
    - type == "research"
views:
  - type: cards
    name: Research Papers
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
    name: Published Writing
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

```base
filters:
  and:
    - type == "concept"
    - note["publish-status"] == "published"
views:
  - type: table
    name: Recently Published Knowledge
    order:
      - updated
      - area
      - file.name
```

## Recently Published

```base
filters:
  and:
    - note["publish-status"] == "published"
views:
  - type: table
    name: Recently Published
    order:
      - updated
      - file.folder
      - type
```

## Writing Pipeline

```base
filters:
  and:
    - note["publish-status"] != "published"
    - note["publish-status"] != "archived"
views:
  - type: table
    name: In Progress (draft / review / approved)
    order:
      - note["publish-status"]
      - updated
      - file.folder
```

## Open PRs Awaiting Review

```dataviewjs
const repo = 'Natnael-Getahun/Eskolx-Open-Knowledge';
const res = await fetch(`https://api.github.com/repos/${repo}/pulls?state=open&per_page=20`);
if (res.ok) {
  const prs = await res.json();
  if (prs.length === 0) {
    dv.paragraph('No open PRs.');
  } else {
    dv.table(['PR', 'Author', 'Title'],
      prs.map(p => [dv.el('a', '#' + p.number, { href: p.html_url, style: 'color: var(--eskolx-grape)' }),
                    p.user.login,
                    p.title]));
  }
} else {
  dv.paragraph('Could not fetch PRs (offline?). Open the repo directly: https://github.com/Natnael-Getahun/Eskolx-Open-Knowledge/pulls');
}
```

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
```

## Contribute

- [[Contributor Guide]] · [[First Contribution]] · [[Code of Conduct]] · [[The Eskolx Labs Rules]]
- Community Inbox: [[Community Inbox]]
