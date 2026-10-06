{ config, pkgs, lib, username, mail, ... }:

{
  imports = [
    ./modules/home-packages.nix
    ./modules/i3/config.nix
    ./modules/kitty/config.nix
    ./modules/git/config.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  xdg.mimeApps = {
    enable = true;
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
