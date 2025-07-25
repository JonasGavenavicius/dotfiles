#!/bin/bash

set -e
source "$(dirname "$0")/utils.sh"

log "Copying Zsh dotfiles..."

ZSHRC_SRC="$DIR/../bash/.zshrc"
P10K_SRC="$DIR/../.p10k.zsh"
PRIVATE_SRC="$DIR/../bash/.zsh_private_config"
CORPORATE_SRC="$DIR/../bash/.zsh_corporate_config"

cp "$ZSHRC_SRC" "$HOME/.zshrc"
cp "$P10K_SRC" "$HOME/.p10k.zsh"
[[ -f "$PRIVATE_SRC" ]] && cp "$PRIVATE_SRC" "$HOME/.zsh_private_config"
[[ -f "$CORPORATE_SRC" ]] && cp "$CORPORATE_SRC" "$HOME/.zsh_corporate_config"

ZSHRC_FILE="$HOME/.zshrc"

log "Copying user scripts to ~/.local/bin..."
mkdir -p "$HOME/.local/bin"
cp "$DIR/../scripts"/* "$HOME/.local/bin"
chmod +x "$HOME/.local/bin"/*

log "Setting up Neovim config..."
mkdir -p "$HOME/.config/nvim"
cp "$DIR/../nvim/init.lua" "$HOME/.config/nvim/init.lua"
cp -r "$DIR/../nvim/lua" "$HOME/.config/nvim/"

log "Setting up Tmux config..."
cp "$DIR/../bash/.tmux.conf" "$HOME/.tmux.conf"

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Trigger Tmux plugin installation (ignore if not in tmux)
if command -v tmux >/dev/null && [ -n "$TMUX" ]; then
  ~/.tmux/plugins/tpm/bin/install_plugins || true
fi
