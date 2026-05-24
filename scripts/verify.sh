#!/bin/zsh
set -euo pipefail

missing=0

check_command() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    print "✓ $cmd -> $(command -v "$cmd")"
  else
    print "✗ missing $cmd"
    missing=1
  fi
}

for cmd in gum zsh git gh codex node npm pnpm rg jq pipx hermes; do
  check_command "$cmd"
done

print "HERMES_SHARED=${HERMES_SHARED:-}"
print "HERMES_CODE=${HERMES_CODE:-}"
print "git user.name=$(git config --global --get user.name || true)"
print "git user.email=$(git config --global --get user.email || true)"

if command -v node >/dev/null 2>&1; then
  node --version | grep -E '^v22\.' >/dev/null || {
    print "✗ Node default is not v22"
    missing=1
  }
fi

[[ "${HERMES_CODE:-}" == "/Users/Shared/code" ]] || {
  print "✗ HERMES_CODE is not /Users/Shared/code"
  missing=1
}

if command -v pnpm >/dev/null 2>&1; then
  pnpm --version >/dev/null
fi

if [[ -f "$HOME/.npmrc" ]]; then
  grep -q '^fund=false$' "$HOME/.npmrc" || {
    print "✗ ~/.npmrc was not written by agent-dotfiles"
    missing=1
  }
else
  print "✗ missing ~/.npmrc"
  missing=1
fi

if [[ -f "$HOME/.zshrc" ]]; then
  grep -q "alias npm='pnpm'" "$HOME/.zshrc" || {
    print "✗ ~/.zshrc does not default npm to pnpm"
    missing=1
  }
fi

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

print "Verification passed."
