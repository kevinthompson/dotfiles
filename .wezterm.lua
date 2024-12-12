local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 18

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = "Tokyo Night"

config.keys = {
  { mods = "OPT", key = "LeftArrow", action = action.SendKey({ mods = "ALT", key = "b" }) },
  { mods = "OPT", key = "RightArrow", action = action.SendKey({ mods = "ALT", key = "f" }) },
}

return config
