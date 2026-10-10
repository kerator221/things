{
  "hyprland/workspaces" = {
    format = "{}";
    persistent-workspaces = {
      "*" = 4
    };
  };

  "custom/wallpaper" = {
    format = "";
    on-click = "walset";
    tooltip-format = "Left: Select a wallpaper";
  };

  "custom/exit" = {
    format = "󰿅";
    on-click = "~/.config/waybar/scripts/wlogout.sh";
    on-click-right = "hyprlock";
    tooltip-format = "Left: Power menu\nRight: Lock screen";
  };

  "clock" = {
    format = "   {:%H:%M}";
    timezone = "";
    tooltip = false;
  };

  "custom/system" = {
    format = "";
    tooltip = false;
  };

  "cpu" = {
    format = "/ C {usage}% ";
  };

  "memory" = {
    format = "/ M {}% ";
  };

  "disk" = {
    interval = 30;
    format = "D {percentage_used}% ";
    path = "/";
  };

  "hyprland/language" = {
    format = "{}";
    on-click = "~/.config/waybar/scripts/language-switch.sh";
  };

  "group/gtools" = {
    orientation = "inherit";
    drawer = {
      transition-duration = 300;
      children-class = "not-memory";
      transition-left-to-right = false;
    };
    modules = [
      "custom/gtools-wrap"
      "disk"
      "cpu"
      "memory"
      "custom/wallpaper"
      "bluetooth"
    ];
  };

  "custom/notification" = {
    tooltip = false;
    format = "{icon}";
    format-icons = {
      notification = "󱅫";
      none = "󰂚";
      dnd-notification = "";
      dnd-none = "󰂛";
      inhibited-notification = "";
      inhibited-none = "";
      dnd-inhibited-notification = "";
      dnd-inhibited-none = "";
    };
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "sleep 0.1 && swaync-client -t -sw";
    on-click-right = "sleep 0.1 && swaync-client -d -sw";
    escape = true;
  };

  "custom/gtools-wrap" = {
    format = "";
    tooltip = false;
  };

  "network" = {
    format = "{ifname}";
    format-wifi = " {essid} ({signalStrength}%)";
    format-ethernet = "   {ifname}";
    format-disconnected = "Disconnected ⚠";
    tooltip-format = " {ifname} via {gwaddri}";
    tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
    tooltip-format-ethernet = "  {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
    tooltip-format-disconnected = "Disconnected";
    max-length = 50;
    on-click = "nm-connection-editor";
  };

  "pulseaudio" = {
      format = "󰕾";
      format-bluetooth = "{icon} {volume}%";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
          headphone = " ";
          hands-free = "󰋋 ";
          headset = "󰋋 ";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
      };
      on-click = "pavucontrol";
  };

  "bluetooth" = {
    format = "󰂯";
    format-disabled = "󰂳";
    format-off = "󰂲";
    interval = 30;
    on-click = "blueman-manager";
    format-no-controller = "";
  };
}