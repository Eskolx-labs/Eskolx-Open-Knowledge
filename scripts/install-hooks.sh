#!/usr/bin/env bash
# install-hooks.sh — one-time onboarding for an Eskolx-Open participant clone.
#
#  1. Installs the pre-push guard into .git/hooks/.
#  2. Creates the participant's personal subbranch off `develop`
#     (develop/<git-user-name>) and checks it out. Auto-sync then pushes
#     to that subbranch and pulls from it. Participants never push to
#     `develop` or `main` directly.
#
# Usage:  scripts/install-hooks.sh
set -euo pipefail

cd "$(dirname "$0")/.."

cp scripts/pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push
echo "installed .git/hooks/pre-push"

git fetch origin develop:refs/remotes/origin/develop 2>/dev/null || true
if ! git show-ref --verify refs/remotes/origin/develop >/dev/null 2>&1; then
  echo "warn: origin/develop not found - create it first (merge-holders)" >&2
  exit 1
fi

who="$(git config user.name || true)"
[[ -z "$who" ]] && who="$(git config --global user.name || true)"
[[ -z "$who" ]] && who="participant"
branch="develop/${who// /-}"

current="$(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
if [[ "$current" == "$branch" ]]; then
  git pull -q origin "$branch" 2>/dev/null || git pull -q origin develop 2>/dev/null || true
  echo "on $branch (your subbranch)"
else
  if git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
    git checkout -q -B "$branch" "origin/$branch"
    echo "on $branch (your subbranch)"
  else
    git checkout -q -B "$branch" origin/develop
    echo "created $branch off develop"
  fi
fi

echo "onboarding complete"
