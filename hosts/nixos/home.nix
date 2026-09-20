{ config, pkgs, username, lib, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  #hyprland config
  xdg.configFile."hypr/hyprland.lua".source = ./config/hypr/hyprland.lua;
  xdg.configFile."hypr/animations.lua".source = ./config/hypr/animations.lua;
  xdg.configFile."hypr/custom.lua".source = ./config/hypr/custom.lua;
  xdg.configFile."hypr/decorations.lua".source = ./config/hypr/decorations.lua;
  xdg.configFile."hypr/keybindings.lua".source = ./config/hypr/keybindings.lua;
  xdg.configFile."hypr/monitors.lua".source = ./config/hypr/monitors.lua;
  xdg.configFile."hypr/permissions.lua".source = ./config/hypr/permissions.lua;
  xdg.configFile."hypr/windows.lua".source = ./config/hypr/windows.lua;

  #waybar 
  xdg.configFile."waybar/config".source = ./config/waybar/config;
  xdg.configFile."waybar/config.sh".source = ./config/waybar/config.sh;
  xdg.configFile."waybar/modules.json".source = ./config/waybar/modules.json;
  xdg.configFile."waybar/style.css".source = ./config/waybar/style.css;

  #kitty
  xdg.configFile."kitty/kitty.conf".source = ./config/kitty.conf;

  #wallpapers
  home.file."images/wallpapers/wallpaper.png".source = ./config/wallpaper.png;

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

  home.packages = with pkgs; [
    #archive things
    unzip
    zip
    p7zip
    xarchiver

    #messengers
    telegram-desktop
    discord

    #media
    qbittorrent
    brave
    qimgv
    mpv

    #working programs
    libreoffice
    obs-studio

    #system things
    openssl
    neohtop
    pavucontrol
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*" = "qimgv.desktop";
    };

    #if upper thing doesnt work use this thing below

    #associations.added = {
    #  "image/jpeg" = "qimgv.desktop";
    #  "image/png" = "qimgv.desktop";
    #  "image/gif" = "qimgv.desktop";
    #  "image/webp" = "qimgv.desktop";
    #};
  };

  services.hyprpaper = {
  enable = true;
  settings = {
    preload = [
      "~/images/wallpapers/wallpaper.png"
    ];
    wallpaper = [
      # By display
      # {
      #   monitor = "DP-2";
      #   path = "~/wallpapers/wallpaper2.jpg";
      # }
      # By default/fallback
      {
        monitor = "";
        path = "~/images/wallpapers/wallpaper.png"; 
      }
    ];
  };
};

  programs.home-manager.enable = true;
}
