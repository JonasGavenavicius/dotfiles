#!/bin/bash

# Check OS and set package manager
if [[ "$OSTYPE" == "darwin"* ]]; then
    PACKAGE_MANAGER="brew"
    echo "macOS detected. Using Homebrew for package management."

    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

elif [[ "$OSTYPE" == "linux-gnu"* ]] || grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null; then
    PACKAGE_MANAGER="nix"
    echo "Linux/WSL detected. Using Nix for package management."

    # Install Nix if not installed
    if ! command -v nix &> /dev/null; then
        echo "Nix not found. Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install) --daemon
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi

else
    echo "Unsupported OS. Exiting."
    exit 1
fi

# Declare packages to install
FORMULAE=(neovim bat docker docker-compose rbenv fd fzf tmux gh unzip dotnet-sdk rustup go)
CASKS=(1password-cli font-maple font-monaspace font-hack-nerd-font)

# Install packages
echo "Installing packages..."
if [[ "$PACKAGE_MANAGER" == "brew" ]]; then
    for formula in "${FORMULAE[@]}"; do
        if ! brew list "$formula" &> /dev/null; then
            brew install "$formula"
        fi
    done

    echo "Installing casks..."
    for cask in "${CASKS[@]}"; do
        if ! brew list --cask "$cask" &> /dev/null; then
            brew install --cask "$cask"
        fi
    done

elif [[ "$PACKAGE_MANAGER" == "nix" ]]; then
    for formula in "${FORMULAE[@]}"; do
        nix-env -iA nixpkgs."$formula"
    done
fi

# Install powerlevel10k manually
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Install zsh-autocomplete manually
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete" ]]; then
    echo "Installing zsh-autocomplete..."
    git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete"
fi

# Install zsh-syntax-highlighting manually
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Install powerlevel10k manually
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/powerlevel10k" ]]; then
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

echo "Installing rust tools..."
rustup default stable

# Moving Neovim configuration files
echo "Setting up Neovim configuration..."
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/
cp -r lua ~/.config/nvim/

# Set up Tmux Plugin Manager (TPM)
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Copy Tmux configuration file
echo "Setting up Tmux configuration..."
cp .tmux.conf ~/

# Trigger Tmux to source the configuration and install plugins
tmux source-file ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

# Moving Zsh configuration file, if present
if [[ -f .zshrc ]]; then
    echo "Setting up Zsh configuration..."
    cp .zshrc ~/
fi

echo "Setup complete. Neovim, Tmux, and dependencies are configured!"
