#!/usr/bin/env bash
# sync.sh — portable pull/commit/push for this vault. Works on any machine
# with git + `gh` authenticated (uses HTTPS + gh credential helper, so it is
# safe in background jobs / cron / systemd timers — no SSH passphrase needed).
#
# Branch policy (Eskolx-Open):
#   - NEVER pushes to main or develop. Both are protected; only merge-holders
#     touch them.
#   - On main or a detached HEAD: pulls main (read-only) and stops.
#   - On a participants/<username> subbranch: pulls develop (to stay current
#     with everyone), commits, pushes the subbranch.
#   - On any other branch: pulls that branch's upstream, commits, pushes to it.
#
# Usage:
#   scripts/sync.sh            # pull, commit if changed, push
#   scripts/sync.sh --once     # same (used by timers)
#   scripts/sync.sh -h         # this help
set -euo pipefail

cd "$(dirname "$0")/.."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --once) shift ;;
    -h|--help) sed -n '1,44p' "$0"; exit 0 ;;
    *) echo "sync.sh: unknown option '$1'" >&2; exit 2 ;;
  esac
done

GITC=(git -c "url.https://github.com/.insteadOf=git@github.com:"
         -c "credential.helper=!gh auth git-credential")

branch="$(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"

if [[ "$branch" == "main" ]]; then
  echo "sync.sh: on main - pulling read-only (participants never push main)" >&2
  "${GITC[@]}" pull --ff-only origin main 2>/dev/null \
    || "${GITC[@]}" pull --no-rebase --no-edit origin main 2>/dev/null \
    || echo "warn: pull failed" >&2
  exit 0
fi

if [[ "$branch" == "detached" ]]; then
  echo "sync.sh: detached HEAD - no-op (check out your subbranch to sync)" >&2
  exit 0
fi

if [[ "$branch" == "develop" ]]; then
  echo "sync.sh: on develop - pulling read-only (participants push their own subbranches)" >&2
  "${GITC[@]}" pull --ff-only origin develop 2>/dev/null \
    || "${GITC[@]}" pull --no-rebase --no-edit origin develop 2>/dev/null \
    || echo "warn: pull failed" >&2
  exit 0
fi

# 1. pull remote changes: stay current with develop, then your own branch
if ! "${GITC[@]}" pull --ff-only origin develop 2>/dev/null; then
  "${GITC[@]}" pull --no-rebase --no-edit origin develop 2>/dev/null \
    || echo "warn: pull from develop failed" >&2
fi
if [[ "$branch" == participants/* ]]; then
  git fetch -q origin "$branch" 2>/dev/null || true
fi

# 2/3. stage everything (incl. new files), commit only if something changed
git add -A
if ! git diff --cached --quiet; then
  "${GITC[@]}" commit -q -m "vault backup: $(date +%Y-%m-%d)" \
    || echo "warn: commit failed" >&2
fi

# 4. push the subbranch (no-op if nothing to push)
if git rev-parse --verify HEAD >/dev/null 2>&1 \
   && [[ -n "$(git log --oneline "@{u}"..HEAD 2>/dev/null)" ]]; then
  "${GITC[@]}" push -q origin "$branch" \
    && echo "ok: pushed $branch" || echo "warn: push failed" >&2
fi
