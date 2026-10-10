{ config, ... }:

{
  programs.hyprland.settings = {
    exec-once = [
      "nix run github:pialtor/tg-ws-proxy-flake -- --port 1080 --secret ${secret}"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "awww-daemon"
      "steam"
      "Telegram"
    ];

    exec = [
      "waybar"
      "hyprpaper"
      "awww --restore"
    ];

    env = [
      "XCURSOR_SIZE=24"
      "HYPRCURSOR_THEME=Bibata-Original-Ice"
      "HYPRCURSOR_SIZE=24"
    ];
  };
}