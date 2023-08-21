local M        = {}
local vars     = require('vars')
local lazypath = vars.lazypath

function M.setup()
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable',
            lazypath
        })
    end

    vim.opt.rtp:prepend(lazypath)

    vim.g.mapleader = ' '
end

return M
