#!/usr/bin/env bash
# pre-push guard for Eskolx-Open participants.
#
# Blocks a push when it would:
#   1. touch `main` (only merge-holders may, via GitHub's compare-and-merge)
#   2. modify a locked path (the executable surface: .obsidian/, templates,
#      scripts, executable files, cache.json) on any branch
#   3. contain obvious secrets
#
# Installed by scripts/install-hooks.sh into .git/hooks/pre-push.
# Merge-holders can override the branch lock with: ESKOLX_ALLOW_MAIN=1 git push
set -euo pipefail

LOCKED_PATH_GLOB=(
  '.obsidian/**'
  '90 Templates/**'
  'scripts/**'
  '**/*.sh'
  '**/*.py'
  '**/*.js'
  '**/*.tldr'
  '**/cache.json'
  '**/.env*'
  '*.key'
  '*.pem'
)

SECRET_PATTERN='(password|passwd|api[_-]?key|secret|BEGIN (RSA|EC|OPENSSH|DSA) PRIVATE KEY|ghp_[A-Za-z0-9]{36}|sk-[A-Za-z0-9]{20,})'

echo "Eskolx pre-push guard: checking"

blocked=0

# stdin: <local ref> <local sha> <remote ref> <remote sha> per pushed ref
while read -r local_ref local_sha remote_ref remote_sha; do
  case "$remote_ref" in
    refs/heads/main)
      if [[ "${ESKOLX_ALLOW_MAIN:-0}" != "1" ]]; then
        echo "BLOCKED: you cannot push to main. Push to develop instead." >&2
        echo "Only merge-holders merge to main (GitHub native compare-and-merge)." >&2
        blocked=1
        continue
      fi
      ;;
  esac

  if [[ "$remote_sha" == "0000000000000000000000000000000000000000" ]]; then
    range="${local_sha}^"
  else
    range="${remote_sha}..${local_sha}"
  fi

  changed="$(git diff --name-only --diff-filter=ACDMR "$range" 2>/dev/null || true)"

  locked_hit=""
  while IFS= read -r f; do
    for glob in "${LOCKED_PATH_GLOB[@]}"; do
      if [[ "$f" == $glob ]]; then
        locked_hit="$f"
        break
      fi
    done
    [[ -n "$locked_hit" ]] && break
  done <<< "$changed"

  if [[ -n "$locked_hit" ]]; then
    echo "BLOCKED: '$locked_hit' is a locked path." >&2
    echo "The executable surface (.obsidian/, templates, scripts) is changed only by merge-holders via main." >&2
    blocked=1
  fi

  if git grep -nE -i "$SECRET_PATTERN" "$local_sha" -- . ':!tests' ':!*.md' 2>/dev/null | grep -qv ':' ; then
    echo "BLOCKED: possible secret detected in pushed content." >&2
    echo "Rotate any leaked secret immediately and remove it. This push was refused." >&2
    blocked=1
  fi
done

if [[ "$blocked" == "1" ]]; then
  echo "push aborted by the Eskolx guard" >&2
  exit 1
fi

echo "guard passed"
exit 0
