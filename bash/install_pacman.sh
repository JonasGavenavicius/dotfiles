set -e
source "$(dirname "$0")/utils.sh"

log "Detected Arch Linux. Using pacman."

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
  curl wget git unzip base-devel \
  zsh tmux neovim fd fzf ripgrep bat \
  docker docker-compose ruby jq p7zip \
  python-pip go rustup stylua eza nodejs yarn \
  ghostty networkmanager zoxide

if ! command -v yay &> /dev/null; then
  log "Installing yay (AUR helper)"
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

# Enable docker service if desired
sudo systemctl enable --now docker
sudo systemctl enable --now NetworkManager

bash "$(dirname "$0")/install_hyprland.sh"



