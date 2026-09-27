#!/usr/bin/env bash

set -euo pipefail 
trap 'echo "[!] Error on line $LINENO" >&2' ERR

# finding script location
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" 
if [[ ! -w "$REPO_DIR" ]]; then
    echo "[!] $REPO_DIR Access denied" >&2
    exit 1
fi

# hardware 
if [[ ! -f "$REPO_DIR/hosts/nixos/hardware-configuration.nix" ]]; then 
    echo "generating hardware-configuration"
    sudo nixos-generate-config --dir "$REPO_DIR/hosts/nixos"
    sudo chown "$USER" "$REPO_DIR/hosts/nixos/hardware-configuration.nix"
else
    echo "using existing hardware-configuration"
fi

# sets theme to avoid problems after reboot
walset-backend ~/images/wallpapers/characters/36.jpg

sudo nixos-rebuild switch --flake "path:$REPO_DIR#nixos"