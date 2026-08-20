#!/usr/bin/env bash
# pre-push guard for Eskolx-Open participants.
#
# Blocks a push when it would:
#   1. touch `main` or `develop` (only merge-holders may; participants push
#      to their own subbranch participants/<username>)
#   2. modify a locked path (the executable surface: .obsidian/, templates,
#      scripts, executable files, cache.json) on any branch
#   3. contain obvious secrets (value-shaped, in any changed file)
#
# Installed by scripts/install-hooks.sh into .git/hooks/pre-push.
# Merge-holders can bypass the branch lock with: ESKOLX_ALLOW_MAIN=1 git push
set -euo pipefail

LOCKED_PATH_GLOB=(
  '.obsidian/**'
  '90 Templates/**'
  'scripts/**'
  '**/*.py'
  '**/*.sh'
  '**/*.js'
  '**/cache.json'
  '**/.env*'
  '*.key'
  '*.pem'
)

# Value-shaped secrets only. Plain prose ("never store passwords") does not
# match; a real `password: hunter2` or a raw `ghp_...` token does.
SECRET_PATTERNS=(
  'password[[:space:]]*[:=][[:space:]]*[^[:space:]]'
  'passwd[[:space:]]*[:=][[:space:]]*[^[:space:]]'
  'api[_-]?key[[:space:]]*[:=][[:space:]]*[^[:space:]]'
  'secret[[:space:]]*[:=][[:space:]]*[^[:space:]]'
  'token[[:space:]]*[:=][[:space:]]*[^[:space:]]'
  'BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY'
  'ghp_[A-Za-z0-9]{20,}'
  'sk-[A-Za-z0-9]{20,}'
  'AKIA[0-9A-Z]{16}'
  'xox[baprs]-[A-Za-z0-9-]{10,}'
)

echo "Eskolx pre-push guard: checking"

blocked=0

# stdin: <local ref> <local sha> <remote ref> <remote sha> per pushed ref
while read -r local_ref local_sha remote_ref remote_sha; do
  case "$remote_ref" in
    refs/heads/main|refs/heads/develop)
      if [[ "${ESKOLX_ALLOW_MAIN:-0}" != "1" ]]; then
        echo "BLOCKED: you cannot push to ${remote_ref#refs/heads/}." >&2
        echo "Participants push to their own subbranch: participants/<your-username>" >&2
        echo "Only merge-holders touch develop and main." >&2
        blocked=1
        continue
      fi
      ;;
  esac

  if [[ "$remote_sha" =~ ^0+$ ]]; then
    base="$(git rev-list --max-parents=0 "$local_sha" 2>/dev/null || echo "${local_sha}^")"
  else
    base="$remote_sha"
  fi

  changed="$(git diff --name-only --diff-filter=ACDMR "$base".."$local_sha" 2>/dev/null || true)"

  if [[ -n "$changed" ]]; then
    # 2) locked paths (skipped for merge-holder pushes to main)
    if [[ "$remote_ref" != "refs/heads/main" || "${ESKOLX_ALLOW_MAIN:-0}" != "1" ]]; then
      while IFS= read -r f; do
        for glob in "${LOCKED_PATH_GLOB[@]}"; do
          if [[ "$f" == $glob ]]; then
            echo "BLOCKED: '$f' is a locked path." >&2
            echo "The executable surface (.obsidian/, templates, scripts) is changed only by merge-holders via main." >&2
            blocked=1
          fi
        done
      done <<< "$changed"
    fi

    # 3) secrets: scan ADDED lines only (avoids flagging prose and plugin code)
    added="$(git diff "$base".."$local_sha" 2>/dev/null || true)"
    if [[ -n "$added" ]]; then
      for pat in "${SECRET_PATTERNS[@]}"; do
        hit="$(grep -E '^\+' <<< "$added" | grep -vE '^\+\+\+' | grep -E -i "$pat" || true)"
        if [[ -n "$hit" ]]; then
          echo "BLOCKED: possible secret detected in pushed content:" >&2
          echo "$hit" | head -3 >&2
          echo "Rotate any leaked secret immediately and remove it. This push was refused." >&2
          blocked=1
          break
        fi
      done
    fi
  fi
done

if [[ "$blocked" == "1" ]]; then
  echo "push aborted by the Eskolx guard" >&2
  exit 1
fi

echo "guard passed"
exit 0
