{
  mainBar = {
    layer = "bottom";
    position = "top";
    exclusive = false;
    gtk-layer-shell = true;
    margin = 8 8 0 8;
    passthrough = false;
    spacing = 3;
    fixed-center = true;
    height = 35;

    include = [ 
      "~/.config/waybar/modules.nix"
    ];

    modules-left = [ 
      "clock"
      "tray"
      "hyprland/workspaces"
    ];

    modules-right = [  
        "pulseaudio"
        "hyprland/language"
        "group/bubble"
    ];

    "group/bubble" = {
      orientation = "inherit";
      modules = [
        "group/gtools"
        "custom/notification"
        "custom/exit"
      ];
    };

    "tray" = {
      icon-size = 18;
      spacing = 10;
    };
  };
}