# Load powerlevel10k instant prompt if available
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash, you might have to update your $PATH.
# Uncomment and modify if necessary
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Set path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Use powerlevel10k as the Zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load plugins
plugins=(git zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting)

# Initialize Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Initialize zoxide if available
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Load syntax highlighting from manual install path
if [[ -f "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Set up fzf key bindings and fuzzy completion
if command -v fzf > /dev/null; then
  source <(fzf --zsh)
fi

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- TheFuck -----

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
