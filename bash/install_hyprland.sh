set -e
source "$(dirname "$0")/utils.sh"

log "Installing Hyprland and UI dependencies."

sudo pacman -S ninja gcc wayland-protocols libjpeg-turbo libwebp libjxl pango cairo pkgconf cmake libglvnd wayland hyprutils hyprwayland-scanner hyprlang libva libvdpau vdpauinfo

sudo pacman -S --noconfirm hyprland waybar wofi grim slurp hyprpaper  hyprlock  hyprcursor  swaync  tlp  sysstat  dolphin  qt6-wayland  qt5-wayland  xdg-desktop-portal-hyprland  gvfs  network-manager-applet  playerctl pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse gst-libav gst-plugin-pipewire gst-plugins-good

yay -S --noconfirm swayosd-git wlogout powerstat google-chrome 1password 

# Enable bluetooth service
sudo systemctl enable --now bluetooth
sudo systemctl enable --now sysstat
sudo systemctl enable --now tlp
sudo systemctl enable --now pipewire pipewire-pulse wireplumber

# Copy configuration files
cp -r hyprland/hypr ~/.config/
cp -r hyprland/wayland ~/.config/

