{ config, ... }:
{
  programs.hyprland.settings = {

    # ---- WINDOWS (windowrulev2) ----
    windowrulev2 = [
      # suppress-maximize-events
      "suppressevent, maximize, class:.*"

      # fix-xwayland-drags
      "nofocus, class:^$, title:^$, xwayland:1, float:1, fullscreen:0, pin:0"

      # move-hyprland-run
      "float, class:hyprland-run"
      "move, 20 monitor_h-120, class:hyprland-run"
    ];

    # ---- DWINDLE ----
    dwindle = {
      preserve_split = true;
    };

    # ---- MASTER ----
    master = {
      new_status = "master";
    };

    # ---- SCROLLING ----
    scrolling = {
      fullscreen_on_one_column = true;
    };

    # ---- MISC ----
    misc = {
      force_default_wallpaper = -1;
      disable_hyprland_logo = false;
    };
  };
}   