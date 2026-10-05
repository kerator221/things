{ config, ... }:

{
  services.polybar.config = {
    "colors" = {
      "background" =     "#181818";
      "background-alt" = "#181818";
      "foreground" =     "#C5C8C6";
      "primary" =        "#3C97E7";
      "alert" =          "#A54242";
      "disabled" =       "#707880";
    };

    "bar/minimal" = {
      "monitor" = "\${env:MONITOR:}";
      "width" = "100%";
      "height" = "15pt";
      "radius" = "0 ; rounded corners radius";
      "bottom" = "true";

      "background" = "\${colors.background}";
      "foreground" = "\${colors.foreground}";

      "line-size" = "2pt";

      "border-size" = "0pt";
      "border-color" = "#00000000";

      "padding-left" = 0;
      "padding-right" = 1;

      "module-margin" = 1;

      "separator" = "|";
      "separator-foreground" = "\${colors.disabled}";

      "font-0" = "monospace:size=10";

      "modules-left" = "xworkspaces";
      "modules-right" = "filesystem xkeyboard memory cpu wlan eth date";

      "cursor-click" = "pointer";
      "cursor-scroll" = "ns-resize";

      "enable-ipc"= "true";
    };

    "module/xworkspaces" = {
      "type" = "internal/xworkspaces";

      "label-active" = "%name%";
      "label-active-background" = "\${colors.background-alt}";
      "label-active-underline" = "\${colors.primary}";
      "label-active-padding" = 1;

      "label-occupied" = "%name%";
      "label-occupied-padding" = 1;

      "label-urgent" = "%name%";
      "label-urgent-background" = "\${colors.alert}";
      "label-urgent-padding" = 1;

      "label-empty" = "%name%";
      "label-empty-foreground" = "\${colors.disabled}";
      "label-empty-padding" = 1;
    };

    "module/filesystem" = {
      "type" = "internal/fs";
      "interval" = 25;
      "mount-0" = "/";

      "label-mounted" = "%{F#3C97E7}%mountpoint%%{F-} %percentage_used%%";
      "label-unmounted" = "%mountpoint% not mounted";
      "label-unmounted-foreground" = "\${colors.disabled}";
    };

    "module/xkeyboard" = {
      "type" = "internal/xkeyboard";
      "blacklist-0" = "num lock";

      "label-layout" = "%layout%";
      "label-layout-foreground" = "\${colors.primary}";

      "label-indicator-padding" = 2;
      "label-indicator-margin" = 1;
      "label-indicator-foreground" = "\${colors.background}";
      "label-indicator-background" = "\${colors.primary}";
    };

    "module/memory" = {
      "type" = "internal/memory";
      "interval" = 2;
      "format-prefix" = '' "RAM " '';
      "format-prefix-foreground" = "\${colors.primary}";
      "label" = "%percentage_used:2%%";
    };

    "module/cpu" = {
      "type" = "internal/cpu";
      "interval" = 2;
      "format-prefix" = "CPU ";
      "format-prefix-foreground" = "\${colors.primary}";
      "label" = "%percentage:2%%";
    };

    "network-base" = {
      "type" = "internal/network";
      "interval" = 5;
      "format-connected" = "<label-connected>";
      "format-disconnected" = "<label-disconnected>";
      "label-disconnected" = "%{F#3C97E7}%ifname%%{F#707880} disconnected";
    };

    "module/wlan" = {
      "inherit" = "network-base";
      "interface-type" = "wireless";
      "label-connected" = "%{F#3C97E7}%ifname%%{F-} %essid% %local_ip%";
    };

    "module/eth" = {
      "inherit" = "network-base";
      "interface-type" = "wired";
      "label-connected" = "%{F#3C97E7}%ifname%%{F-} %local_ip%";
    };

    "module/date" = {
      "type" = "internal/date";
      "interval" = 1;
      "date" = "%d-%b-%Y";
      "time" = "%H:%M:%S";
      "label" = "%date% %time%";
      "label-foreground" = "\${F-}";
    };

    "settings" = {
      "screenchange-reload" = "true";
      "pseudo-transparency" = "true";
    };
  };

  home.file.".config/polybar/launch.sh".text = ''
    #!/usr/bin/env bash

    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -x polybar >/dev/null; do sleep 1; done

    # Launch polybar
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload minimal &
      done
    else
      polybar --reload minimal &
    fi
    # polybar minimal &
  '';
}