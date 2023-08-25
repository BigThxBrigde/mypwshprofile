-- Ensure lazynvim plugin has been setup

local module = {}
require('lazynvim_setup').setup()

if vim.g.vscode then
    rawset(module, 'lazy_plugins', require('vsc.plugins'))
    rawset(module, 'vim_options',  require('vsc.vim_options'))
else
    rawset(module, 'lazy_plugins', require('plugins'))
    rawset(module, 'vim_options',  require('vim_options'))
end

local lazy         = require('lazy')
local lazy_options = require('lazynvim_options')
local lazy_plugins = module.lazy_plugins
local vim_options  = module.vim_options

vim_options.setup()
lazy.setup(lazy_plugins, lazy_options)
