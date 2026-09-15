#!/usr/bin/env bash

set -e

# folders
mkdir -p ~/.config/hypr
mkdir -p ~/.config/kitty
mkdir -p ~/images/wallpapers

# wallpapers are hardcoded now maybe later i need to rewrite them 
ln -sf ~/nixos-dots/wallpaper.png ~/images/wallpapers/wallpaper.png

# kitty
ln -sf ~/nixos-dots/kitty.conf ~/.config/kitty/kitty.conf

# hypr
ln -sf ~/nixos-dots/hypr/animations.lua ~/.config/hypr/animations.lua
ln -sf ~/nixos-dots/hypr/custom.lua ~/.config/hypr/custom.lua
ln -sf ~/nixos-dots/hypr/decorations.lua ~/.config/hypr/decorations.lua
ln -sf ~/nixos-dots/hypr/hyprland.lua ~/.config/hypr/hyprland.lua
ln -sf ~/nixos-dots/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sf ~/nixos-dots/hypr/keybindings.lua ~/.config/hypr/keybindings.lua
ln -sf ~/nixos-dots/hypr/monitors.lua ~/.config/hypr/monitors.lua
ln -sf ~/nixos-dots/hypr/permissions.lua ~/.config/hypr/permissions.lua
ln -sf ~/nixos-dots/hypr/windows.lua ~/.config/hypr/windows.lua

# tg-ws-proxy secret
secret=$(openssl rand -hex 16)
mkdir -p ~/.config/tg-ws-proxy
echo "$secret" > ~/.config/tg-ws-proxy/secret.txt

# hardware
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" #finding script location aka absolute path

if [[ ! -f "$REPO_DIR/hardware-configuration.nix" ]]; then #uhm i kinda like it lol
    echo "generating hardware-configuration"
    sudo nixos-generate-config --dir "$REPO_DIR"
else
    echo "using existing one"
fi

sudo nixos-rebuild switch --flake "$REPO_DIR#nixos"

