local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action

-- Colors
config.color_scheme = 'JetBrains Darcula'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}
config.colors = {
  scrollbar_thumb = '#666666',
}

-- Font
config.font = wezterm.font 'Inconsolata'
config.font_size = 14.0
config.adjust_window_size_when_changing_font_size = false

-- Window size
config.initial_rows = 64
config.initial_cols = 272
config.window_padding = {
  left = 2,
  right = 10,
  top = 0,
  bottom = 0,
}

-- Scrollback
config.scrollback_lines = 10000 -- iTerm2 "Unlimited Scrollback": true, but WezTerm default is 3500

-- Key bindings
config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = 'CMD',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = 'w',
    mods = 'CMD|SHIFT',
    action = act.CloseCurrentTab { confirm = true },
  },
  {
    key = 'a',
    mods = 'CMD|SHIFT',
    action = act.ActivateCommandPalette,
  },
  {
    key = 't',
    mods = 'CMD|SHIFT',
    action = act.ShowTabNavigator,
  },
  {
    key = 'Enter',
    mods = 'CMD',
    action = act.TogglePaneZoomState,
  },
  {
    key = 'e',
    mods = 'CMD',
    action = act.ScrollToBottom,
  },
  {
    key = 'e',
    mods = 'CMD|SHIFT',
    action = act.ScrollToTop,
  },
  {
    key = 'k',
    mods = 'CMD',
    action = act.ClearScrollback 'ScrollbackAndViewport',
  },
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|ALT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'RightArrow',
    mods = 'CMD|ALT',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'UpArrow',
    mods = 'CMD|SHIFT',
    action = act.ScrollToPrompt(-1),
  },
  {
    key = 'DownArrow',
    mods = 'CMD|SHIFT',
    action = act.ScrollToPrompt(1),
  },
}

for i = 1, 8 do
  -- CMD + number to activate that pane
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CMD',
    action = act.ActivatePaneByIndex(i - 1),
  })
end

-- Shell
config.default_prog = {'/bin/zsh'}

-- Misc
config.enable_tab_bar = true
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = false

return config
