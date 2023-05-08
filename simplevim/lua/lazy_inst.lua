
local vars          = require('vars')

local root          = vars.root 
local datapath      = vars.datapath
local lazypath      = vars.lazypath
local configpath    = vars.configpath 
local projectspath  = vars.projectspath
local statepath     = vars.statepath

local install_lazynvim = function()
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


return {
    install = install_lazynvim
}
