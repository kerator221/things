-----------------------
---- LOOK AND FEEL ----
-----------------------

local c = require("colors")

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,

        border_size = 2,

        col = {
            active_border   = { colors = {c.primary_container, c.on_primary_fixed_variant}, angle = 45 },
            inactive_border = c.surface_bright,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 0.995,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 2,
            color        = c.scrim,
        },

        blur = {
            enabled   = true,
            size      = 10,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})