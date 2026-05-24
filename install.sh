#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${0:A:h}"
source "$DOTFILES_DIR/scripts/lib.sh"

export DOTFILES_DIR
export AGENT_NAME="${AGENT_NAME:-$(id -F 2>/dev/null || id -un)}"
require_git_email "${GIT_EMAIL:-}"
export GIT_EMAIL
export LINK_PROFILES="${LINK_PROFILES:-yes}"
export RUN_AUTH="${RUN_AUTH:-no}"

"$DOTFILES_DIR/scripts/install-homebrew-tools.sh"
"$DOTFILES_DIR/scripts/install-zsh.sh"
"$DOTFILES_DIR/scripts/install-node.sh"
"$DOTFILES_DIR/scripts/install-hermes.sh"
"$DOTFILES_DIR/scripts/configure-git.sh"

if [[ "$LINK_PROFILES" == "yes" ]]; then
  "$DOTFILES_DIR/scripts/link-profiles.sh"
fi

"$DOTFILES_DIR/scripts/verify.sh"

if [[ "$RUN_AUTH" == "yes" ]]; then
  "$DOTFILES_DIR/scripts/auth.sh"
fi
