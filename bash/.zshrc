# This file is managed by your dotfiles repository.
# You can add your Zsh configuration here.

# Source private configuration
if [ -f "${ZDOTDIR:-$HOME}/.zsh_private_config" ]; then
  source "${ZDOTDIR:-$HOME}/.zsh_private_config"
fi

# Source corporate configuration if it exists
if [ -f "${ZDOTDIR:-$HOME}/.zsh_corporate_config" ]; then
  source "${ZDOTDIR:-$HOME}/.zsh_corporate_config"
fi
