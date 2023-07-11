local M       = {}
local wezterm = require('wezterm')
local setup   = function(config, _)
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
        {
            key    = 'f',
            mods   = 'CTRL|ALT',
            action = wezterm.action.ToggleFullScreen,
        },
        {
            key    = 'c',
            mods   = 'CTRL|ALT',
            action = wezterm.action.CloseCurrentTab { confirm = true },
        },
        {
            key    = 'UpArrow',
            mods   = 'CTRL',
            action = wezterm.action.ScrollByLine(-1),
        },
        {
            key    = 'DownArrow',
            mods   = 'CTRL',
            action = wezterm.action.ScrollByLine(1),
        },
        {
            key    = '/',
            mods   = 'CTRL',
            action = wezterm.action.Search("CurrentSelectionOrEmptyString"),
        },
        {
            key    = 'n',
            mods   = 'CTRL|ALT',
            action = wezterm.action.ShowTabNavigator,
        },
        {
            key    = 'q',
            mods   = 'ALT',
            action = wezterm.action.QuitApplication,
        },
        {
            key    = 'w',
            mods   = 'ALT',
            action = wezterm.action.CloseCurrentTab { confirm = false },
        },
    }
end

M.setup = setup

return M
