set -e
source "$(dirname "$0")/utils.sh"

log "Installing Hyprland and UI dependencies."

sudo pacman -S ninja gcc wayland-protocols libjpeg-turbo libwebp libjxl pango cairo pkgconf cmake libglvnd wayland hyprutils hyprwayland-scanner hyprlang # Required libraries for Hyprland

sudo pacman -S --noconfirm \
  hyprland \ # Main compositor
  waybar \ # Status bar
  wofi \ # Application launcher
  grim \ # Screenshot tool
  slurp \ # Screen selection tool
  hyprpaper \ # Wallpaper manager
  hyprlock \ # Screen locker
  hyprcursor \ # Cursor theme support
  swaync \ # Notification daemon
  tlp \ # Power management tool
  syspower \ # System power management
  sysstat \ # System performance monitoring tools
  dolphin \ # File manager
  qt6-wayland \ # Qt6 Wayland support
  qt5-wayland \ # Qt5 Wayland support
  xdg-desktop-portal-hyprland \ # Hyprland desktop portal
  gvfs \ # Virtual filesystem support
  network-manager-applet \ # Network management applet
  wlogout \ # Logout menu
  playerctl # Player controller for media keys

sudo yay -S --noconfirm \
  swayosd-git \ # On-screen display for Hyprland
  powerstat \ # Power consumption statistics tool
  google-chrome \ # Web browser
  1password # Power consumption statistics tool

# Enable bluetooth service
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sysstat
sudo systemctl enable --now tlp

# Copy configuration files
cp -r ../hyprland/hypr ~/.config/
cp -r ../hyprland/wayland ~/.config/

