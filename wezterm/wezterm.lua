local wezterm = require('wezterm')
local get_uuid = require('uuid').get_uuid

wezterm.on("update-right-status", function(window, pane)

	local cwd      = " 📁 "..pane:get_current_working_dir():sub(9).." " -- remove file:// uri prefix
	local date     = wezterm.strftime(" 📅 %A %B %-d ")
    local time     = wezterm.strftime(" ⏲  %I:%M %p ")
	local hostname = " 💻 "..wezterm.hostname().." "
    local bat      = ''

    for _, b in ipairs(wezterm.battery_info()) do
        bat = ' 🔋' .. string.format('%.0f%%', b.state_of_charge * 100) .. ' '
    end

	window:set_right_status(
		wezterm.format({
            -- current working directory
            { Attribute  = { Intensity = "Bold"    } },
			{ Foreground = { Color     = "#44475A" } },
			{ Background = { Color     = "#ABE9B3" } },
			{ Text       = cwd                       },
            -- time
            { Attribute  = {Intensity  = "Bold"    } },
			{ Foreground = {Color      = "#44475A" } },
			{ Background = {Color      = "#F5C2E7" } },
			{ Text       = time                      },
            -- date
            { Attribute  = {Intensity  = "Bold"    } },
			{ Foreground = {Color      = "#44475A" } },
			{ Background = {Color      = "#96CDFB" } },
			{ Text       = date                      },
            -- host name
            { Attribute  = {Intensity  = "Bold"    } },
			{ Foreground = {Color      = "#44475A" } },
			{ Background = {Color      = "#F28FAD" } },
			{ Text       = hostname                  },
            -- battery
            { Attribute  = {Intensity  = "Bold"    } },
			{ Foreground = {Color      = "#44475A" } },
			{ Background = {Color      = "#FAE3B0" } },
			{ Text       = bat                       },
		}));
end);

wezterm.on('window-config-reloaded', function(window, pane)
  window:toast_notification('wezterm', 'Configuration reloaded!', nil, 4000)
end)

local config = {
    default_prog                               = {'pwsh'},
    color_scheme                               = "Catppuccin Mocha",
    enable_tab_bar                             = true,
    font_size                                  = 10,
    window_background_opacity                  = 0.95,
    initial_rows                               = 40,
    initial_cols                               = 120,
    adjust_window_size_when_changing_font_size = false,
    tab_bar_at_bottom                          = true,
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
}

return config
