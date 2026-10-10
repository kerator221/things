{ config, ... }:

{
  programs.hyprland.settings = {
    bezier = [
      "easeOutQuint,   0.23, 1,    0.32, 1"
      "easeInOutCubic, 0.65, 0.05, 0.36, 1"
      "linear,         0,    0,    1,    1"
      "almostLinear,   0.5,  0.5,  0.75, 1"
      "quick,          0.15, 0,    0.1,  1"
      "workspaceOpen,  0.66, 0,    0.52, 1.04"
      "smooth,         0.4,  0.65, 0.6,  0.98"
    ];

    name = [
      "global,        1, 3,    easeOutQuint"
      "border,        1, 5.39, smooth"
      "windows,       1, 3.5,  quick"
      "windowsIn,     1, 3,    smooth, slide"
      "windowsOut,    1, 3,    smooth, slide"
      "workspaces,    1, 3,    workspaceOpen, slide"
      "workspacesIn,  1, 3,    workspaceOpen, slide"
      "workspacesOut, 1, 3,    workspaceOpen, slide"
    ];
  };
}