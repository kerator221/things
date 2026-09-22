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

  #waybar 
  xdg.configFile."waybar/config".source = ../../config/waybar/config;
  xdg.configFile."waybar/modules.json".source = ../../config/waybar/modules.json;
  xdg.configFile."waybar/style.css".source = ../../config/waybar/style.css;

  #kitty
  xdg.configFile."kitty/kitty.conf".source = ../../config/kitty.conf;

  #wallpapers
  home.file."images/wallpapers/wallpaper.png".source = ../../config/wallpaper.png;
  home.file."images/wallpapers/wallpaper2.png".source = ../../config/wallpaper2.png;
  home.file."images/wallpapers/wallpaper3.png".source = ../../config/wallpaper3.png;
  home.file."images/wallpapers/wallpaper4.png".source = ../../config/wallpaper4.png;

  #qt5 (ai slop)
  xdg.configFile."qt5ct/colors/Dracula.conf".source = (pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "qt5";
    rev = "7b25ee305365f6e62efb2c7aca3b4635622b778c";
    sha256 = "00qlajbxj25w1bdhj8wc5r57g25gas6f1ax6wrzb4xcypw0j7xdm";
  }) + "/Dracula.conf";

  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    ColorScheme=Dracula.conf
    Style=Fusion
    [Interfaces]
    ActivateItemDelay=0
    ButtonBoxLayout=0
    CursorBlinkTime=1000
    DialogButtonsLayout=0
    KeyboardScheme=2
    SubmenuDelay=150
  '';

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
    swaynotificationcenter
    hyprlock
    wlogout
    libsForQt5.qt5ct
    pavucontrol
    waypaper

    openssl
    neohtop
  ];

  #fixing hyprland workspaces doesnt switch in waybar https://github.com/hyprwm/Hyprland/issues/725
  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: { 
    mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
    patches = (oa.patches or []) ++ [
      (pkgs.fetchpatch {
        name = "fix waybar hyprctl";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
        sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
      })
    ];
  });

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
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
