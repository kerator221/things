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
        firefox
        qimgv
        mpv

        #working programs
        libreoffice
        vscodium

        #system things
        haskellPackages.greenclip
        swaynotificationcenter
        pavucontrol
        xwallpaper
        playerctl
        fastfetch
        #hellwal
        polybar
        rofi
        yazi
    ];
}
