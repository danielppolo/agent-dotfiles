#!/bin/zsh

fail() {
  print -u2 "error: $*"
  exit 1
}

export PATH="$HOME/.local/bin:$HOME/Library/Python/3.12/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

ensure_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || fail "this setup currently supports macOS only"
}

ensure_homebrew() {
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    fail "Homebrew is required at /opt/homebrew/bin/brew"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

ensure_gum() {
  if ! command -v gum >/dev/null 2>&1; then
    /opt/homebrew/bin/brew install gum
  fi
}

timestamp() {
  date +%Y%m%d%H%M%S
}

backup_if_unmanaged() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    if [[ -L "$target" ]]; then
      return 0
    fi
    mv "$target" "$target.backup.$(timestamp)"
  fi
}

default_agent_name() {
  case "$1" in
    hermes-product) print "Hermes Product" ;;
    hermes-research) print "Hermes Research" ;;
    *) print "$1" ;;
  esac
}

require_git_email() {
  local email="$1"
  [[ -n "$email" ]] || fail "GIT_EMAIL is required. Pass --git-email to setup or set GIT_EMAIL for install.sh."
  [[ "$email" == *@*.* ]] || fail "GIT_EMAIL must look like an email address."
}
