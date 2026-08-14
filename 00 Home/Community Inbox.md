---
type: concept
status: active
area: community
created: 2026-08-13
updated: 2026-08-13

cover: https://upload.wikimedia.org/wikipedia/commons/3/39/A_community_townhall_at_Makoko_community.jpg

tags: [inbox]
participants: ["Natnael-Getahun"]
---

![Community Inbox cover](https://upload.wikimedia.org/wikipedia/commons/3/39/A_community_townhall_at_Makoko_community.jpg)

# Community Inbox

Quick thoughts, half-baked ideas, and discussion that isn't part of the formal knowledge pipeline. Process regularly.

## How to track attended items

Each inbox line is a checkbox. When you've dealt with it, tick it (`- [x]`) — it moves to the **Attended** list below and stays out of the **Needs Attention** view. Untick to bring it back. This works for both the community inbox and the founder inbox.

## Needs Attention

```dataview
TASK FROM "00 Home/Community Inbox.md"
WHERE !completed
```

## Quick Captures

- [ ] _New items land here via the **Send to Inbox** command (Ctrl+Shift+A → Send to Inbox)._

## Attended

```dataview
TASK FROM "00 Home/Community Inbox.md"
WHERE completed
```

