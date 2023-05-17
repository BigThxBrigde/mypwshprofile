local wezterm = require 'wezterm'
local get_uuid = require('uuid').get_uuid

local config = {

    default_prog              = {'pwsh'},
    color_scheme              = "Catppuccin Mocha",
    enable_tab_bar            = false,
    font_size                 = 10,
    window_background_opacity = 0.95,
    initial_rows              = 40,
    initial_cols              = 120,
}

config.font = wezterm.font('JetBrains Mono', { 
    weight = 'Medium' 
})

-- Set Environment Variables
config.set_environment_variables = {
    WEZTERM_SESSION = get_uuid()
}

config.keys = {
    {
        key    = '_',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.SplitPane {
            direction = 'Down',
        },
    },
    {
        key    = '+',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.SplitPane {
            direction = 'Right',
        },
    },
    {
        key    = 'h',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 }
    },
    {
        key    = 'l',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 }
    },
    {
        key    = 'k',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
    {
        key    = 'j',
        mods   = 'SHIFT|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 }
    },
    {
        key    = 'h',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
        key    = 'l',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
        key    = 'k',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
        key    = 'j',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ActivatePaneDirection 'Down'
    },
    {
        key    = 'r',
        mods   = 'ALT',
        action = wezterm.action.ReloadConfiguration
    },
}

return config
