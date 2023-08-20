local M          = {}
local wezterm    = require('wezterm')

local os_name, _ = require('util').get_os_name()
local is_windows = os_name == 'Windows'

print('OS Platform ' .. os_name)

local wez_home_dir, user_config_file

if is_windows then
    wez_home_dir = os.getenv('USERPROFILE') .. '/Documents/PowerShell/wezterm'
    user_config_file = wez_home_dir .. '/lua/user_config.lua'
else
    wez_home_dir = os.getenv('HOME') .. '/.config/wezterm'
    user_config_file = wez_home_dir .. '/user_config.lua'
end

local get_uuid         = require('util').get_uuid
local file_exists      = require('util').file_exists
local merge            = require('util').table_merge
local user_config_defaults  = {}
local user_config_locals    = {}

--
-- File: user_config.lua
--

-- local wezterm = require('wezterm')
-- 
-- return {
--     defaults = {
--         default_prog           = {'zsh'},
--         status_update_interval = 1000,
--         --font_size              = 11.0,
--         font                   = wezterm.font_with_fallback {
--             { family = 'JetBrains Mono', weight = 'Medium'},
--             { family = 'Noto Mono',   weight = 'Medium' },
--             { family = 'FiraCode NF', weight = 'Medium' },
--             { family = 'Zhiyin',      weight = 'Medium' },
--         },
--         check_for_updates      = false
--     },
--     locals   = {
--         use_fancy_indicator    = false,
--         toggle_tabbar_position = false
--     }
-- }

if file_exists(user_config_file) then
    local local_config = require('user_config')
    user_config_defaults    = local_config.defaults or {}
    user_config_locals      = local_config.locals or {}
end

local font_dirs = {wez_home_dir .. '/fonts'}

local config_defaults = {
    default_prog                               = is_windows and {'pwsh'} or {'zsh'},
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
    font                                       = wezterm.font_with_fallback {
        { family = 'Noto Sans Mono', weight = 'Bold' },
        { family = 'Zhiyin',         weight = 'Medium' },
        { family = 'JetBrains Mono', weight = 'Medium' }
    },

    set_environment_variables                  = {
        WEZTERM_SESSION = get_uuid()
    }
}

merge(config_defaults, user_config_defaults)

local setup = function(config, user_config)

    merge(config,      config_defaults)
    merge(user_config, user_config_locals)

end

M.setup = setup

return M
