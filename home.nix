{ config, pkgs, username, ... }:

{
  nixpkgs.config.allowUnfree = true;   

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    #hyprpaper
    pavucontrol
    p7zip
    xarchiver
    htop
    telegram-desktop
    discord
    qbittorrent
    libreoffice
    brave
    qimgv
    openssl
    neohtop
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/*" = "qimgv.desktop";
    };
    associations.added = {
      "image/jpeg" = "qimgv.desktop";
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
