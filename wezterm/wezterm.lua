local wezterm  = require('wezterm')
local get_uuid = require('uuid').get_uuid

require('events').setup()

--wezterm.on('window-config-reloaded', function(window, pane)
  --window:toast_notification('wezterm', 'Configuration reloaded!', nil, 3000)
--end)

local config = {
    default_prog                               = {'pwsh'},
    color_scheme                               = "Catppuccin Mocha",
    enable_tab_bar                             = true,
    font_size                                  = 10,
    window_background_opacity                  = 0.93,
    initial_rows                               = 45,
    initial_cols                               = 150,
    adjust_window_size_when_changing_font_size = false,
    tab_bar_at_bottom                          = false,
    use_fancy_tab_bar                          = false,
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
        key    = 'd',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ShowDebugOverlay,
    },
    {
        key    = 'n',
        mods   = 'CTRL|ALT',
        action = wezterm.action.ShowTabNavigator,
    },
}

return config
