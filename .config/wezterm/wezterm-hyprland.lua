local wezterm = require("wezterm")
local act = wezterm.action
local my_border_color = "#101050"
local my_dracula = wezterm.color.get_builtin_schemes()["Dracula"]
my_dracula.background = "#202020"

local config = {
	color_schemes = { ["My Dracula"] = my_dracula },
	font_size = 11,
	font = wezterm.font("Roboto Mono"),
	color_scheme = "My Dracula",
	tab_bar_at_bottom = true,
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
}

return config
