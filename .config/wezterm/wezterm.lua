local wezterm = require 'wezterm'

return {
	font_size = 11,
	font = wezterm.font("Roboto Mono"),
	color_scheme = "Dracula",
	keys = {
		{
			key = 'Insert',
			mods = 'CTRL',
			action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
		},
	},
	initial_rows = 24,
	initial_cols = 104,
	enable_scroll_bar = true,
	default_prog = { 'bash' },
	hide_tab_bar_if_only_one_tab = true,
	audible_bell = "Disabled",
}
