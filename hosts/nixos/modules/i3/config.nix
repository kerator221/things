{ config, lib, pkgs, ... }:

let 
  fm = "alacritty -e yazi";
  mod = "Mod4";
  terminal = "alacritty";
  finder = "rofi -show drun";
  clipboard = '' rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'" ''; #may cause problems
in {
  imports = [
    ./greenclip.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome 6" ];
        size = 10.0;
      };

      keybindings = {
        #exec rofi
        "${mod}+Space" = "exec finder";

        "${mod}+Enter" = "exec fm";

        "${mod}+v" = "exec clipboard";

        #kill window
        "${mod}+q" = "kill";

        #exec terminal
        "${mod}+t" = "exec terminal";
        
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

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.polybar}/bin/polybar";
        }
      ];

      gaps = {
        inner = 10;
        outer = 0;
      };

      startup = [
        {
            command = "${pkgs.xwallpaper}/bin/xwallpaper --zoom ${./clouds.jpg}";
        }
      ];
    };
  };
}