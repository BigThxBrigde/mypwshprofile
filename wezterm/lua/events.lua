local M = {}

local wezterm = require('wezterm')
local _setup = function()

    -- https://stackoverflow.com/questions/18884396/extracting-filename-only-with-pattern-matching
    local function get_proc_name(file)
        local start, finish = file:find('[%w%s!-={-|]+[_%.].+')
        file = file:sub(start, #file)
        return file:match("(.+)%..+")
    end

    wezterm.on('format-window-title', 
        function(tab, pane, tabs, panes, config)
            local zoomed = ''
            if tab.active_pane.is_zoomed then
                zoomed = '[Z] '
            end

            local index = ''
            if #tabs > 1 then
                index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
            end

            return zoomed .. index .. get_proc_name(tab.active_pane.title)
        end)

    -- This function returns the suggested title for a tab.
    -- It prefers the title that was set via `tab:set_title()`
    -- or `wezterm cli set-tab-title`, but falls back to the
    -- title of the active pane in that tab.
    local function tab_title(tab_info)

        local title = tab_info.tab_title 
        -- if the tab title is explicitly set, take that 
        if title and #title > 0 then
            return get_proc_name(title)
        end
        -- Otherwise, use the title from the active pane
        -- in that tab
        return get_proc_name(tab_info.active_pane.title)
    end

    wezterm.on('format-tab-title', 
        function(tab, tabs, panes, config, hover, max_width)
            local title = tab_title(tab)
            if tab.is_active then
              return {
                { Background = { Color = '#BD93F9' } },
                { Text = ' ' .. title .. ' ' },
              }
            end
            return title
        end
    )

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

    --wezterm.on('window-config-reloaded', function(window, pane)
      --window:toast_notification('wezterm', 'Configuration reloaded!', nil, 3000)
    --end)
end

M.setup = _setup

return M
