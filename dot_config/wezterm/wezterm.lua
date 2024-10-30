local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Main configuration table
local config = {
  automatically_reload_config = true,
  font = wezterm.font('JetBrainsMono Nerd Font'),
  font_size = 12.0,
  color_scheme = 'Catppuccin Mocha',
  window_decorations = "RESIZE",
  animation_fps = 144,
  max_fps = 144,
  front_end = 'WebGpu',
  webgpu_power_preference = 'HighPerformance',
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  tab_and_split_indices_are_zero_based = true,
}


local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)


-- Window settings
config.window_padding = {
  left = 3,
  right = 5,
  top = 5,
  bottom = 3,
}
config.window_close_confirmation = 'NeverPrompt'

-- Window frame font settings
config.window_frame = {
  font = config.font,
  font_size = config.font_size,
}

-- Tab bar color settings
config.colors = {
  tab_bar = {
    inactive_tab_edge = '#575757',
  },
}

-- Copy mode Vim-like key bindings
local copy_mode_keys = {
  { key = 'h', action = act.CopyMode 'MoveLeft' },
  { key = 'j', action = act.CopyMode 'MoveDown' },
  { key = 'k', action = act.CopyMode 'MoveUp' },
  { key = 'l', action = act.CopyMode 'MoveRight' },
  { key = 'w', action = act.CopyMode 'MoveForwardWord' },
  { key = 'b', action = act.CopyMode 'MoveBackwardWord' },
  { key = '0', action = act.CopyMode 'MoveToStartOfLine' },
  { key = '$', action = act.CopyMode 'MoveToEndOfLineContent' },
  { key = 'g', action = act.CopyMode 'MoveToScrollbackTop' },
  { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
  { key = 'v', action = act.CopyMode { SetSelectionMode = 'Cell' } },
  { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
  { key = 'y', action = act.Multiple {
      { CopyTo = 'ClipboardAndPrimarySelection' },
      { CopyMode = 'Close' },
    }
  },
  { key = 'q', action = act.CopyMode 'Close' },
  { key = 'PageUp', action = act.CopyMode 'PageUp' },
  { key = 'PageDown', action = act.CopyMode 'PageDown' },
}

-- Define key tables
config.key_tables = {
  copy_mode = copy_mode_keys
}

-- Define leader key and timeout
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

-- Pane direction bindings
local pane_keys = {
  { key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
}

-- Resize pane bindings
local resize_keys = {
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'h', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'l', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'k', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
  { key = 'j', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
}

-- Define overall key bindings, including copy mode and pane control
config.keys = {
  { mods = 'LEADER', key = '[', action = wezterm.action.ActivateCopyMode },
  { mods = "LEADER", key = "c", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  { mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane { confirm = true } },
  { mods = "LEADER", key = "p", action = wezterm.action.ActivateTabRelative(-1) },
  { mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
  { mods = "LEADER|SHIFT", key = '"', action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { mods = "LEADER|SHIFT", key = "%", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  table.unpack(pane_keys),
  table.unpack(resize_keys)
}



for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

-- Domain-related keybindings
table.insert(config.keys, {
  key = 'a',
  mods = 'LEADER',
  action = wezterm.action.AttachDomain('unix'),
})
table.insert(config.keys, {
  key = 'd',
  mods = 'LEADER',
  action = wezterm.action.DetachDomain { DomainName = 'unix' },
})

-- Rename current session
table.insert(config.keys, {
  key = '$',
  mods = 'LEADER|SHIFT',
  action = wezterm.action.PromptInputLine {
    description = 'Enter new name for session',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        mux.rename_workspace(window:mux_window():get_workspace(), line)
      end
    end),
  },
})

-- Show workspace list
table.insert(config.keys, {
  key = 's',
  mods = 'LEADER',
  action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
})

-- Status bar customization (example for left status)
wezterm.on("update-right-status", function(window, _)
  local SOLID_LEFT_ARROW = ""
  local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
  local prefix = ""

  if window:leader_is_active() then
    prefix = " " .. utf8.char(0x1f30a) -- Ocean wave
    SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  end

  if window:active_tab():tab_id() ~= 0 then
    ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
  end

  window:set_left_status(wezterm.format {
    { Background = { Color = "#b7bdf8" } },
    { Text = prefix },
    ARROW_FOREGROUND,
    { Text = SOLID_LEFT_ARROW }
  })
end)

-- Add unix domains
config.unix_domains = {
  { name = "unix" }
}

-- Return the final configuration to WezTerm
return config
