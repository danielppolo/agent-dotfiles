#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

ensure_macos

if command -v pipx >/dev/null 2>&1; then
  pipx ensurepath
  pipx install hermes-agent || pipx upgrade hermes-agent
else
  PYTHON_BIN="$(command -v python3)"
  "$PYTHON_BIN" -m pip install --user --break-system-packages --upgrade pipx
  "$PYTHON_BIN" -m pipx ensurepath
  "$PYTHON_BIN" -m pipx install hermes-agent || "$PYTHON_BIN" -m pipx upgrade hermes-agent
fi
