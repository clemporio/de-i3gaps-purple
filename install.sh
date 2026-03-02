#!/usr/bin/env bash

# ┌──────────────────────────────────────────────────┐
# │  Purple Minimal - i3-gaps Desktop Environment    │
# │  Install Script for LMDE 7 (Debian Trixie)      │
# │  MacBook Pro 2015                                │
# └──────────────────────────────────────────────────┘

set -euo pipefail

# ── Colors for output ───────────────────────────────
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No color

PREFIX="${PURPLE}[Purple Minimal]${NC}"

info()    { echo -e "${PREFIX} ${GREEN}$1${NC}"; }
warn()    { echo -e "${PREFIX} ${YELLOW}$1${NC}"; }
error()   { echo -e "${PREFIX} ${RED}$1${NC}"; }

# ── Script directory ────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Pre-flight checks ──────────────────────────────
if [[ $EUID -eq 0 ]]; then
    error "Do not run this script as root. It will use sudo when needed."
    exit 1
fi

echo ""
echo -e "${PURPLE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║    Purple Minimal - i3-gaps Desktop Environment ║${NC}"
echo -e "${PURPLE}║    Installer for LMDE 7                         ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════════════╝${NC}"
echo ""

# ── Confirm installation ────────────────────────────
read -rp "This will install i3-gaps Purple Minimal DE and overwrite existing configs. Continue? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    info "Installation cancelled."
    exit 0
fi

# ── Step 1: Update package lists ────────────────────
info "Updating package lists..."
sudo apt update

# ── Step 2: Install packages ────────────────────────
# NOTE: In Debian Trixie / LMDE 7, i3-gaps features are merged into
# mainline i3 (i3-wm >= 4.22). The "i3" meta-package includes gaps support.
info "Installing packages..."

PACKAGES=(
    # Window manager
    i3
    # Status bar
    polybar
    # Compositor
    picom
    # Application launcher
    rofi
    # Terminal emulator
    alacritty
    # Notification daemon
    dunst
    # Wallpaper setter
    feh
    # System info
    neofetch
    # Media controls
    playerctl
    # Audio control
    pulseaudio-utils
    pavucontrol
    # Brightness control (MacBook)
    brightnessctl
    # Screenshot tool
    scrot
    # Screen locker
    i3lock
    # Fonts
    fonts-roboto
    fonts-font-awesome
    # Network manager applet
    network-manager-gnome
    # PolicyKit agent
    policykit-1-gnome
    # X resources
    x11-xserver-utils
    # Papirus icon theme (for rofi/dunst)
    papirus-icon-theme
)

sudo apt install -y "${PACKAGES[@]}"

# ── Step 3: Install RobotoMono Nerd Font ────────────
info "Checking for RobotoMono font..."
FONT_DIR="$HOME/.local/share/fonts"
if ! fc-list | grep -qi "RobotoMono"; then
    info "Installing RobotoMono Nerd Font..."
    mkdir -p "$FONT_DIR"
    ROBOTO_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/RobotoMono.tar.xz"
    TMP_DIR=$(mktemp -d)
    if curl -fsSL "$ROBOTO_URL" -o "$TMP_DIR/RobotoMono.tar.xz"; then
        tar -xf "$TMP_DIR/RobotoMono.tar.xz" -C "$FONT_DIR"
        fc-cache -fv > /dev/null 2>&1
        info "RobotoMono Nerd Font installed."
    else
        warn "Could not download RobotoMono Nerd Font. Install it manually."
        warn "URL: $ROBOTO_URL"
    fi
    rm -rf "$TMP_DIR"
else
    info "RobotoMono font already installed."
fi

# ── Step 4: Install Source Code Pro font ────────────
info "Checking for Source Code Pro font..."
if ! fc-list | grep -qi "Source Code Pro"; then
    info "Installing Source Code Pro font..."
    mkdir -p "$FONT_DIR"
    sudo apt install -y fonts-sourcecodepro 2>/dev/null || {
        warn "fonts-sourcecodepro not in repos. Trying manual install..."
        SCP_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.tar.xz"
        TMP_DIR=$(mktemp -d)
        if curl -fsSL "$SCP_URL" -o "$TMP_DIR/SourceCodePro.tar.xz"; then
            tar -xf "$TMP_DIR/SourceCodePro.tar.xz" -C "$FONT_DIR"
            fc-cache -fv > /dev/null 2>&1
            info "Source Code Pro installed."
        else
            warn "Could not download Source Code Pro. Install it manually."
        fi
        rm -rf "$TMP_DIR"
    }
else
    info "Source Code Pro already installed."
fi

# ── Step 5: Back up existing configs ────────────────
info "Backing up existing configurations..."
BACKUP_DIR="$HOME/.config/purple-minimal-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

for dir in i3 polybar picom rofi alacritty dunst neofetch; do
    if [[ -d "$HOME/.config/$dir" ]]; then
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        info "  Backed up ~/.config/$dir"
    fi
done

if [[ -f "$HOME/.Xresources" ]]; then
    cp "$HOME/.Xresources" "$BACKUP_DIR/"
    info "  Backed up ~/.Xresources"
fi

info "Backups saved to: $BACKUP_DIR"

# ── Step 6: Deploy configuration files ──────────────
info "Deploying configuration files..."

# Create config directories
mkdir -p "$HOME/.config/i3"
mkdir -p "$HOME/.config/polybar"
mkdir -p "$HOME/.config/picom"
mkdir -p "$HOME/.config/rofi"
mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/.config/neofetch"
mkdir -p "$HOME/Pictures"

# Copy configs
cp "$SCRIPT_DIR/config/i3/config"             "$HOME/.config/i3/config"
cp "$SCRIPT_DIR/config/polybar/config.ini"     "$HOME/.config/polybar/config.ini"
cp "$SCRIPT_DIR/config/polybar/launch.sh"      "$HOME/.config/polybar/launch.sh"
cp "$SCRIPT_DIR/config/picom/picom.conf"       "$HOME/.config/picom/picom.conf"
cp "$SCRIPT_DIR/config/rofi/config.rasi"       "$HOME/.config/rofi/config.rasi"
cp "$SCRIPT_DIR/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
cp "$SCRIPT_DIR/config/dunst/dunstrc"          "$HOME/.config/dunst/dunstrc"
cp "$SCRIPT_DIR/config/neofetch/config.conf"   "$HOME/.config/neofetch/config.conf"
cp "$SCRIPT_DIR/.Xresources"                   "$HOME/.Xresources"

# Set permissions
chmod +x "$HOME/.config/polybar/launch.sh"
chmod 644 "$HOME/.config/i3/config"
chmod 644 "$HOME/.config/polybar/config.ini"
chmod 644 "$HOME/.config/picom/picom.conf"
chmod 644 "$HOME/.config/rofi/config.rasi"
chmod 644 "$HOME/.config/alacritty/alacritty.toml"
chmod 644 "$HOME/.config/dunst/dunstrc"
chmod 644 "$HOME/.config/neofetch/config.conf"
chmod 644 "$HOME/.Xresources"

info "Configuration files deployed."

# ── Step 7: Wallpaper placeholder ───────────────────
if [[ ! -f "$HOME/Pictures/wallpaper.jpg" ]]; then
    warn "No wallpaper found at ~/Pictures/wallpaper.jpg"
    warn "Place a wallpaper image there, or update the feh command in ~/.config/i3/config"
    warn "Recommended: Dark purple/violet abstract or landscape wallpaper"
fi

# ── Step 8: Load Xresources ────────────────────────
info "Loading Xresources..."
if command -v xrdb &> /dev/null; then
    xrdb -merge "$HOME/.Xresources" 2>/dev/null || true
fi

# ── Done ─────────────────────────────────────────────
echo ""
echo -e "${PURPLE}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║    Installation Complete!                        ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════════════╝${NC}"
echo ""
info "To start using i3-gaps Purple Minimal:"
echo ""
echo "  1. Log out of your current session"
echo "  2. At the login screen, select 'i3' as your session"
echo "  3. Log in"
echo ""
echo "  Or from a TTY:"
echo "    startx /usr/bin/i3"
echo ""
info "Place a wallpaper at: ~/Pictures/wallpaper.jpg"
info "Config backup at: $BACKUP_DIR"
echo ""
info "Key bindings:"
echo "  Super + Return     = Terminal (Alacritty)"
echo "  Super + d          = App launcher (Rofi)"
echo "  Super + Shift + q  = Close window"
echo "  Super + r          = Resize mode"
echo "  Super + Shift + e  = Exit i3"
echo ""
info "Enjoy your Purple Minimal desktop!"
