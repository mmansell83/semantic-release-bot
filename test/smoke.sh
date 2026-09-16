#!/bin/sh
# Smoke test for the semantic-release-bot image.
#
# Builds a throwaway git repo with a local bare remote, then runs
# semantic-release in dry-run mode with the conventionalcommits preset.
# This exercises commit analysis and release note generation without
# network access or tokens.
#
# Usage: docker run --rm -v ./test:/test:ro <image> /test/smoke.sh
set -eu

fail() {
  echo "SMOKE TEST FAILED: $*" >&2
  exit 1
}

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

git config --global user.name "Smoke Test"
git config --global user.email "smoke-test@example.com"
git config --global init.defaultBranch main

echo "--- Checking @semantic-release/gitlab loads"
node --input-type=module -e "await import('$(npm root -g)/@semantic-release/gitlab/index.js')" \
  || fail "@semantic-release/gitlab could not be imported"

echo "--- Creating test repository"
git init -q --bare "$WORK/remote.git"
git init -q "$WORK/repo"
cd "$WORK/repo"

cat > .releaserc.json <<'EOF'
{
  "branches": ["main"],
  "plugins": [
    ["@semantic-release/commit-analyzer", { "preset": "conventionalcommits" }],
    ["@semantic-release/release-notes-generator", { "preset": "conventionalcommits" }]
  ]
}
EOF

git add .releaserc.json
git commit -q -m "chore: initial commit"
git tag v1.0.0
git commit -q --allow-empty -m "feat: add widget"
git commit -q --allow-empty -m "fix: handle empty widget"
git remote add origin "file://$WORK/remote.git"
git push -q origin main --tags

echo "--- Running semantic-release --dry-run"
status=0
semantic-release --dry-run --no-ci > "$WORK/output.log" 2>&1 || status=$?
cat "$WORK/output.log"

[ "$status" -eq 0 ] || fail "semantic-release exited with status $status"
grep -q "The next release version is 1.1.0" "$WORK/output.log" \
  || fail "expected next release version 1.1.0"
grep -q "### Features" "$WORK/output.log" \
  || fail "release notes are missing the Features section"
grep -q "### Bug Fixes" "$WORK/output.log" \
  || fail "release notes are missing the Bug Fixes section"

echo "SMOKE TEST PASSED"
