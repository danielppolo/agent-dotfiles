#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

ensure_macos
ensure_homebrew

if [[ ! -w /opt/homebrew ]]; then
  missing=0
  for cmd in gum git gh rg jq wget http pnpm python3 pipx codex; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      print -u2 "missing required shared tool: $cmd"
      missing=1
    fi
  done
  if [[ "$missing" -ne 0 ]]; then
    fail "shared Homebrew tools are missing; run brew bundle as an admin user"
  fi
  exit 0
fi

brew bundle --file "$DOTFILES_DIR/Brewfile"
