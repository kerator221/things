{ config, ... }:

{
  programs.hyprland.settings.monitor = [
    "HDMI-A-1, 1920x1080@100, 1600x0, auto"
    "DVI-D-1, 1600x900@60, 0x0, auto"
    ", preferred, auto, auto"
  ];
}