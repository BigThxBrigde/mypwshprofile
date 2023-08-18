-- Eviline config for lualine
-- Color table for highlights
-- stylua: ignore

-- This version id modified

local colors = require("catppuccin.palettes").get_palette "macchiato"

--for k,v in pairs(colors) do
--    print(k .. ' ' .. v)
--end

-- sapphire  #7dc4e4
-- peach     #f5a97f
-- surface0  #363a4f
-- mantle    #1e2030
-- teal      #8bd5ca
-- maroon    #ee99a0
-- surface1  #494d64
-- surface2  #5b6078
-- blue      #8aadf4
-- mauve     #c6a0f6
-- red       #ed8796
-- pink      #f5bde6
-- overlay1  #8087a2
-- flamingo  #f0c6c6
-- overlay0  #6e738d
-- overlay2  #939ab7
-- rosewater #f4dbd6
-- yellow    #eed49f
-- text      #cad3f5
-- subtext0  #a5adcb
-- sky       #91d7e3
-- crust     #181926
-- subtext1  #b8c0e0
-- green     #a6da95
-- lavender  #b7bdf8
-- base      #24273a

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            normal = {
                c = {
                    fg = colors.text,
                }
            },
            inactive = {
                c = {
                    fg = colors.subtext0,
                }
            }
        }
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
    }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = {
        fg = colors.blue
    }, -- Sets highlighting of component
    padding = {
        left = 0,
        right = 1
    } -- We don't need space before this
}

ins_left {
    -- mode component
    function()
        return ''
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.maroon,
            no = colors.red,
            s = colors.peach,
            S = colors.peach,
            [''] = colors.peach,
            ic = colors.yellow,
            R = colors.sky,
            Rv = colors.sky,
            cv = colors.red,
            ce = colors.red,
            r = colors.teal,
            rm = colors.teal,
            ['r?'] = colors.teal,
            ['!'] = colors.red,
            t = colors.red
        }
        return {
            fg = mode_color[vim.fn.mode()]
        }
    end,
    padding = {
        right = 1
    }
}

ins_left {
    -- filesize component
    'filesize',
    color = {
        fg = colors.teal
    },
    cond = conditions.buffer_not_empty
}


ins_left {
    'filetype',
    cond = conditions.buffer_not_empty,
    color = {
        fg = colors.yellow,
        gui = 'bold'
    }
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = {
        fg = colors.mauve,
        gui = 'bold'
    }
}


ins_left {
    'location',
    color = {
        fg = colors.green,
    }
}

ins_left {
    'progress',
    color = {
        fg = colors.yellow,
        gui = 'bold'
    }
}

ins_left {
    'diagnostics',
    sources = {'nvim_diagnostic'},
    symbols = {
        error = ' ',
        warn = ' ',
        info = ' '
    },
    diagnostics_color = {
        color_error = {
            fg = colors.red
        },
        color_warn = {
            fg = colors.yellow
        },
        color_info = {
            fg = colors.teal
        }
    }
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {function()
    return '%='
end}

ins_left {
    -- Lsp server name .
    function()
        local msg = 'LSP N/A'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = {
        fg = colors.flamingo,
        gui = 'bold'
    }
}



-- Add components to right sections
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = {
        fg = colors.green,
        gui = 'bold'
    }
}

ins_right {
    'fileformat',
    color = {
        fg = colors.peach,
        gui = 'bold'
    }
}

-- How to combine this two parts, I don't know well
--
ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = {
        fg = colors.peach,
        gui = 'bold'
    }
}


ins_right {
    'branch',
    icon = '',
    color = {
        fg = colors.sky,
        gui = 'bold'
    }
}


ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = {
        added = ' ',
        modified = '󰝤 ',
        removed = ' '
    },
    diff_color = {
        added = {
            fg = colors.green
        },
        modified = {
            fg = colors.peach
        },
        removed = {
            fg = colors.red
        }
    },
    cond = conditions.hide_in_width
}

ins_right {
    function()
        return '▊'
    end,
    color = {
        fg = colors.blue
    },
    padding = {
        left = 1
    }
}

return config
-- Now don't forget to initialize lualine
-- lualine.setup(config)

