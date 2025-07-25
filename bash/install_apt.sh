#!/bin/bash

log "Detected Debian. Using APT."

sudo apt update
sudo apt install -y wget curl git zsh unzip tmux bat docker-compose colima fd-find fzf gh golang ripgrep ruby jq python3-pip python3-venv ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config

# Node.js and Yarn
if ! command -v node >/dev/null; then
    log "Installing Node.js and Yarn..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install -g yarn
fi

log "Ensuring latest Neovim from git..."
if [[ ! -d /opt/neovim ]]; then
  sudo git clone https://github.com/neovim/neovim.git /opt/neovim
  cd /opt/neovim && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo install
else
  cd /opt/neovim && sudo git pull && sudo make CMAKE_BUILD_TYPE=RelWithDebInfo install
fi
