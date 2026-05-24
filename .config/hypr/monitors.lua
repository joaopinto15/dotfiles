-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and resolutions possible: hyprctl monitors all

local laptop = "desc:AU Optronics 0x9390"
local asus = "desc:ASUSTek COMPUTER INC VG278 J7LMQS043586"
local samsung = "desc:Samsung Electric Company LU28R55 H4ZR701929"

-- Optimized for retina-class 2x displays, like 13" 2.8K, 27" 5K, 32" 6K.
-- local omarchy_gdk_scale = 2
-- local omarchy_monitor_scale = "auto"

-- Good compromise for 27" or 32" 4K monitors (but fractional!): monitor scale 1.6, GDK scale 1.75.
-- local omarchy_gdk_scale = 1.75
-- local omarchy_monitor_scale = 1.6

-- Straight 1x setup for low-resolution displays like 1080p, 1440p, or ultrawides: both 1.
-- local omarchy_gdk_scale = 1
-- local omarchy_monitor_scale = 1

hl.monitor({ output = asus, mode = "1920x1080@60.00", position = "-55x224", scale = 1 })
hl.monitor({ output = laptop, mode = "1920x1200@60.03", position = "2447x1440", scale = 1.5 })
hl.monitor({ output = samsung, mode = "3840x2160@60.00", position = "1865x0", scale = 1.5 })

hl.workspace_rule({ workspace = "1", monitor = asus, default = true, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = asus })
hl.workspace_rule({ workspace = "3", monitor = samsung, default = true, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = samsung })
hl.workspace_rule({ workspace = "5", monitor = laptop, default = true, persistent = true })
hl.workspace_rule({ workspace = "6", monitor = laptop })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°)
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Example for Framework 13 w/ 6K XDR Apple display.
-- hl.monitor({ output = "DP-5", mode = "6016x3384@60", position = "auto", scale = 2 })
-- hl.monitor({ output = "eDP-1", mode = "2880x1920@120", position = "auto", scale = 2 })

-- Disable the second ghost monitor on an Apple 6K XDR over Thunderbolt.
-- hl.monitor({ output = "DP-2", disabled = true })
