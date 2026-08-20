#!/usr/bin/env bash
# install-hooks.sh — one-time onboarding for an Eskolx-Open participant clone.
#
#  1. Installs the pre-push guard into .git/hooks/.
#  2. Lands the clone on `develop` (the live shared branch) so auto-sync
#     pushes to develop, never to main. On main, obsidian-git would try to
#     push main and get rejected; this avoids the trap entirely.
#
# Usage:  scripts/install-hooks.sh
set -euo pipefail

cd "$(dirname "$0")/.."

cp scripts/pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push
echo "installed .git/hooks/pre-push"

current="$(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
if [[ "$current" != "develop" ]]; then
  git fetch origin develop:refs/remotes/origin/develop 2>/dev/null || true
  if git show-ref --verify refs/remotes/origin/develop >/dev/null 2>&1; then
    git checkout -q -B develop origin/develop
    echo "on develop (live shared branch)"
  else
    echo "warn: origin/develop not found - create it first (merge-holders)" >&2
  fi
fi

echo "onboarding complete"
