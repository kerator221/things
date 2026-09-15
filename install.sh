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
#sudo nixos-generate-config --dir "$HOME/nixos-dots" idk lol i think ure already have a hardware config if u starting it from working system
sudo nixos-rebuild switch --flake path:.#nixos

