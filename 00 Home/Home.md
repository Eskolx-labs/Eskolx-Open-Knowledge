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
- [[Keybindings]]

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

## Tasks

```tasks
not done
sort by urgency
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

- [[Contributor Guide]] · [[First Contribution]] · [[Code of Conduct]] · [[The Eskolx Lab Rules]]
- Community Inbox: [[Community Inbox]]
