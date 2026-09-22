
{ config, lib, pkgs, username, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
    
  home-manager.backupFileExtension = "backup";

  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Irkutsk";

  #nix command support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  nixpkgs.config.problems.handlers = {
    hyper.broken = "warn";
  };

  #hardware settings 
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Enable sound.
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };
   
  #bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.${username} = {
     isNormalUser = true;
     extraGroups = [ "camera" "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  xdg.mime.enable = true;
  xdg.menus.enable = true;
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;

  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  environment.variables.SUDO_EDITOR = "code --wait";   #makes vscode as sudo editor
  
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };   

  programs.gphoto2.enable = true;
  programs.git.enable = true;
  programs.hyprland.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
    # Gaming
    wineWowPackages.staging
    winetricks
    bottles
    lutris

    # Filesystems
    ntfs3g

    # Utilities
    flatpak
    nano
    wget

    # Development
    hyper
    rofi
    vscode
    git

    # Hyprland / Desktop
    waybar
    fastfetch
    cliphist
    wl-clipboard
    wlr-randr
    hyprshot
    hyprpaper

    # KDE
    kdePackages.kdenlive
    kdePackages.dolphin
    kdePackages.xdg-desktop-portal-kde
    kdePackages.kservice

    # Camera
    gphoto2fs
   ];

  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.iosevka
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      corefonts
      vista-fonts
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      dejavu_fonts
      proggyfonts
    ];
    fontDir.enable = true;
    fontconfig.enable = true;
    fontconfig.defaultFonts = {
      sansSerif = [ "Liberation Sans" "Noto Sans" "DejaVu Sans" ];
      serif = [ "Liberation Serif" "Noto Serif" ];
      monospace = [ "JetBrainsMono Nerd Font" "DejaVu Sans Mono" ];
    };
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  virtualisation.vmVariant = {
    users.users.${username}.initialPassword = "test";
  };

  # List services that you want to enable:
  services.xserver.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?
  
}
