{ config, lib, pkgs, ... }:

let 
#shortcuts
  fm = '' sh -c "kitty -e yazi" '';
  mod = "Mod4";
  terminal = "kitty";
  finder = "rofi -show drun";
  clipboard = '' rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' ''; #may cause problems
` 
#colors
  bgcolor =      "#523d64";
  "in-bgcolor" = "#363636";
  text =         "#ffffff";
  u-bgcolor =    "#ff0000";
  indicator =    "#a8a3c1";
  "in-text" =    "#969696";
  focused-ws =   "#523d6480";
  bar-color =    "#523d640D";
in {
  imports = [
    ./greenclip.nix
    ../polybar/config.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome 6" ];
        size = 10.0;
      };

      colors = {
        focused = {
          border = ${bgcolor};
          background = ${bgcolor};
          text = ${text};
        };

        focusedInactive = {
          border = ${in-bgcolor};
          background = ${in-bgcolor};
          text = ${in-text};
        };

        unfocused = {
          border = ${in-bgcolor};
          background = ${in-bgcolor};
          text = ${in-text};
        };

        urgent = {
          border = ${u-bgcolor};
          background = ${u-bgcolor};
          text = ${text};
        };
      };

      keybindings = {
        #exec rofi
        "${mod}+space" = "exec --no-startup-id ${finder}";

        #exec yazi in terminal 
        "${mod}+w" = "exec --no-startup-id ${fm}";

        #open clipboard
        "${mod}+v" = "exec --no-startup-id ${clipboard}";

        #kill window
        "${mod}+q" = "kill";

        #exec terminal
        "${mod}+t" = "exec --no-startup-id ${terminal}";
        
        #toggle fullscreen
        "${mod}+f" = "fullscreen toggle";

        #toggle floating
        "${mod}+r" = "floating toggle";

        #reload config
        "${mod}+Shift+r" = "reload";

        "${mod}+l" = "layout toggle split"; # toggle layout

        # switch workspace
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";

        # move to workspace
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
      };

      gaps = {
        inner = 10;
        outer = 0;
      };

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          i3barCommand = "${pkgs.i3}/bin/i3bar --transparency";
          trayOutput = "none";
          colors = {
            #background = ${bgcolor};
            background = ${bar-color};
            separator = "#191919";

            focused_workspace = {
              #border = ${bgcolor};
              #background = ${bgcolor};
              border = ${focused-ws};
              background = ${focused-ws};
              text = ${text};
            };

            inactive_workspace = {
              border = ${in-bgcolor};
              background = ${in-bgcolor};
              text = ${text};
            };

            urgent_workspace = {
              border = ${u-bgcolor};
              background = ${u-bgcolor};
              text = ${text};
            };
          };
        }
      ];

      startup = [
        {
            command = "${pkgs.xwallpaper}/bin/xwallpaper --zoom ${./clouds.jpg}";
        }
      ];
    };
  };
}
