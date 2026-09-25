{ config, pkgs, lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  #hyprland config
  xdg.configFile."hypr/hyprland.lua".source = ../../config/hypr/hyprland.lua;
  xdg.configFile."hypr/animations.lua".source = ../../config/hypr/animations.lua;
  xdg.configFile."hypr/custom.lua".source = ../../config/hypr/custom.lua;
  xdg.configFile."hypr/decorations.lua".source = ../../config/hypr/decorations.lua;
  xdg.configFile."hypr/keybindings.lua".source = ../../config/hypr/keybindings.lua;
  xdg.configFile."hypr/monitors.lua".source = ../../config/hypr/monitors.lua;
  xdg.configFile."hypr/permissions.lua".source = ../../config/hypr/permissions.lua;
  xdg.configFile."hypr/windows.lua".source = ../../config/hypr/windows.lua;

  #matugen
  xdg.configFile."matugen/config.toml".source = ../../config/matugen/config.toml;
  xdg.configFile."matugen/templates/colors.css".source = ../../config/matugen/templates/colors.css;
  xdg.configFile."matugen/templates/gtk-colors.css".source = ../../config/matugen/templates/gtk-colors.css;
  xdg.configFile."matugen/templates/qtct-colors.conf".source = ../../config/matugen/templates/qtct-colors.conf;
  xdg.configFile."matugen/templates/rofi-colors.rasi".source = ../../config/matugen/templates/rofi-colors.rasi;
  xdg.configFile."matugen/templates/kitty-colors.conf".source = ../../config/matugen/templates/kitty-colors.conf;
  xdg.configFile."matugen/templates/hyprland-colors.lua".source = ../../config/matugen/templates/hyprland-colors.lua;

  #waybar 
  xdg.configFile."waybar/config".source = ../../config/waybar/config;
  xdg.configFile."waybar/modules.json".source = ../../config/waybar/modules.json;
  xdg.configFile."waybar/style.css".source = ../../config/waybar/style.css;

  #wallpapers
  home.file.".local/bin/walset".source = ../../config/wallpapers/walset;
  home.file.".local/bin/walset-backend".source = ../../config/wallpapers/walset-backend;

  home.file."images/wallpapers/white nixos.png".source = ../../config/wallpapers/wallpaper.png;
  home.file."images/wallpapers/dark blue nixos.png".source = ../../config/wallpapers/wallpaper2.png;
  home.file."images/wallpapers/black mountain.png".source = ../../config/wallpapers/wallpaper3.png;
  home.file."images/wallpapers/gray mountain.png".source = ../../config/wallpapers/wallpaper4.png;

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
    awww
    lz4
    matugen

    swaynotificationcenter
    libnotify
    waypaper
    hyprlock
    wlogout
    libsForQt5.qt5ct
    quickshell

    pavucontrol
    openssl
    neohtop
  ];

  #fixing hyprland workspaces (activate) doesnt switch in waybar 
  #need to add waybar from flake! no solution now

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  gtk = {
    enable = true;
  };

  # AI SLOP FOR LIBADWAITA APPS
  gtk.gtk4.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };

  xdg.mimeApps = {
    enable = true;
    #defaultApplications = {
    #  "image/*" = "qimgv.desktop";
    #};

    #if upper thing doesnt work use this thing below

    associations.added = {
      "image/jpeg" = "qimgv.desktop";
      "image/jpg" = "qimgv.desktop";
      "image/png" = "qimgv.desktop";
      "image/gif" = "qimgv.desktop";
      "image/webp" = "qimgv.desktop";
    };
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
