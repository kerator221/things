
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./happ-nixos/happ-module.nix
    ];

  boot.loader = {
    systemd-boot.enable = false;
    grub.enable = true;
    grub.device = "nodev";
    grub.efiSupport = true;
    efi.canTouchEfiVariables = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
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

  #hardware settings 
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
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
   
  services.happ.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.ghosty = {
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
      unzip
      zip
      curl
      wineWowPackages.staging
      winetricks
      obs-studio
      flatpak
      bottles
      lutris
      ntfs3g
      nano
      wget
      kitty
      mpv
      pqiv
      rofi
      vscode
      git
      waybar
      fastfetch
      cliphist
      wl-clipboard
      wlr-randr
      hyprshot
      hyprpaper
      kdePackages.kdenlive
      kdePackages.dolphin
      kdePackages.xdg-desktop-portal-kde
      kdePackages.kservice
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking.networkmanager.enable = true;    
  system.stateVersion = "26.05"; # Did you read the comment?
  
}
