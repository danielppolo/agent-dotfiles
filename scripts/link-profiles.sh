#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

backup_if_unmanaged "$HOME/.zprofile"
backup_if_unmanaged "$HOME/.zshrc"
backup_if_unmanaged "$HOME/.aliases"

ln -sfn "$DOTFILES_DIR/zsh/zprofile" "$HOME/.zprofile"
ln -sfn "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/zsh/aliases" "$HOME/.aliases"

