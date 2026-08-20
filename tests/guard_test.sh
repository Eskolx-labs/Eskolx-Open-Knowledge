#!/usr/bin/env bash
# guard_test.sh — end-to-end verification of the Eskolx-Open pre-push guard.
#
# Hermetic: builds a local bare mirror of the currently checked-out repo and
# runs the participant scenarios against it. No network, no GitHub token, no
# docker, no human needed. Runs on every push via .github/workflows/guard-test.yml.
#
# Scenarios:
#   1. onboarding (install-hooks.sh) creates participants/<username> off develop
#   2. push to main is blocked by the hook
#   3. push to develop is blocked by the hook
#   4. locked-path change on a subbranch is blocked
#   5. secret in a note is blocked
#   6. clean note push to the subbranch succeeds
#   7. sync.sh on main/develop is read-only
#   8. sync.sh on the subbranch pulls develop and pushes
#
# Usage: bash tests/guard_test.sh   (from the vault repo root)
set -u

cd "$(dirname "$0")/.."
ROOT="$(pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

PASS=0; FAIL=0
ok()  { PASS=$((PASS+1)); echo "PASS  $1"; }
bad() { FAIL=$((FAIL+1)); echo "FAIL  $1  $2"; }

# 0. bare mirror of the REMOTE state, not stale local branches.
#    The local `main` can lag origin/main (merges happen on GitHub via PRs),
#    so populate main and develop from the local repo's fetched origin refs.
git clone -q --bare "$ROOT" "$TMP/origin" || { echo "cannot create mirror"; exit 1; }
git --git-dir="$TMP/origin" config receive.denyCurrentBranch ignore
git --git-dir="$TMP/origin" symbolic-ref HEAD refs/heads/main
git -C "$ROOT" fetch -q origin 'refs/heads/*:refs/remotes/origin/*' 2>/dev/null || true
for b in main develop; do
  sha="$(git -C "$ROOT" rev-parse --verify -q "refs/remotes/origin/$b" 2>/dev/null || true)"
  if [[ -n "$sha" ]]; then
    git --git-dir="$TMP/origin" update-ref "refs/heads/$b" "$sha"
  fi
done

# 1. fresh clone as an outsider
git clone -q "$TMP/origin" "$TMP/vault" || { echo "cannot clone"; exit 1; }
cd "$TMP/vault"
git config user.name "Guard Tester"
git config user.email "guard-tester@users.noreply.github.com"

B="$(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
[ "$B" = "main" ] && ok "fresh clone lands on main (expected)" || bad "clone branch" "$B"

# 2. onboarding creates the participant subbranch
bash scripts/install-hooks.sh >/dev/null 2>&1
B2="$(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
case "$B2" in
  participants/*) ok "onboarding creates subbranch ($B2)" ;;
  *) bad "onboarding branch" "$B2" ;;
esac

# 3. push to main blocked
git checkout -q -B main origin/main
echo x > main-commit-test.txt
git add -A && git commit -q -m "test: commit on main"
if git push -q origin main 2>/dev/null; then
  bad "push main" "succeeded - SECURITY HOLE"
else
  msg="$(git push origin main 2>&1 | head -3)"
  echo "$msg" | grep -qi "BLOCKED\|cannot push" && ok "push main blocked by hook" || bad "push main msg" "$msg"
fi
git reset -q --hard origin/main && rm -f main-commit-test.txt

# 4. push to develop blocked
git checkout -q -B develop origin/develop
echo x > develop-commit-test.txt
git add -A && git commit -q -m "test: commit on develop"
if git push -q origin develop 2>/dev/null; then
  bad "push develop" "succeeded - SECURITY HOLE"
else
  msg="$(git push origin develop 2>&1 | head -3)"
  echo "$msg" | grep -qi "BLOCKED\|cannot push" && ok "push develop blocked by hook" || bad "push develop msg" "$msg"
fi
git reset -q --hard origin/develop && rm -f develop-commit-test.txt

SUBBRANCH="participants/Guard-Tester"
git checkout -q -B "$SUBBRANCH" origin/develop

# 5. locked path blocked
echo "/* x */" >> .obsidian/snippets/eskolx.css
git add -A && git commit -q -m "test: locked path"
if git push -q origin "$SUBBRANCH" 2>/dev/null; then
  bad "locked path push" "succeeded - SECURITY HOLE"
else
  msg="$(git push origin "$SUBBRANCH" 2>&1 | head -3)"
  echo "$msg" | grep -qi "locked path" && ok "locked path blocked" || bad "locked path msg" "$msg"
fi
git reset -q --hard origin/develop

# 6. secret in a note blocked (markdown included)
echo "password: hunter2" > 02\ Knowledge/leak.md
git add -A && git commit -q -m "test: secret"
if git push -q origin "$SUBBRANCH" 2>/dev/null; then
  bad "secret push" "succeeded - SECURITY HOLE"
else
  msg="$(git push origin "$SUBBRANCH" 2>&1 | head -3)"
  echo "$msg" | grep -qi "secret" && ok "secret in note blocked" || bad "secret msg" "$msg"
fi
git reset -q --hard origin/develop

# 7. clean note push succeeds
echo "test content" > 02\ Knowledge/guard-test.md
git add -A && git commit -q -m "test: clean note"
if git push -q origin "$SUBBRANCH" 2>/dev/null; then
  ok "clean note push succeeds on subbranch"
else
  bad "clean push" "$(git push origin "$SUBBRANCH" 2>&1 | head -3)"
fi

# 8. sync.sh on main/develop is read-only
git checkout -q -B main origin/main
out="$(bash scripts/sync.sh 2>&1 | head -3)"
echo "$out" | grep -qi "read-only\|never pushes" && ok "sync.sh main read-only" || bad "sync.sh main" "$out"

git checkout -q -B develop origin/develop
out="$(bash scripts/sync.sh 2>&1 | head -3)"
echo "$out" | grep -qi "read-only\|never pushes" && ok "sync.sh develop read-only" || bad "sync.sh develop" "$out"

# 9. sync.sh on the subbranch syncs
git checkout -q "$SUBBRANCH"
out="$(bash scripts/sync.sh 2>&1)"
echo "$out" | grep -qiE "pushed|up to date|no-op" && ok "sync.sh subbranch syncs" || bad "sync.sh subbranch" "$out"

echo "=== RESULT: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ]
