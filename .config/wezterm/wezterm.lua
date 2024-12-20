local wezterm = require("wezterm")
local act = wezterm.action

return {
	font_size = 11,
	font = wezterm.font("Roboto Mono"),
	color_scheme = "Dracula",
	keys = {
		{
			key = "Insert",
			mods = "CTRL",
			action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
		},
		{
			key = "f",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "h",
			mods = "ALT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "ALT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "ALT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "ALT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({ direction = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({ direction = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({ direction = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.SplitPane({ direction = "Down" }),
		},
		{
			key = "w",
			mods = "ALT",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "t",
			mods = "CTRL|SHIFT",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "UpArrow",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Up", 3 }),
		},
		{
			key = "RightArrow",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Right", 3 }),
		},
		{
			key = "DownArrow",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Down", 3 }),
		},
		{
			key = "LeftArrow",
			mods = "CTRL|SHIFT",
			action = act.AdjustPaneSize({ "Left", 3 }),
		},
	},
	initial_rows = 50,
	initial_cols = 104,
	enable_scroll_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	audible_bell = "Disabled",
	enable_wayland = false,
	front_end = "OpenGL",
	skip_close_confirmation_for_processes_named = {
		"bash",
		"sh",
		"zsh",
		"ssh",
		"btop",
	},
	window_decorations = "NONE",
	window_frame = {
		border_left_width = "2",
		border_right_width = "2",
		border_bottom_height = "2",
		border_top_height = "2",
		border_left_color = "purple",
		border_right_color = "purple",
		border_bottom_color = "purple",
		border_top_color = "purple",
	},
}
