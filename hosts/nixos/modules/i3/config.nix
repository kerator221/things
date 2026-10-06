{ config, lib, pkgs, ... }:

let 
  fm = "kitty -e yazi";
  mod = "Mod4";
  terminal = "kitty";
  finder = "rofi -show drun";
  clipboard = '' rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'" ''; #may cause problems
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

      keybindings = {
        #exec rofi
        "${mod}+Space" = "exec --no-startup-id finder";

        "${mod}+Enter" = "exec --no-startup-id fm";

        "${mod}+v" = "exec --no-startup-id clipboard";

        #kill window
        "${mod}+q" = "kill";

        #exec terminal
        "${mod}+t" = "exec --no-startup-id terminal";
        
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

      startup = [
        {
            command = "${pkgs.xwallpaper}/bin/xwallpaper --zoom ${./clouds.jpg}";
        }
        {
            command = "~/.config/polybar/launch.sh";
        }
      ];
    };
  };
}