---
type: concept
status: active
area: community
created: 2026-08-17
updated: 2026-08-17
author: Natnael
tags: [dashboard, community]
cover: https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Award_icon.png/500px-Award_icon.png
---

![Review Queue cover](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Award_icon.png/500px-Award_icon.png)

# Review Queue

> Open pull requests on Eskolx-Open and what's waiting on your review. The PR *is* the review step — nothing merges to `main` without one once branch protection is on.

## PRs Awaiting My Review

```dataviewjs
const me = 'natnael';
const res = await fetch(`https://api.github.com/search/issues?q=repo:Natnael-Getahun/Eskolx-Open-Knowledge+type:pr+state:open+review-requested:${me}`);
if (res.ok) {
  const data = await res.json();
  const prs = data.items || [];
  if (prs.length === 0) {
    dv.paragraph('No PRs waiting on your review.');
  } else {
    dv.table(['PR', 'Author', 'Title'],
      prs.map(p => [dv.el('a', '#' + p.number, { href: p.html_url, style: 'color: var(--eskolx-grape)' }),
                    p.user.login,
                    p.title]));
  }
} else {
  dv.paragraph('Could not fetch review queue (offline?). Open https://github.com/Natnael-Getahun/Eskolx-Open-Knowledge/pulls');
}
```

## All Open PRs

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

## How To Review

1. **Open the PR** (link above) and read the note it adds — the diff is the note file.
2. **Check the quality gate**: is it correct, understandable, referenced, self-contained, free of private info and secrets, and learnable by another student? See [[Start Here]] and [[Contributor Guide]].
3. **Check the mechanics**: properties follow the schema, `publish-status` is `draft` or `review`, tags are topical only, no duplicate content, no secrets.
4. **Approve or request changes** with a specific note — one concrete comment beats three vague ones.
5. **Merge** when green. The author is done when the maintainer says so.

> First time? The perfect first contribution is a tiny, real fix — see [[First Contribution]].

## Related

- [[Contributor Guide]] · [[First Contribution]] · [[Decision Register]] · [[Eskolx Guide]]