-- Eviline config for lualine
-- Color table for highlights
-- stylua: ignore

-- This version is modified

-- Use mode_code to get mode description
local get_mode = require('lualine.utils.mode').get_mode
local palette  = require("catppuccin.palettes").get_palette "macchiato"

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
                    fg = palette.text,
                }
            },
            inactive = {
                c = {
                    fg = palette.subtext0,
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
        fg = palette.blue
    }, -- Sets highlighting of component
    padding = {
        left = 0,
        right = 1
    } -- We don't need space before this
}

ins_left {
    -- mode component
    function()
        local mode = get_mode()
        return '  ' .. mode
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n      = palette.green,
            i      = palette.red,
            v      = palette.blue,
            [''] = palette.blue,
            V      = palette.blue,
            c      = palette.maroon,
            no     = palette.red,
            s      = palette.peach,
            S      = palette.peach,
            [''] = palette.peach,
            ic     = palette.yellow,
            R      = palette.sky,
            Rv     = palette.sky,
            cv     = palette.red,
            ce     = palette.red,
            r      = palette.teal,
            rm     = palette.teal,
            ['r?'] = palette.teal,
            ['!']  = palette.yellow,
            t      = palette.yellow
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
        fg = palette.teal
    },
    cond = conditions.buffer_not_empty
}


ins_left {
    'filetype',
    cond = conditions.buffer_not_empty,
    color = {
        fg = palette.yellow,
        gui = 'bold'
    }
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = {
        fg = palette.mauve,
        gui = 'bold'
    }
}

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
        error = ' ',
        warn = ' ',
        info = ' '
    },
    diagnostics_color = {
        color_error = {
            fg = palette.red
        },
        color_warn = {
            fg = palette.yellow
        },
        color_info = {
            fg = palette.teal
        }
    }
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left { function()
    return '%='
end }

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
        fg = palette.flamingo,
        gui = 'bold'
    }
}

-- Right componets
ins_right {
    'location',
    color = {
        fg = palette.sapphire,
    },
    gui = 'bold'
}

ins_right {
    'progress',
    color = {
        fg = palette.lavender,
        gui = 'bold'
    }
}

-- Add components to right sections
ins_right {
    'o:encoding',       -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = {
        fg = palette.rosewater,
        gui = 'bold'
    }
}

ins_right {
    'fileformat',
    color = {
        fg = palette.pink,
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
        fg = palette.pink,
        gui = 'bold'
    }
}


ins_right {
    'branch',
    icon = '',
    color = {
        fg = palette.sky,
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
            fg = palette.green
        },
        modified = {
            fg = palette.peach
        },
        removed = {
            fg = palette.red
        }
    },
    cond = conditions.hide_in_width
}

ins_right {
    function()
        return '▊'
    end,
    color = {
        fg = palette.blue
    },
    padding = {
        left = 1
    }
}

return config
-- Now don't forget to initialize lualine
-- lualine.setup(config)
