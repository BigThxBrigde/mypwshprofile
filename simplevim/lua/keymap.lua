local M = {}

local float_term = require('lazy.util').float_term
local show_lazygit = function()
    float_term({'pwsh', '--nologo', '-c', 'lg'})
end

local show_term_pwsh = function()
    float_term({'pwsh', '--nologo'})
end

local show_term_cmd = function()
    float_term({'cmd'})
end

local show_lf = function()

    local function open_lf()
        local file = io.open(".lf_opened_by_vim", 'w')
        file:write("lf opened by vim")
        file:flush()
        file:close()
        local ft = float_term({'lf'})
        return ft
    end

    local lf = open_lf()

    lf:on('TermClose', function(ft)
        local file = io.open('.lf_opened_by_vim', 'r')
        local path = file:read()
        file:close()
        os.execute('cmd /c del /f /q .lf_opened_by_vim')
        if path ~= 'lf opened by vim' then
            -- not perfect here, need type :bn to focus
            vim.cmd.tabedit(path)
        end
    end)
end

--
-- https://stackoverflow.com/questions/7207697/vim-split-buffer-and-have-it-open-at-the-bottom
--
local show_hterm = function()
    vim.cmd([[
        split term://pwsh | resize -15
    ]])
end

local show_vterm = function()
    vim.cmd([[
        vsplit term://pwsh
    ]])
end

local nvim_setkey = vim.keymap.set
local setup = function()
    -- 
    -- https://superuser.com/questions/945329/how-to-disable-the-leader-key-in-vim-insert-mode 
    -- :verbose imap <leader>
    --
    nvim_setkey('n', '<leader>lg', show_lazygit)
    nvim_setkey('n', '<leader>lf', show_lf)
    nvim_setkey('n', '<leader>tp', show_term_pwsh)
    nvim_setkey('n', '<leader>tc', show_term_cmd)
    nvim_setkey('n', '<leader>th', show_hterm)
    nvim_setkey('n', '<leader>tv', show_vterm)
    nvim_setkey('v', '<leader>xa', '<Plug>(EasyAlign)')
    nvim_setkey('n', '<leader>ff', '<cmd>Files<cr>')
    nvim_setkey('n', '<leader>fb', '<cmd>Buffers<cr>')
    nvim_setkey('n', '<leader>xd', '<cmd>Dashboard<cr>')
    nvim_setkey('n', '<leader>bc', '<cmd>bd!<cr>')
    nvim_setkey('n', '<leader>pq', '<cmd>qa!<cr>')
    nvim_setkey('n', '<leader>ps', '<cmd>wa!<cr>')
    nvim_setkey('n', '<leader>xl', '<cmd>Lazy<cr>')
    nvim_setkey('n', '<leader>fn', '<cmd>nohlsearch<cr>')
end

M.setup = setup

return M
