{ config, pkgs, lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  #hyprland configs
  xdg.configFile."hypr".source = ../../config/hypr;

  #matugen
  xdg.configFile."matugen".source = ../../config/matugen;

  #waybar 
  xdg.configFile."waybar".source = ../../config/waybar;

  #qt6ct 
  xdg.configFile."qt6ct".source = ../../config/qt6ctc;

  #rofi 
  xdg.configFile."rofi".source = ../../config/rofi;

  #swaync 
  xdg.configFile."swaync".source = ../../config/swaync;

  #wlogout 
  xdg.configFile."wlogout".source = ../../config/wlogout;

  #wallpapers
  home.file.".local/bin/walset".source = ../../config/wallpapers/walset;
  home.file.".local/bin/walset-backend".source = ../../config/wallpapers/walset-backend;

  home.file."images/wallpapers/cars".source = ../../config/wallpapers/cars;
  home.file."images/wallpapers/characters".source = ../../config/wallpapers/characters;
  home.file."images/wallpapers/landscapes".source = ../../config/wallpapers/landscapes;

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
    jq

    swaynotificationcenter
    libnotify
    waypaper
    hyprlock
    wlogout
    libsForQt5.qt5ct
    quickshell

    playerctl
    pavucontrol
    openssl
    neohtop
  ];

  #fixing hyprland workspaces (activate) doesnt switch in waybar 
  #need to add waybar from flake! no solution for now

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
      {
        monitor = "";
        path = "~/images/wallpapers/wallpaper.png"; 
      }
    ];
  };
};

  programs.home-manager.enable = true;
}
