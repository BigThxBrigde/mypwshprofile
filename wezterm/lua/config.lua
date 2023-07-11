local M = {}

local wezterm                = require('wezterm')
local get_uuid               = require('util').get_uuid
local file_exists            = require('util').file_exists
local merge                  = require('util').table_merge
local usr_cfg_file           = os.getenv('USERPROFILE') .. '/Documents/PowerShell/wezterm/lua/user_config.lua'

local config_defaults, config_locals

if file_exists(usr_cfg_file) then
    local usr_config = require('user_config')
    config_defaults  = usr_config.defaults or {}
    config_locals    = usr_config.locals or {}
end

local font_dirs = {
    os.getenv('USERPROFILE') .. '/Documents/PowerShell/wezterm/fonts'
}

local setup = function(config, user_config)

    local default_config = {
        default_prog                               = {'pwsh'},
        color_scheme                               = "Catppuccin Mocha",
        enable_tab_bar                             = true,
        font_size                                  = 10,
        window_background_opacity                  = 0.93,
        initial_rows                               = 40,
        initial_cols                               = 150,
        adjust_window_size_when_changing_font_size = false,
        tab_bar_at_bottom                          = false,
        use_fancy_tab_bar                          = false,
        status_update_interval                     = 120,
        window_decorations                         = 'RESIZE',
        command_palette_font_size                  = 10.0,
        command_palette_bg_color                   = "#1E1D2E",
        font_dirs                                  = font_dirs,
        font                                       =  wezterm.font_with_fallback{
            { family = 'Noto Sans Mono', weight = 'Bold'   },
            { family = 'Zhiyin',         weight = 'Medium' },
            { family = 'JetBrains Mono', weight = 'Medium' },
        }, 

        set_environment_variables                  = {
            WEZTERM_SESSION = get_uuid()
        }
    }

    merge(default_config, config_defaults or {})
    merge(config,         default_config)
    merge(user_config,    config_locals or {})

end

M.setup = setup

return M
