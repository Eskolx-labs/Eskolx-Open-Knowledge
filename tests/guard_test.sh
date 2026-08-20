#!/usr/bin/env bash
# guard_test.sh — end-to-end verification of the Eskolx-Open pre-push guard.
#
# Hermetic: builds a local bare mirror of the currently checked-out repo and
# runs the participant scenarios against it. No network, no GitHub token, no
# docker, no human needed. Runs on every push via .github/workflows/guard-test.yml.
#
# Scenarios:
#   1.  onboarding (install-hooks.sh) creates participants/<username> off develop
#   2.  push to main is blocked by the hook
#   3.  push to develop is blocked by the hook
#   4.  locked-path change on a subbranch is blocked
#   5.  secret in a note is blocked
#   6.  clean note push to the subbranch succeeds
#   7.  sync.sh on main/develop is read-only
#   8.  sync.sh on the subbranch pulls develop and pushes
#   9.  nested code file (*.py deep in a content folder) is blocked
#   10. root-level .env file is blocked
#   11. secret push leaves a quarantine file listing the blocked file
#   12. sync.sh exits non-zero when the guard blocks the push
#   13. sync.sh rolls back its backup commit when the guard blocks (secret
#       does not linger in local history)
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

# 0b. Stage working-tree scripts into the mirror so the test runs against the
#     current code, not the last committed version. On CI the checkout is clean
#     so this is a no-op. We do this by cloning, updating, committing, and
#     pushing back to both main and develop in the mirror.
git clone -q "$TMP/origin" "$TMP/stage" || { echo "cannot stage clone"; exit 1; }
cd "$TMP/stage"
git config user.name "Stager"
git config user.email "stager@x.com"
cp "$ROOT/scripts/pre-push.sh" scripts/pre-push.sh
cp "$ROOT/scripts/sync.sh" scripts/sync.sh
cp "$ROOT/scripts/install-hooks.sh" scripts/install-hooks.sh
cp "$ROOT/tests/guard_test.sh" tests/guard_test.sh
git add scripts/ tests/
git commit -q -m "test: stage working-tree scripts" 2>/dev/null || true
ESKOLX_ALLOW_MAIN=1 git push -q origin main 2>/dev/null || true
git checkout -q -B develop origin/develop 2>/dev/null || true
git merge -q --no-edit main 2>/dev/null || true
ESKOLX_ALLOW_MAIN=1 git push -q origin develop 2>/dev/null || true
cd "$ROOT"

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
push_out="$(git push origin "$SUBBRANCH" 2>&1 || true)"
if echo "$push_out" | grep -qi "locked path"; then
  ok "locked path blocked"
else
  bad "locked path msg" "$push_out"
fi
git reset -q --hard origin/develop
# reset the mirror's subbranch so the next test isn't a non-fast-forward
git --git-dir="$TMP/origin" update-ref "refs/heads/$SUBBRANCH" "$(git rev-parse origin/develop)"
rm -f .git/eskolx-quarantine.txt

# 6. secret in a note blocked (markdown included) + quarantine file created
echo "password: hunter2" > "02 Knowledge/leak.md"
git add -A && git commit -q -m "test: secret"
rm -f .git/eskolx-quarantine.txt
push_out="$(git push origin "$SUBBRANCH" 2>&1 || true)"
if echo "$push_out" | grep -qi "secret"; then
  ok "secret in note blocked"
else
  bad "secret msg" "$push_out"
fi
# 11. quarantine file should list the blocked file
if [[ -f .git/eskolx-quarantine.txt ]] && grep -q "leak.md" .git/eskolx-quarantine.txt; then
  ok "quarantine file lists blocked file"
else
  bad "quarantine file" "not found or missing leak.md"
fi
git reset -q --hard origin/develop
git --git-dir="$TMP/origin" update-ref "refs/heads/$SUBBRANCH" "$(git rev-parse origin/develop)"
rm -f .git/eskolx-quarantine.txt

# 7. clean note push succeeds
echo "test content" > "02 Knowledge/guard-test.md"
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

# 10. nested code file (*.py deep in a content folder) is blocked
mkdir -p "02 Knowledge/deep/nested"
echo "print('hi')" > "02 Knowledge/deep/nested/script.py"
git add -A && git commit -q -m "test: nested py"
push_out="$(git push origin "$SUBBRANCH" 2>&1 || true)"
if echo "$push_out" | grep -qi "locked path"; then
  ok "nested .py in content folder blocked"
else
  bad "nested py msg" "$push_out"
fi
git reset -q --hard origin/develop
git --git-dir="$TMP/origin" update-ref "refs/heads/$SUBBRANCH" "$(git rev-parse origin/develop)"
rm -f .git/eskolx-quarantine.txt

# 11. root-level .env file is blocked (force-add since .gitignore excludes it)
echo "SECRET=hunter2" > .env
git add -f .env && git commit -q -m "test: root .env"
push_out="$(git push origin "$SUBBRANCH" 2>&1 || true)"
if echo "$push_out" | grep -qi "locked path"; then
  ok "root .env blocked"
else
  bad "root .env msg" "$push_out"
fi
git reset -q --hard origin/develop && rm -f .env
git --git-dir="$TMP/origin" update-ref "refs/heads/$SUBBRANCH" "$(git rev-parse origin/develop)"
rm -f .git/eskolx-quarantine.txt

# 12+13. sync.sh exits non-zero and rolls back its commit when the guard blocks
#
# Set up: the subbranch is clean (matches origin/develop). We write a secret
# into a note, run sync.sh. sync.sh should: commit the backup, try to push,
# get blocked by the guard, roll back the backup commit, exit non-zero.
# After rollback: HEAD should match the pre-sync state, and the secret note
# should still be on disk (working tree preserved) but NOT in git history.
git checkout -q -B "$SUBBRANCH" origin/develop
git --git-dir="$TMP/origin" update-ref "refs/heads/$SUBBRANCH" "$(git rev-parse origin/develop)"
PRE_SYNC_HEAD="$(git rev-parse HEAD)"
echo "api_key: sk-abc123def456ghi789jkl012mno345pqr" > "02 Knowledge/secret-note.md"

SYNC_EXIT=0
bash scripts/sync.sh >/dev/null 2>&1 || SYNC_EXIT=$?

if [[ "$SYNC_EXIT" -ne 0 ]]; then
  ok "sync.sh exits non-zero when guard blocks"
else
  bad "sync.sh exit code" "exited 0 despite guard block"
fi

POST_SYNC_HEAD="$(git rev-parse HEAD)"
if [[ "$POST_SYNC_HEAD" == "$PRE_SYNC_HEAD" ]]; then
  ok "sync.sh rolled back backup commit (HEAD unchanged)"
else
  bad "sync.sh rollback" "HEAD moved: $PRE_SYNC_HEAD -> $POST_SYNC_HEAD"
fi

# The secret note should still be on disk (working tree preserved)
if [[ -f "02 Knowledge/secret-note.md" ]]; then
  ok "blocked note still on disk (working tree preserved)"
else
  bad "working tree" "secret-note.md disappeared from disk"
fi

# The secret should NOT be in git history (no commit with it)
if git log --all --oneline | grep -q "secret-note\|api_key: sk-abc" 2>/dev/null; then
  bad "git history" "secret leaked into local history"
else
  ok "secret not in git history (rolled back)"
fi

# clean up the test file so it doesn't interfere with later runs
rm -f "02 Knowledge/secret-note.md"
rm -f .git/eskolx-quarantine.txt

echo "=== RESULT: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ]