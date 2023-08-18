local M = {}
local is_windows = require('vars').is_windows


M.setup = function()
    vim.o.guifont        = 'agave nfm r:h12'
    vim.o.clipboard      = is_windows and 'unnamed' or 'unnamedplus'
    vim.o.number         = true
    vim.o.relativenumber = true
    vim.o.tabstop        = 4
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

    if vim.g.neovide then
      -- put anything you want to happen only in neovide here
        vim.g.neovide_fullscreen       = false
        vim.g.neovide_transparency     = 0.9
        vim.g.neovide_floating_opacity = 0.9
    else
        vim.cmd([[   
            autocmd colorscheme * highlight normal ctermbg=none guibg=none
        ]])
    end

    -- disable perl and ruby provider
    vim.cmd([[
      let g:loaded_perl_provider = 0
      let g:loaded_ruby_provider = 0
    ]])


end

return M

