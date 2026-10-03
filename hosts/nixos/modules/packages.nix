{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        #archive things
        xarchiver
        unzip
        p7zip
        zip
        
        #messengers
        telegram-desktop

        #media
        qbittorrent
        qimgv
        mpv

        #working programs
        libreoffice

        #system things
        haskellPackages.greenclip
        pavucontrol
        xwallpaper
        playerctl
        fastfetch
        polybar
        yazi
    ];
}
