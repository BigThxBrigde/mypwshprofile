local float_term        = require('lazy.util').float_term
local is_windows        = require('vars').is_windows
local telescope_builtin = require('telescope.builtin')

local show_lazygit      = function()
    if is_windows then
        float_term({ 'pwsh', '--nologo', '-c', 'lg' })
    else
        float_term({ 'bash', '-c', 'lazygit' })
    end
end

-- show term1 configuration

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
local show_hterm        = function()
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

local show_vterm        = function()
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

local norm_keys         =
{
    { "<leader>b",  group = "Buffers" },
    { "<leader>bd", "<cmd>bd!<cr>",                desc = "Close current buffer" },
    { "<leader>bl", "<cmd>ls<cr>",                 desc = "List all buffers" },
    { "<leader>bn", "<cmd>bn<cr>",                 desc = "Next buffer" },
    { "<leader>bp", "<cmd>bp<cr>",                 desc = "Previous buffer" },
    { "<leader>bs", telescope_builtin.buffers,     desc = "Find buffers" },
    { "<leader>f",  group = "Files" },
    { "<leader>fS", "<cmd>wa!<cr>",                desc = "Save all files" },
    { "<leader>ff", telescope_builtin.find_files,  desc = "Find files" },
    { "<leader>fg", show_lazygit,                  desc = "Show Lazygit" },
    { "<leader>fn", "<cmd>nohlsearch<cr>",         desc = "No highlight search" },
    { "<leader>fs", "<cmd>w!<cr>",                 desc = "Save current file" },
    { "<leader>ft", "<cmd>Neotree toggle<cr>",     desc = "Toggle Neotree File Manager" },
    { "<leader>fw", "<cmd>%s/\\s\\+$//e<cr>",      desc = "Trim Trailing Whitespace" },
    { "<leader>m",  group = "Motions" },
    { "<leader>mF", "<Plug>Sneak_S",               desc = "Find character backward" },
    { "<leader>mT", "<Plug>Sneak_T",               desc = "Find till character backward" },
    { "<leader>mf", "<Plug>Sneak_s",               desc = "Find character forward" },
    { "<leader>mt", "<Plug>Sneak_t",               desc = "Find till character forward" },
    { "<leader>q",  group = "Quit" },
    { "<leader>qQ", "<cmd>qa!<cr>",                desc = "Quit vim" },
    { "<leader>qq", "<cmd>q!<cr>",                 desc = "Quit current window" },
    { "<leader>w",  group = "Windows" },
    { "<leader>wh", "<cmd>wincmd h<cr>",           desc = "Focus left window" },
    { "<leader>wj", "<cmd>wincmd j<cr>",           desc = "Focus down window" },
    { "<leader>wk", "<cmd>wincmd k<cr>",           desc = "Focus up window" },
    { "<leader>wl", "<cmd>wincmd l<cr>",           desc = "Focus right window" },
    { "<leader>x",  group = "Extensions" },
    { "<leader>xc", telescope_builtin.colorscheme, desc = "Color scheme" },
    { "<leader>xd", "<cmd>Dashboard<cr>",          desc = "Show Dashboard" },
    { "<leader>xg", telescope_builtin.live_grep,   desc = "Live grep" },
    { "<leader>xh", telescope_builtin.help_tags,   desc = "Help tags" },
    { "<leader>xm", "<cmd>Lazy<cr>",               desc = "Show Lazynvim Package Manager" },
    { "<leader>xt", telescope_builtin.treesitter,  desc = "View treesitter" },
    { "<leader>xx", telescope_builtin.commands,    desc = "Execute commands" },
}

local sph_desc          = 'Split horizontally with ' .. (is_windows and 'pwsh' or 'zsh')
local spv_desc          = 'Split vertically with ' .. (is_windows and 'pwsh' or 'zsh')

table.insert(norm_keys, { "<leader>t", group = "Terminal" })
table.insert(norm_keys, { "<leader>th", show_hterm, desc = sph_desc })
table.insert(norm_keys, { "<leader>tv", show_vterm, desc = spv_desc })


if is_windows then
    local show_term_pwsh = function()
        float_term({ 'pwsh', '--nologo' })
    end
    local show_term_cmd = function()
        float_term({ 'cmd' })
    end
    table.insert(norm_keys, { "<leader>tc", show_term_cmd, desc = "Launch terminal with cmd" })
    table.insert(norm_keys, { "<leader>tp", show_term_pwsh, desc = "Launch terminal with pwsh" })
else
    local show_term_bash = function()
        float_term({ 'bash' })
    end
    local show_term_zsh = function()
        float_term({ 'zsh' })
    end
    table.insert(norm_keys, { "<leader>tz", show_term_zsh, desc = "Launch terminal with zsh" })
    table.insert(norm_keys, { "<leader>tb", show_term_bash, desc = "Launch terminal with bash" })
end

local visual_keys      = {
    {
        mode = { "v" },
        { "<leader>m",  group = "Motions" },
        { "<leader>x",  group = "Extensions" },
        { "<leader>xa", "<Plug>(EasyAlign)", desc = "Align with delimeter" },
    },
}

local norm_visual_keys = {
    {
        mode = { "n", "v" },
        { "<leader>c",  group = "Comments" },
        { "<leader>cl", "<Plug>NERDCommenterToggle",  desc = "Toggle comments" },
        { "<leader>l",  group = "Language Server" },
        { "<leader>lI", "<cmd>LspInfo<CR>",           desc = "Show Language Server Info" },
        { "<leader>lq", vim.diagnostic.setqflist,     desc = 'Diagnostic in Quick Fix' },
        { "<leader>ln", vim.diagnostic.goto_next,     desc = 'Next Diagnostic' },
        { "<leader>lp", vim.diagnostic.goto_prev,     desc = 'Previous Diagnostic' },
        { "<leader>lc", vim.lsp.buf.code_action,      desc = 'Code Actions' },
        { "<leader>ld", vim.lsp.buf.definition,       desc = 'Definition' },
        { "<leader>lr", vim.lsp.buf.rename,           desc = 'Rename Symbol' },
        { "<leader>lR", vim.lsp.buf.references,       desc = 'Find All References' },
        { "<leader>lf", vim.lsp.buf.format,           desc = 'Format Document' },
        { "<leader>ls", vim.lsp.buf.document_symbol,  desc = 'Document Symbols' },
        { "<leader>li", vim.lsp.buf.implementation,   desc = 'Go to implementation' },
        { "<leader>lv", vim.lsp.buf.hover,            desc = 'View Document' },
        { "<leader>lS", vim.lsp.buf.workspace_symbol, desc = 'Workspace Symbols' },
    },
}

local key_defs         = {
    norm_keys,
    visual_keys,
    norm_visual_keys
}


return key_defs
