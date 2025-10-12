local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- local action = wezterm.action

-- config.color_scheme = "Ayu Mirage"
config.color_scheme = "Tokyo Night Moon"
config.font = wezterm.font("Menlo")
config.font_size = 12

-- Tabs and windows:
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.keys = {
	-- Set CMD + K to reset the terminal:
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ResetTerminal,
	},
	-- {
	-- 	key = "a",
	-- 	mods = "CMD",
	-- 	action = action.Multiple({
	-- 		action.SendKey({ key = "x", mods = "CTRL-CMD" }),
	-- 		action.SendKey({ key = "g" }),
	-- 		action.SendKey({ key = "v" }),
	-- 		action.SendKey({ key = "G" }),
	-- 	}),
	-- },
}

-- config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- table.insert(config.hyperlink_rules, {
-- 	regex = [[^rspec (\./spec/.*):[\d]+]],
-- 	format = "$0",
-- })

return config
