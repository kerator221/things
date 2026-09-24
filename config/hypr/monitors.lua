------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
--My setup
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@100",
    position = "1600x0",
    scale    = "auto",
})

hl.monitor({
   output    = "DVI-D-1",
   mode      = "1600x900@60",
   position  = "0x0",
   scale     = "auto",
})

-- For others
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
