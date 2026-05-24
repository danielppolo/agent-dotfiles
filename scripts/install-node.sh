#!/bin/zsh
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-${0:A:h:h}}"
source "$DOTFILES_DIR/scripts/lib.sh"

ensure_macos

export NVM_DIR="$HOME/.nvm"

if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  mkdir -p "$NVM_DIR"
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash
fi

source "$NVM_DIR/nvm.sh"
nvm install 22 || nvm use 22
nvm alias default 22
nvm use default
corepack enable
corepack prepare pnpm@latest --activate
pnpm config set package-manager-strict true

cat > "$HOME/.npmrc" <<'EOF'
package-manager-strict=true
engine-strict=false
fund=false
audit=false
EOF
