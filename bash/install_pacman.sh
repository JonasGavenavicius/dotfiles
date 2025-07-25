set -e
source "$(dirname "$0")/utils.sh"

log "Detected Arch Linux. Using pacman."

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm \
  curl wget git unzip base-devel \
  zsh tmux neovim fd fzf ripgrep bat \
  docker docker-compose ruby jq p7zip \
  python-pip go dotnet-sdk rustup stylua eza nodejs yarn

log "Installing yay (AUR helper)"
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -si --noconfirm)
rm -rf /tmp/yay

# Enable docker service if desired
# sudo systemctl enable --now docker

"$(dirname "$0")/install_hyprland.sh"


