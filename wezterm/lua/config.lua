local M = {}

local wezterm  = require('wezterm')
local get_uuid = require('util').get_uuid
local _merge   = require('util').table_merge


local _setup = function(config)
    _merge(config, {
        default_prog                               = {'pwsh'},
        color_scheme                               = "Catppuccin Mocha",
        enable_tab_bar                             = true,
        font_size                                  = 10,
        window_background_opacity                  = 0.93,
        initial_rows                               = 40,
        initial_cols                               = 150,
        adjust_window_size_when_changing_font_size = false,
        tab_bar_at_bottom                          = true,
        use_fancy_tab_bar                          = false,
        status_update_interval                     = 100
    })

    config.font = wezterm.font_with_fallback{
--        { family = 'Hurmit Nerd Font Mono', weight = 'Bold' },
        { family = 'Noto Sans Mono', weight = 'Medium' },
        { family = 'Zhiyin', weight = 'Medium' },
    }

    -- Set Environment Variables
    config.set_environment_variables = {
        WEZTERM_SESSION = get_uuid()
    }
end

M.setup = _setup

return M
