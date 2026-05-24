#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

ensure_macos

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$PLUGIN_DIR"

clone_or_update() {
  local repo="$1"
  local dest="$2"
  if [[ -d "$dest/.git" ]]; then
    git -C "$dest" pull --ff-only
  elif [[ ! -e "$dest" ]]; then
    git clone "$repo" "$dest"
  fi
}

clone_or_update "https://github.com/zsh-users/zsh-autosuggestions.git" "$PLUGIN_DIR/zsh-autosuggestions"
clone_or_update "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$PLUGIN_DIR/zsh-syntax-highlighting"
clone_or_update "https://github.com/zsh-users/zsh-history-substring-search.git" "$PLUGIN_DIR/history-substring-search"

