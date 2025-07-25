set -e
source "$(dirname "$0")/utils.sh"

log "Installing Hyprland and UI dependencies."

sudo pacman -S --noconfirm \
  hyprland waybar wofi swaybg swayidle swaylock mako thunar \
  polkit-kde-agent pipewire wireplumber xdg-desktop-portal-hyprland \
  qt5-wayland qt6-wayland cinnamon-sound-server pavucontrol brightnessctl \
  bluez bluez-utils blueman network-manager-applet thunar-archive-plugin file-roller \
  noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# Enable bluetooth service
sudo systemctl enable --now bluetooth

