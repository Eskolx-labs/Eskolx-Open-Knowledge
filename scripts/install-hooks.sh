#!/usr/bin/env bash
# install-hooks.sh — installs the Eskolx pre-push guard into .git/hooks/.
# Run once on every machine that clones the vault.
#
# Usage:  scripts/install-hooks.sh
set -euo pipefail

cd "$(dirname "$0")/.."
cp scripts/pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push
echo "installed .git/hooks/pre-push"
