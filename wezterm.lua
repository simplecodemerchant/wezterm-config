local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

colors, metadata = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/tokyonight-storm.toml")
config.colors = colors

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14

config.enable_tab_bar = true

config.window_decorations = "INTEGRATED_BUTTONS"

config.keys = {
  {
    key = "LeftArrow",
    mods = "CMD",
    action = act.ActivateTabRelative(-1)
  },
  {
    key = "RightArrow",
    mods = "CMD",
    action = act.ActivateTabRelative(1)
  },
}

config.scrollback_lines = 10000

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = 0,
  bottom = 0,
}

return config
