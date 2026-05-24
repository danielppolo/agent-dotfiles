# Agent Dotfiles

Repeatable macOS terminal bootstrap for isolated Hermes agent users.

## One-command setup

Run as the target user:

```zsh
/bin/zsh -lc 'mkdir -p /Users/Shared/code; git config --global --add safe.directory /Users/Shared/code/agent-dotfiles 2>/dev/null || true; git clone https://github.com/danielppolo/agent-dotfiles.git /Users/Shared/code/agent-dotfiles 2>/dev/null || git -C /Users/Shared/code/agent-dotfiles pull --ff-only; /Users/Shared/code/agent-dotfiles/setup --git-email you@example.com'
```

The setup wizard installs terminal tooling, links zsh profiles, configures git identity, installs Node through nvm, makes pnpm the default package manager, and installs `hermes-agent` through pipx. If `--git-email` is omitted, the wizard asks for it interactively.

## Safety

This repo intentionally does not include or copy credentials, SSH private keys, GitHub auth state, Codex auth/session files, Hermes `.env` files, browser sessions, or personal shell history.
