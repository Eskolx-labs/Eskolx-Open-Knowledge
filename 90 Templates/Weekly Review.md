---
type: concept
status: active
area: operations
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Calendar_icon_%28rubin-Calendar-icon%29.jpg/500px-Calendar_icon_%28rubin-Calendar-icon%29.jpg 
date: <% tp.date.now("YYYY-MM-DD") %>
author: 
tags: [review]
participants: []
publish-status: draft
---

<%* await tp.file.move("00 Home/" + tp.file.title + ".md") %>

# Weekly Review — <% tp.date.now("YYYY-MM-DD") %>

> One rhythm: what moved forward, what's stuck, what do we decide next.

![Weekly Review cover](https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Calendar_icon_%28rubin-Calendar-icon%29.jpg/500px-Calendar_icon_%28rubin-Calendar-icon%29.jpg)

## This Week's Changes

```base
filters:
  and:
    - file.mtime > now() - 7 days
views:
  - type: table
    name: Changed This Week
    order:
      - file.mtime
      - file.folder
      - type
```

## Decisions Made This Week

```base
filters:
  and:
    - type == "decision"
    - date >= now() - 7 days
views:
  - type: table
    name: Decisions This Week
    order:
      - date
      - status
      - area
```

## My Tasks

```tasks
not done
sort by urgency
```

## Blocked

```base
filters:
  and:
    - type == "project"
    - status == "blocked"
views:
  - type: table
    name: Blocked
    order:
      - file.name
      - priority
```

## Carry-Over (not finished)

- 

## What I Completed

- 

## Blockers / Waiting On

- 

## Next Week Focus

- 

## Decisions To Make Next Week

-