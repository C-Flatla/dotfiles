local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local jo_dir = wezterm.home_dir .. '/workspace/jobber'
  local jfe_dir = wezterm.home_dir .. '/workspace/jobber-frontend/apps/jobber-online'
  local tab, left_pane, window = mux.spawn_window {
    cwd = jo_dir,
    position = {
      x = 1756,
      y = 0,
    },
    width = 239,
    height = 91,
  }

  local right_pane = left_pane:split {
    direction = 'Right',
    size = 0.5,
    cwd = jo_dir,
  }

  left_pane:split {
    direction = 'Bottom',
    size = 0.5,
    cwd = jo_dir,
  }

  right_pane:split {
    direction = 'Bottom',
    size = 0.7,
    cwd = jo_dir,
  }:split {
    direction = 'Bottom',
    size = 0.6,
    cwd = jo_dir,
  }:split {
    direction = 'Bottom',
    size = 0.5,
    cwd = jo_dir,
  }:split {
    direction = 'Bottom',
    size = 0.5,
    cwd = jfe_dir,
  }
end)

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
    key = 'e',
    mods = 'CMD|SHIFT',
    action = act.ShowLauncherArgs {
      title = 'Select workspace',
      flags = 'WORKSPACES',
    },
  },
  {
    key = 'r',
    mods = 'CMD|SHIFT',
    action = act.PaneSelect {
      show_pane_ids = true,
      alphabet = 'aoeuidhtns',
    },
  },
  {
    key = 'n',
    mods = 'CMD|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  -- Broadcast to all panes
  {
    key = 's',
    mods = 'CMD|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter text to broadcast to all panes' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        local tab = pane:tab()
        if line then
          for _, pane_item in ipairs(tab:panes_with_info()) do
            pane_item.pane:send_text(line .. '\n')
          end
        end
      end),
    },
  },
  -- Inspiration from: https://github.com/wezterm/wezterm/discussions/1130#discussioncomment-4678096
  {
    key = 'i',
    mods = 'CMD|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local prompt_regex = '.+\u{e0b0} '
      local tab = pane:tab()
      local txt = pane:get_logical_lines_as_text()
      local cmd = string.gsub(txt, prompt_regex, '')
      for _, p in ipairs(tab:panes_with_info()) do
        if p.is_active then
          p.pane:send_text('\n')
        else
          p.pane:send_text(cmd..'\n')
        end
      end
    end),
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
    key = 'Home',
    mods = '',
    action = act.ScrollToTop,
  },
  {
    key = 'End',
    mods = '',
    action = act.ScrollToBottom,
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
