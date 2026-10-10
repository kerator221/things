{ config, ... }:

{
    imports = [
        ./monitors.nix
        ./keybindings.nix
        ./windows.nix
        ./decorations.nix
        ./animations.nix
        ./custom.nix
    ];
}