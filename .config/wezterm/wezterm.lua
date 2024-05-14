local wezterm = require("wezterm")

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
	},
	initial_rows = 50,
	initial_cols = 104,
	enable_scroll_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	audible_bell = "Disabled",
	enable_wayland = false,
}
