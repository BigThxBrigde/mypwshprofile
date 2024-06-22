-- Function `setup(config, user_config)`, setup configuration and user configuration
--      - config:      Built-in configuration
--      - user_config: Other configuration for user-defined
--
-- wez_home_dir, the wez home directory, depends on platform:
--     - Windows: %USERPROFILE%\Documents\PowerShell\wezterm
--     - Linux:   $HOME/.config/wezterm
--
-- user_config_file, the user_config.lua
--     - Windows: %USERPROFILE%\Documents\PowerShell\wezterm\lua\user_config.lua
--     - Linux:   $HOME/.config/wezterm/user_config.lua
--
-- local_config, the configuration read from the `user_config.lua` file,
-- below is a sample file:
--
--     ```lua
--     local wezterm = require('wezterm')
--
--     return {
--         defaults = {
--             default_prog           = {'zsh'},
--             status_update_interval = 1000,
--             --font_size              = 11.0,
--             font                   = wezterm.font_with_fallback {
--                 { family = 'JetBrains Mono', weight = 'Medium'},
--                 { family = 'Noto Mono',   weight = 'Medium' },
--                 { family = 'FiraCode NF', weight = 'Medium' },
--                 { family = 'Zhiyin',      weight = 'Medium' },
--             },
--             check_for_updates      = false
--         },
--         locals   = {
--             use_fancy_indicator    = false,
--             toggle_tabbar_position = false
--         }
--     }
--     ```


local M          = {}

local util       = require('util')
local wezterm    = require('wezterm')

local os_name, _ = util.get_os_name()
local is_windows = os_name == 'Windows'


local wez_home_dir, user_config_file, local_config

if is_windows then
    wez_home_dir     = os.getenv('USERPROFILE') .. '/Documents/PowerShell/wezterm'
    user_config_file = wez_home_dir .. '/lua/user_config.lua'
else
    wez_home_dir     = os.getenv('HOME') .. '/.config/wezterm'
    user_config_file = wez_home_dir .. '/user_config.lua'
end


if util.file_exists(user_config_file) then
    local_config = require('user_config')
end

local_config          = local_config or {}

local config_locals   = local_config.locals or {}
local font_dirs       = { wez_home_dir .. '/fonts' }

-- Built-in configuration
local config_defaults = {
    default_prog                               = is_windows and { 'pwsh' } or { 'zsh' },
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
    -- front_end                                  = 'WebGpu',
    default_cursor_style                       = 'BlinkingBlock',
    font                                       = wezterm.font_with_fallback {
        { family = 'Noto Sans Mono', weight = 'Bold' },
        { family = 'Zhiyin',         weight = 'Medium' },
        { family = 'JetBrains Mono', weight = 'Medium' }
    },

    set_environment_variables                  = {
        WEZTERM_SESSION = util.get_uuid()
    }
}

-- Override built-in configurations
util.table_merge(config_defaults, local_config.defaults or {})


function M.setup(config, user_config)
    util.table_merge(config, config_defaults)
    util.table_merge(user_config, config_locals)
end

return M
