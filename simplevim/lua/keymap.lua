local float_term = require('lazy.util').float_term
local is_windows = require('vars').is_windows

local show_lazygit = function()
    if is_windows then
        float_term({'pwsh', '--nologo', '-c', 'lg'})
    else
        float_term({'bash', '-c', 'lazygit'})
    end
end

-- show term1 configuration
local show_term1_config = function()
    if is_windows then
        local show_term_pwsh = function()
            float_term({'pwsh', '--nologo'})
        end
        return {
            func = show_term_pwsh,
            desc = 'Launch terminal with pwsh',
            key  = 'p',
        }
    end

    local show_term_zsh = function()
        float_term({'zsh'})
    end
    return {
        func = show_term_zsh,
        desc = 'Launch terminal with zsh',
        key  = 'z',
    }

end

-- show term2 configuration
local show_term2_config = function()
    if is_windows then
        local show_term_cmd = function()
            float_term({'cmd'})
        end
        return {
            func = show_term_cmd,
            desc = 'Launch terminal with cmd',
            key  = 'c',
        }
    end

    local show_term_bash = function()
        float_term({'cmd'})
    end
    return {
        func = show_term_bash,
        desc = 'Launch terminal with bash',
        key  = 'b',
    }

end

local term1_config = show_term1_config()
local term2_config = show_term2_config()

-- not working correctly, without focus and hightlight
--local show_lf

--if is_windows then
--    show_lf = function()
--        local function open_lf()
--            local file = io.open(".lf_opened_by_vim", 'w')
--            local ft
--            if file then
--                file:write('lf opened by vim')
--                file:flush()
--                file:close()
--                ft = float_term({'lf'})
--            end
--            return ft
--        end

--        local lf_ft = open_lf()

--        if not lf_ft then
--            return
--        end

--        local path
--        lf_ft:on('TermClose', function(_)
--            local file = io.open('.lf_opened_by_vim', 'r')
--            if not file then return end
--                path = file:read()
--            file:close()
--            os.execute('cmd /c del /f /q .lf_opened_by_vim')
--            if path ~= 'lf opened by vim' then
--                -- not perfect here, need type :bn to focus
--                vim.cmd(':enew')
--                vim.cmd(':e ' .. path)
--                -- vim.cmd.tabedit(path)
--            end
--        end)
--    end
--end

--
-- https://stackoverflow.com/questions/7207697/vim-split-buffer-and-have-it-open-at-the-bottom
--
local show_hterm = function()
    local cmd
    if is_windows then
        cmd = [[
            split term://pwsh | resize -15
        ]]
    else
        cmd = [[
            split term://zsh | resize -15
        ]]
    end
    vim.cmd(cmd)
end

local show_vterm = function()
    local cmd
    if is_windows then
        cmd = [[
            vsplit term://pwsh
        ]]
    else
        cmd = [[
            vsplit term://zsh
        ]]
    end
    vim.cmd(cmd)
end

-- 
-- https://superuser.com/questions/945329/how-to-disable-the-leader-key-in-vim-insert-mode 
-- :verbose imap <leader>
--

--
--  key map defines
--
local key_defs = {
    -- Leader keys normal mode
    {
        keys = {
            t = {
                name = 'Terminal',
                [term1_config.key] = {term1_config.func, term1_config.desc},
                [term2_config.key] = {term2_config.func, term2_config.desc},
                h = {show_hterm, 'Split horizontally with ' .. (is_windows and 'pwsh' or 'zsh')},
                v = {show_vterm, 'Split vertically with ' .. (is_windows and 'pwsh' or 'zsh')},
            },
            f = {
                name = 'Files',
                f = {'<cmd>Files<cr>', 'Find files'},
                n = {'<cmd>nohlsearch<cr>', 'No highlight search'},
                s = {'<cmd>w!<cr>', 'Save current file'},
                S = {'<cmd>wa!<cr>', 'Save all files'},
                t = {'<cmd>Neotree toggle<cr>', 'Toggle Neotree File Manager'},
                g = {show_lazygit, 'Show Lazygit'},
            },
            x = {
                name = 'Extensions',
                d = {'<cmd>Dashboard<cr>', 'Show Dashboard'},
                m = {'<cmd>Lazy<cr>', 'Show Lazynvim Package Manager'},
                c = {'<cmd>FineCmdline<cr>', 'Execute command'},
                f = {'<cmd>FineCmdline vimgrep <cr>', 'Filter with vimgrep'},
            },
            b = {
                name = 'Buffers',
                s = {'<cmd>Buffers<cr>', 'Find buffers'},
                d = {'<cmd>bd!<cr>', 'Close current buffer'},
                l = {'<cmd>ls<cr>', 'List all buffers'},
                n = {'<cmd>bn<cr>', 'Next buffer'},
                p = {'<cmd>bp<cr>', 'Previous buffer'},
            },
            q = {
                name = 'Quit',
                q = {'<cmd>q!<cr>', 'Quit current window'},
                Q = {'<cmd>qa!<cr>', 'Quit vim'},
            },
            m = {
                name = 'Motions',
                f = {'<Plug>Sneak_s', 'Find character forward'},
                F = {'<Plug>Sneak_S', 'Find character backward'},
                t = {'<Plug>Sneak_t', "Find till character forward"},
                T = {'<Plug>Sneak_T', 'Find till character backward'},
            }
        },
        opts = {
            prefix = "<leader>"
        }
    },
    -- Leader keys visual mode
    {
        keys = {
            x = {
                name = 'Extensions',
                a = {'<Plug>(EasyAlign)', 'Align with delimeter'},
            },
            m = {
                name = 'Motions',
            }
        },
        opts = {
            prefix = '<leader>',
            mode   = 'v'
        }
    },
    {
        keys = {
            c = {
                name = 'Comments',
                l = {'<Plug>NERDCommenterToggle', 'Toggle comments'},
            },
            l = {
                name = 'Language Server',
                q = {'<cmd>lua vim.diagnostic.setqflist()<cr>', 'Diagnostic in Quick Fix'},
                n = {'<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next Diagnostic'},
                p = {'<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous Diagnostic'},
                c = {'<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Actions'},
                d = {'<cmd>lua vim.lsp.buf.definition()<cr>', 'Definition'},
                r = {'<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename Symbol'},
                R = {'<cmd>lua vim.lsp.buf.references()<cr>', 'Find All References'},
                f = {'<cmd>lua vim.lsp.buf.format()<cr>', 'Format Document'},
                s = {'<cmd>lua vim.lsp.buf.document_symbol()<cr>', 'Document Symbols'},
                i = {'<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation'},
                v = {'<cmd>lua vim.lsp.buf.hover()<cr>', 'View Document'},
                S = {'<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', 'Workspace Symbols'},
                I = {'<cmd>LspInfo<CR>', 'Show Language Server Info'}
            },
        },
        opts = {
            prefix = '<leader>',
            mode   = {'v', 'n'}
        }
    },
}

--if show_lf then
--    table.insert(key_defs,
--    {
--        keys = {
--            l = {
--                name = 'File System',
--                f = {show_lf, 'Show LF Manager'}
--            },
--        },
--        opts = {
--            prefix = "<leader>"
--        }
--    })
--end


return key_defs
