{ config, ... }:

let 
  mod = "SUPER";
  terminal = "kitty";
  fileManager = "dolphin";
  appMenu = "rofi -config ~/.config/rofi/appfinder.rasi -show drun";
  cliphist = "cliphist list | rofi -config ~/.config/rofi/minimal.rasi -dmenu -display-columns 2 | cliphist decode | wl-copy";
  wsBinds = builtins.map (i: "SUPER, ${toString (if i == 10 then 0 else i)}, workspace, ${toString i}") [1 2 3 4 5 6 7 8 9 10];
  wsMoveBinds = builtins.map (i: "SUPER, SHIFT, ${toString (if i == 10 then 0 else i)}, movetopeworkspace, ${toString i}") [1 2 3 4 5 6 7 8 9 10];
in{
  programs.hyprland.settings = {
    bind = [
      "${mod}, T, exec, ${terminal}"
      "${mod}, Q, killactive"
      "${mod}, M, exec, command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
      "${mod}, V, ${cliphist}"
      "${mod}, R, togglefloating"
      "${mod}, J, togglesplit"
      "${mod}, F, fullscreen, 1"
      "ALT, F, fullscreen, 0"
      "${mod}, W, exec, walset"
      "${mod}, SPACE, exec, ${appmenu}"
      "${mod}, Print, exec, hyprshot -s -m region -o ~/images/screenshots"
      "Print, exec, hyprshot -s -m region --clipboard-only"

      "${mod}, left, focus, l"
      "${mod}, right, focus, r"
      "${mod}, up, focus, u"
      "${mod}, down, focus, d"

      "${builtins.concatStringsSep "\n" wsBinds}"
      "${builtins.concatStringsSep "\n" wsMoveBinds}"
    ];

    bindm = [
      "${mod}, mouse:272, activemove"
      "${mod}, mouse:273, activeresize"
    ];

    input = {
      kb_layout = "us, ru";
      kb_options = "grp:alt_shift_toggle";
      follow_mouse = 1;
      sensitivity = 0;
    };
  };
}