local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

local colors, _ = wezterm.color.load_scheme(wezterm.home_dir .. "/.config/wezterm/tokyonight-storm.toml")
config.colors = colors

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 14

config.tab_max_width = 60
config.tab_bar_at_bottom = true

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, _tabs, _panes, _config, hover, _max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)

    return {
      { Background = { Color = 'none' } },
      { Foreground = { Color = edge_foreground } },
      -- { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      -- { Text = SOLID_RIGHT_ARROW },
    }
  end
)

config.window_decorations = "RESIZE"
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

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
  {
    key = 'd',
    mods = 'SUPER|SHIFT',
    action = act.SplitVertical {
      cwd = wezterm.home_dir
    }
  },
  {
    key = 't',
    mods = 'SUPER',
    action = act.SpawnCommandInNewTab {
      cwd = wezterm.home_dir
    }
  }
}

config.scrollback_lines = 10000

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = 0,
}

return config
