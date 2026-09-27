{ config, pkgs, lib, ... }:

{
    #hyprland configs
    #xdg.configFile."hypr".source = ../../../config/hypr;
    xdg.configFile."hypr/hyprland.lua".source = ../../../config/hypr/hyprland.lua;
    xdg.configFile."hypr/animations.lua".source = ../../../config/hypr/animations.lua;
    xdg.configFile."hypr/custom.lua".source = ../../../config/hypr/custom.lua;
    xdg.configFile."hypr/decorations.lua".source = ../../../config/hypr/decorations.lua;
    xdg.configFile."hypr/keybindings.lua".source = ../../../config/hypr/keybindings.lua;
    xdg.configFile."hypr/monitors.lua".source = ../../../config/hypr/monitors.lua;
    xdg.configFile."hypr/permissions.lua".source = ../../../config/hypr/permissions.lua;
    xdg.configFile."hypr/windows.lua".source = ../../../config/hypr/windows.lua;

    #kitty config
    xdg.configFile."kitty/kitty.conf".source = ../../../config/kitty/kitty.conf;

    #matugen
    xdg.configFile."matugen/config.toml".source = ../../../config/matugen/config.toml;
    xdg.configFile."matugen/templates/colors.css".source = ../../../config/matugen/templates/colors.css;
    xdg.configFile."matugen/templates/gtk-colors.css".source = ../../../config/matugen/templates/gtk-colors.css;
    xdg.configFile."matugen/templates/hyprland-colors.lua".source = ../../../config/matugen/templates/hyprland-colors.lua;
    xdg.configFile."matugen/templates/kitty-colors.conf".source = ../../../config/matugen/templates/kitty-colors.conf;
    xdg.configFile."matugen/templates/qtct-colors.conf".source = ../../../config/matugen/templates/qtct-colors.conf;
    xdg.configFile."matugen/templates/rofi-colors.rasi".source = ../../../config/matugen/templates/rofi-colors.rasi;

    #qt6ct 
    xdg.configFile."qt6ct/qt6ct.conf".source = ../../../config/qt6ct/qt6ct.conf;

    #gtk3/4
    xdg.configFile."gtk-3.0/gtk.css".source = ../../../config/gtk/gtk.css;
    xdg.configFile."gtk-4.0/gtk.css".source = ../../../config/gtk/gtk.css;

    #rofi 
    #xdg.configFile."rofi".source = ../../../config/rofi;
    xdg.configFile."rofi/appfinder.rasi".source = ../../../config/rofi/appfinder.rasi;
    xdg.configFile."rofi/mini.rasi".source = ../../../config/rofi/mini.rasi;
    xdg.configFile."rofi/minimal.rasi".source = ../../../config/rofi/minimal.rasi;
    xdg.configFile."rofi/wallpapers.rasi".source = ../../../config/rofi/wallpapers.rasi;

    #swaync 
    #xdg.configFile."swaync".source = ../../../config/swaync;
    xdg.configFile."swaync/config.json".source = ../../../config/swaync/config.json;
    xdg.configFile."swaync/configSchema.json".source = ../../../config/swaync/configSchema.json;
    xdg.configFile."swaync/style.css".source = ../../../config/swaync/style.css;

    #waybar 
    #xdg.configFile."waybar".source = ../../../config/waybar;
    xdg.configFile."waybar/scripts/wlogout.sh".source = ../../../config/waybar/scripts/wlogout.sh;
    xdg.configFile."waybar/scripts/language-switch.sh".source = ../../../config/waybar/scripts/language-switch.sh;
    xdg.configFile."waybar/config".source = ../../../config/waybar/config;
    xdg.configFile."waybar/modules.json".source = ../../../config/waybar/modules.json;
    xdg.configFile."waybar/style.css".source = ../../../config/waybar/style.css;

    #wlogout 
    xdg.configFile."wlogout/icons".source = ../../../config/wlogout/icons;
    xdg.configFile."wlogout/style.css".source = ../../../config/wlogout/style.css;
    xdg.configFile."wlogout/layout".source = ../../../config/wlogout/layout;

    #wallpapers
    home.file.".local/bin/walset".source = ../../../config/wallpapers/walset;
    home.file.".local/bin/walset-backend".source = ../../../config/wallpapers/walset-backend;

    home.file."images/wallpapers/cars".source = ../../../config/wallpapers/cars;
    home.file."images/wallpapers/characters".source = ../../../config/wallpapers/characters;
    home.file."images/wallpapers/landscapes".source = ../../../config/wallpapers/landscapes;

    #tg-ws-proxy secret setup
    home.activation = {
        generateSecret = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.config/tg-ws-proxy"
        if [[ ! -s "$HOME/.config/tg-ws-proxy/secret.txt" ]]; then
            ${pkgs.openssl}/bin/openssl rand -hex 16 > "$HOME/.config/tg-ws-proxy/secret.txt"
            chmod 600 "$HOME/.config/tg-ws-proxy/secret.txt"
            echo "tg-ws-proxy secret was generated"
        else
            echo "tg-ws-proxy secret already exists"
        fi
        '';
    };
}