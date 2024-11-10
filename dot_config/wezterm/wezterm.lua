local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- Main configuration table
local config = {
	automatically_reload_config = true,
	font = wezterm.font("0xProto Nerd Font"),
	font_size = 11.0,
	initial_rows = 55,
	initial_cols = 190,
	color_scheme = "Catppuccin Mocha",
	window_decorations = "NONE",
	animation_fps = 120,
	max_fps = 120,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	enable_tab_bar = false,
	tab_and_split_indices_are_zero_based = true,
}

-- local mux = wezterm.mux
-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

-- Window settings
config.window_padding = {
	left = 4,
	right = 3,
	top = 3,
	bottom = 3,
}
config.window_close_confirmation = "NeverPrompt"

-- Window frame font settings
config.window_frame = {
	font = config.font,
	font_size = config.font_size,
}

-- Tab bar color settings
config.colors = {
	tab_bar = {
		inactive_tab_edge = "#575757",
	},
}
-- Return the final configuration to WezTerm
return config
