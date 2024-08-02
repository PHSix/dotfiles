local wezterm = require("wezterm")
local act = wezterm.action

local c = wezterm.config_builder()

return {
	font = wezterm.font_with_fallback({
		-- "Macon",
		-- "Monaco",
		-- "Maple Mono NF",
		"JetBrains Mono",
		"Symbols Nerd Font Mono",
		"FiraCode Nerd Font",
		"Noto Color Emoji",
		"霞鹜文楷",
		-- "ChillKai",
		"monospace",
	}),
	use_fancy_tab_bar = false,
	font_size = 22,
	audible_bell = "Disabled",
	enable_tab_bar = false,
	-- color_scheme = "Nord (base16)",
	color_scheme = "Edge Light (base16)",
	-- color_scheme = "GitHub Dark",
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

