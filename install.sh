#!/usr/bin/env bash

set -e 

#folders
sudo mkdir -p /etc/nixos
mkdir -p ~/.config/home-manager
mkdir -p ~/.config/kitty
mkdir -p ~/.config/hypr

# main files
sudo ln -sf ~/nixos-dots/configuration.nix /etc/nixos/configuration.nix
ln -sf ~/nixos-dots/home.nix ~/.config/home-manager/home.nix

# kitty
ln -sf ~/nixos-dots/kitty.conf ~/.config/kitty/kitty.conf

#hypr
ln -sf ~/nixos-dots/hypr/animations.lua ~/.config/hypr/animations.lua
ln -sf ~/nixos-dots/hypr/custom.lua ~/.config/hypr/custom.lua
ln -sf ~/nixos-dots/hypr/decorations.lua ~/.config/hypr/decorations.lua
ln -sf ~/nixos-dots/hypr/hyprland.lua ~/.config/hypr/hyprland.lua
ln -sf ~/nixos-dots/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
ln -sf ~/nixos-dots/hypr/keybindings.lua ~/.config/hypr/keybindings.lua
ln -sf ~/nixos-dots/hypr/monitors.lua ~/.config/hypr/monitors.lua
ln -sf ~/nixos-dots/hypr/permissions.lua ~/.config/hypr/permissions.lua
ln -sf ~/nixos-dots/hypr/windows.lua ~/.config/hypr/windows.lua

#apply things
sudo nixos-rebuild switch
home-manager switch
