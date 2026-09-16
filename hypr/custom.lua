---------------------
----  SHORTCUTS  ----
---------------------

local file = io.open(os.getenv("HOME") .. "/.config/tg-ws-proxy/secret.txt", "r")
secret = file:read("*l")
file:close()

-- Set programs that you use
terminal    = "kitty"
fileManager = "dolphin"
appMenu     = "rofi -show drun"
cliphist    = "cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"
--menu        = "hyprlauncher"
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
    hl.exec_cmd("nix run github:pialtor/tg-ws-proxy-flake -- --port 1080 --secret " .. secret)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("waybar & hyprpaper")
    hl.exec_cmd("steam & Telegram")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/


hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Original-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

