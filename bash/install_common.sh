#!/bin/bash

set -e
source "$(dirname "$0")/utils.sh"

log "Installing oh-my-zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "oh-my-zsh already installed. Skipping."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Clone plugins if missing
clone_plugin() {
  local repo="$1"
  local target="$2"
  if [[ ! -d "$target" ]]; then
    git clone --depth=1 "$repo" "$target"
  else
    log "$target already exists. Skipping."
  fi
}

log "Installing Zsh plugins..."
clone_plugin https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_plugin https://github.com/marlonrichert/zsh-autocomplete "$ZSH_CUSTOM/plugins/zsh-autocomplete"
clone_plugin https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

log "Installing Rust (via rustup)..."
if ! command -v rustup >/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source "$HOME/.cargo/env"

log "Installing rust tools..."
rustup default stable
cargo install cargo-nextest || true
cargo install stylua || true
cargo install eza || true
