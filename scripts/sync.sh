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
# Rollback: if the pre-push guard blocks the push (secret or locked path),
# sync.sh undoes its own backup commit so the blocked content does not linger
# in local history. The working tree is preserved (the user's note is still on
# disk); only the auto-commit is removed. The user can fix the note and the
# next sync.sh run will commit and push the fixed version.
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
    -h|--help) sed -n '1,52p' "$0"; exit 0 ;;
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
committed=0
if ! git diff --cached --quiet; then
  "${GITC[@]}" commit -q -m "vault backup: $(date +%Y-%m-%d)" \
    && committed=1 || echo "warn: commit failed" >&2
fi

# 4. push the subbranch (no-op if nothing to push)
if git rev-parse --verify HEAD >/dev/null 2>&1 \
   && [[ -n "$(git log --oneline "@{u}"..HEAD 2>/dev/null)" ]]; then
  if "${GITC[@]}" push -q origin "$branch" 2>&1; then
    echo "ok: pushed $branch"
  else
    # Push failed. If the pre-push guard blocked it, roll back our backup
    # commit so the blocked content (secret, locked path) does not sit in
    # local history waiting for the next sync to retry.
    quarantine="$(git rev-parse --git-dir)/eskolx-quarantine.txt"
    if [[ -f "$quarantine" ]]; then
      if [[ "$committed" == "1" ]]; then
        git reset -q --soft HEAD~1
        # unstage the quarantined files so they don't get recommitted
        # immediately on the next run; the user needs to fix them first
        while IFS= read -r f; do
          [[ -n "$f" ]] && git reset -q HEAD -- "$f" 2>/dev/null || true
        done < "$quarantine"
        echo "error: push blocked by the guard. Backup commit rolled back." >&2
        echo "Fix these files and sync again:" >&2
        cat "$quarantine" >&2
      else
        echo "error: push blocked by the guard." >&2
        echo "Blocked files:" >&2
        cat "$quarantine" >&2
      fi
      rm -f "$quarantine"
      exit 1
    fi
    echo "error: push failed (not a guard block). Check gh auth and network." >&2
    exit 1
  fi
fi

# clean up any stale quarantine file from a previous run
quarantine="$(git rev-parse --git-dir)/eskolx-quarantine.txt"
rm -f "$quarantine"

exit 0