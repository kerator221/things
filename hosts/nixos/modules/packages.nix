{ config, pkgs, ... }:


{
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
        awww
        lz4
        matugen
        jq

        swaynotificationcenter
        libnotify
        waypaper
        hyprlock
        wlogout
        libsForQt5.qt5ct
        quickshell

        playerctl
        pavucontrol
        openssl
        neohtop
    ];
}
