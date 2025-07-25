
#!/bin/bash

set -e
source "$(dirname "$0")/utils.sh"

log "Detected macOS. Using Homebrew."

if ! command -v brew >/dev/null; then
  log "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

PACKAGES=(
  wget node yarn bat docker docker-compose colima rbenv fd fzf tmux gh unzip 
  go eza ripgrep ruby zoxide stylua ffmpeg jq
)

CASKS=(
  1password-cli ghostty
)

log "Installing Homebrew packages..."
for pkg in "${PACKAGES[@]}"; do
  if ! brew list --formula "$pkg" &>/dev/null; then
    brew install "$pkg"
  fi
done

log "Installing Homebrew casks..."
for cask in "${CASKS[@]}"; do
  if ! brew list --cask "$cask" &>/dev/null; then
    brew install --cask "$cask"
  fi
done

log "Installing latest Neovim..."
brew install --HEAD neovim

