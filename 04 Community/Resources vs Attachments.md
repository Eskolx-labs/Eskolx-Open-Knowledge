---
type: concept
status: active
area: community
created: 2026-08-14
updated: 2026-08-14
publish-status: published
participants: ["Natnael-Getahun"]
---

# Resources vs Attachments

Two different things that must not be confused.

## Resources

Notes **about** external things — curated links, reading lists, papers, tools, references. The content lives elsewhere; the note points to it.

- Lives in `05 Resources/`
- `type: resource`
- If removing the internet would break the note, it belongs here

## Attachments

Files that physically live **in** the vault — images, PDFs, exported diagrams, animations. Things Eskolx itself needs to keep.

- Lives in `90 Attachments/`
- If the file is sitting in the repo, it's an attachment

## Rule Of Thumb

> If removing the internet would break the note, it belongs in Resources; if the file is sitting in the repo, it's an Attachment.

## Embedding Philosophy

- If something *can* be embedded, it should be embedded — no loose `.png` files accumulating in the repo without being shown anywhere.
- YouTube links and PDF research papers should be embedded where Obsidian supports it, not pasted as bare URLs.
- Every attachment goes in `90 Attachments/` **and** is linked to from wherever it's used, in addition to being embedded — discoverable both ways.
