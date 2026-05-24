# Agent Dotfiles

Repeatable macOS terminal bootstrap for isolated Hermes agent users.

## One-command setup

Run as the target user:

```zsh
/bin/zsh -lc 'git config --global --add safe.directory /Users/Shared/hermes-dotfiles 2>/dev/null || true; git clone https://github.com/danielppolo/agent-dotfiles.git /Users/Shared/hermes-dotfiles 2>/dev/null || git -C /Users/Shared/hermes-dotfiles pull --ff-only; /Users/Shared/hermes-dotfiles/setup'
```

The setup wizard installs terminal tooling, links zsh profiles, configures git identity, installs Node through nvm, and installs `hermes-agent` through pipx.

## Safety

This repo intentionally does not include or copy credentials, SSH private keys, GitHub auth state, Codex auth/session files, Hermes `.env` files, browser sessions, or personal shell history.
