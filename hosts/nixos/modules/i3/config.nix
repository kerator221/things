{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      fonts = {
        names = [ "DejaVu Sans Mono" "FontAwesome 6" ];
        size = 10.0;
      };

      keybindings = {
        #dmenu
        "${mod}+Space" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        #kill window
        "${mod}+q" = "kill";

        #exec terminal
        "${mod}+t" = "exec kitty";
        
        #toggle fullscreen
        "${mod}+f" = "fullscreen toggle";

        #toggle floating
        "${mod}+r" = "floating toggle";

        #reload config
        "${mod}+Shift+r" = "reload";

        "${mod}+h" = "split h"; # horizontal split
        "${mod}+v" = "split v"; # vertical split
        "${mod}+e" = "layout toggle split"; # toggle layout

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
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];

      gaps = {
        inner = 10;
        outer = 0;
      };

      startup = [
        {
            command = "${pkgs.xwallpaper}/bin/xwallpaper --zoom ${./wallpaper.jpg}";
        }
      ];
    };
  };
}