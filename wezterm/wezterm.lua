local wezterm  = require 'wezterm' 
local get_uuid = require('uuid').get_uuid

local config = {
  default_prog              = {'pwsh'},
  color_scheme              = "Catppuccin Mocha",
  -- enable_tab_bar            = false,
  font_size                 = 11,
  window_background_opacity = 0.9,
  font                      = wezterm.font('Fira Code', { weight = 'Medium' }),
  initial_rows              = 40,
  initial_cols              = 120,
  set_environment_variables = {
      WEZTERM_SESSION = get_uuid()
  }
}


return config
