#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

ensure_macos

PYTHON_BIN="$(command -v python3)"
"$PYTHON_BIN" -m pip install --user --upgrade pipx
"$PYTHON_BIN" -m pipx ensurepath
"$PYTHON_BIN" -m pipx install hermes-agent || "$PYTHON_BIN" -m pipx upgrade hermes-agent

