#!/bin/bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DIR/utils.sh"

OS=$(detect_os)

case "$OS" in
  macos)
    source "$DIR/install_brew.sh"
    ;;
  debian)
    source "$DIR/install_apt.sh"
    ;;
  arch)
    source "$DIR/install_pacman.sh"
    ;;
  *)
    echo "Unsupported OS: $OSTYPE"
    exit 1
    ;;
esac

source "$DIR/install_common.sh"
source "$DIR/install_dotfiles.sh"

log "✅ Setup complete. Reload your shell or run 'source ~/.zshrc'"
