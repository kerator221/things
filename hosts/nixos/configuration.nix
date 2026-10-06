{ config, lib, pkgs, inputs, username, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
    
  home-manager.backupFileExtension = "backup";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #networking.hostName = nixos;
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Irkutsk";

  #nix command support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.${username} = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "camera" "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  xdg.mime.enable = true;

  # i3 configuration
  environment.pathsToLink = ["/libexec"]; # Links /libexec from derivations to /run/current-system/sw

  environment.localBinInPath = true;   
  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  programs.git.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
    # Filesystems
    ntfs3g

    # Utilities
    nano
    wget
    curl

    # Development
    #git
    #kitty

    #fonts
    siji
    unifont
   ];

  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.supportedLocales = [
    "ru_RU.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:
  services.blueman.enable = true;
  services.gvfs.enable = true;
  services.usbmuxd.enable = true;
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };
  services.displayManager.defaultSession = "none+i3";

  virtualisation.vmVariant = {
    users.users.${username}.initialPassword = "test";
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}
