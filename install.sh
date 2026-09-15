#!/usr/bin/env bash

set -euo pipefail 
trap 'echo "[!] Error on line $LINENO" >&2' ERR

# finding script location
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" 
if [[ ! -w "$REPO_DIR" ]]; then
    echo "[!] $REPO_DIR Access denied" >&2
    exit 1
fi

# folders
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/images/wallpapers"
mkdir -p "$HOME/.config/tg-ws-proxy"

# wallpapers
ln -sfn "$REPO_DIR/wallpaper.png" "$HOME/images/wallpapers/wallpaper.png"

# kitty
ln -sfn "$REPO_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# hypr
ln -sfn "$REPO_DIR/hypr/animations.lua" "$HOME/.config/hypr/animations.lua"
ln -sfn "$REPO_DIR/hypr/custom.lua" "$HOME/.config/hypr/custom.lua"
ln -sfn "$REPO_DIR/hypr/decorations.lua" "$HOME/.config/hypr/decorations.lua"
ln -sfn "$REPO_DIR/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
ln -sfn "$REPO_DIR/hypr/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
ln -sfn "$REPO_DIR/hypr/keybindings.lua" "$HOME/.config/hypr/keybindings.lua"
ln -sfn "$REPO_DIR/hypr/monitors.lua" "$HOME/.config/hypr/monitors.lua"
ln -sfn "$REPO_DIR/hypr/permissions.lua" "$HOME/.config/hypr/permissions.lua"
ln -sfn "$REPO_DIR/hypr/windows.lua" "$HOME/.config/hypr/windows.lua"

# tg-ws-proxy secret
if [[ ! -s "$HOME/.config/tg-ws-proxy/secret.txt" ]]; then
    openssl rand -hex 16 > "$HOME/.config/tg-ws-proxy/secret.txt"
    chmod 600 "$HOME/.config/tg-ws-proxy/secret.txt"
    echo "tg-ws-proxy secret was generated"
else
    echo "tg-ws-proxy secret already exists"
fi

# hardware 
if [[ ! -f "$REPO_DIR/hardware-configuration.nix" ]]; then 
    echo "generating hardware-configuration"
    sudo nixos-generate-config --dir "$REPO_DIR"
    sudo chown "$USER" "$REPO_DIR/hardware-configuration.nix"
else
    echo "using existing hardware-configuration"
fi

echo "[*] Checking flake"
nix flake check "path:$REPO_DIR" --no-build

echo "[*] Rebuilding system"
sudo nixos-rebuild switch --flake "path:$REPO_DIR#nixos"
echo "[*] All done, reboot your pc"