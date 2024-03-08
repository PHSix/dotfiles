local wezterm = require("wezterm")
local act = wezterm.action

return {
	font = wezterm.font_with_fallback({
		"Macon",
		-- "Monaco",
		"FiraMono Nerd Font",
		"Symbols Nerd Font Mono",
		"Noto Color Emoji",
		"霞鹜文楷",
		-- "ChillKai",
		"monospace",
	}),
	font_size = 20,
	audible_bell = "Disabled",
	enable_tab_bar = false,
	-- color_scheme = "Nord (base16)",
	-- color_scheme = "Edge Light (base16)",
	color_scheme = "GitHub Dark",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	keys = {
		{
			key = "s",
			mods = "CMD",
			action = act.SendKey({
				key = "s",
				mods = "ALT",
			}),
		},
		{
			key = "x",
			mods = "CMD",
			action = act.SendKey({
				key = "x",
				mods = "ALT",
			}),
		},
	},
}

