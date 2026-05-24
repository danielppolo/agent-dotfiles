#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

AGENT_NAME="${AGENT_NAME:-$(default_agent_name "$(id -un)")}"
GIT_EMAIL="${GIT_EMAIL:-od.polo@gmail.com}"

backup_if_unmanaged "$HOME/.gitignore"
ln -sfn "$DOTFILES_DIR/git/gitignore" "$HOME/.gitignore"

backup_if_unmanaged "$HOME/.gitconfig-agent"
ln -sfn "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig-agent"

git config --global --replace-all include.path "$HOME/.gitconfig-agent"
git config --global user.name "$AGENT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global --unset credential.helper >/dev/null 2>&1 || true
