{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/i3/config.nix
    ./modules/i3/greenclip.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

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

  programs.home-manager.enable = true;
}
