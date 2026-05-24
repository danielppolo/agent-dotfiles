#!/bin/zsh
set -euo pipefail

if command -v gh >/dev/null 2>&1; then
  gh auth status >/dev/null 2>&1 || gh auth login
fi

if command -v codex >/dev/null 2>&1; then
  codex login || true
fi

if command -v hermes >/dev/null 2>&1; then
  hermes setup || hermes auth || true
fi

