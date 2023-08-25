-- Ensure lazynvim plugin has been setup


require('lazynvim_setup').setup()

local lazy         = require('lazy')
local lazy_options = require('lazynvim_options')
local lazy_plugins = pload('plugins')
local vim_options  = pload('vim_options')

vim_options.setup()
lazy.setup(lazy_plugins, lazy_options)
