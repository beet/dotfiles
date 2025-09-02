local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Ayu Mirage'
config.font = wezterm.font 'Menlo'

config.keys = {
  -- Set COMMAND + K to reset the terminal:
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.ResetTerminal,
  }
}

return config

