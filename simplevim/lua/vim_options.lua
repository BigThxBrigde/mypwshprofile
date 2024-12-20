local M          = {}
local is_windows = require('vars').is_windows

function M.setup()
    vim.o.clipboard      = is_windows and 'unnamed' or 'unnamedplus'
    vim.o.showcmd        = false
    vim.o.showmode       = false
    vim.o.ruler          = false
    vim.o.number         = true
    vim.o.relativenumber = true
    vim.o.tabstop        = 4
    vim.o.expandtab      = true
    vim.o.shiftwidth     = 4
    vim.o.smarttab       = true
    vim.o.cursorline     = true
    vim.o.completeopt    = 'menu,menuone'
    vim.o.expandtab      = true
    vim.o.ignorecase     = true
    vim.o.smartcase      = true
    vim.o.smartindent    = true
    vim.o.termguicolors  = true
    vim.o.wildmode       = 'longest:full,full'
    vim.o.wrap           = false
    vim.o.splitbelow     = true
    vim.o.splitright     = true
    vim.o.swapfile       = false

    -- Disable intro here
    vim.opt.shortmess:append({ I = true })

    if vim.g.neovide then
        -- put anything you want to happen only in neovide here
        vim.g.neovide_fullscreen       = false
        vim.g.neovide_transparency     = 0.95
        vim.g.neovide_floating_opacity = 0.9
        vim.o.guifont                  = is_windows and 'Cascadia Code NF:h10' or 'FiraCode NF:h10'
    else
        vim.cmd(
            [[
            autocmd colorscheme * highlight normal ctermbg=none guibg=none
        ]])
    end

    if is_windows then
        vim.cmd([[
		let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
		let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'
		let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		let &shellpipe  = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
		set shellquote= shellxquote=
        ]])
    end

    -- disable perl and ruby provider
    vim.cmd(
        [[
      let g:loaded_perl_provider = 0
      let g:loaded_ruby_provider = 0
    ]])
end

return M
