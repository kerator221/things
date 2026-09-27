{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./modules/symlinks.nix
    ./modules/packages.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

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
