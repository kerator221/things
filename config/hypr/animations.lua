-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- custom
hl.curve("workspaceOpen",  { type = "bezier", points = { {0.66, 0},    {0.52, 1.04} } })
hl.curve("smooth",         { type = "bezier", points = { {0.4, 0.65},    {0.6, 0.98} } })


hl.animation({ leaf = "global",        enabled = true,  speed = 3,    bezier = "easeOutQuint" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "smooth" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 3.5,  bezier = "quick" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 3,    bezier = "smooth",        style = "slide" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 3,    bezier = "smooth",        style = "slide" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 3,    bezier = "workspaceOpen", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 3,    bezier = "workspaceOpen", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 3,    bezier = "workspaceOpen", style = "slide" })
