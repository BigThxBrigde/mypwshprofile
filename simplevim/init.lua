--
-- Set the lua package path
--

-- local pkgpath = os.getenv('SIMPLEVIM') .. '/lua/?.lua'
-- package.path  = package.path ..  pkgpath

-- print(package.path)
--
--
-- Install lazy.nvim if not installed
--
require('lazynvim_setup').setup()
--
-- Load vim settings
--
require('vim_options').setup()
--
-- Setup lazynvim
--
local plugins      = require('plugins')
local lazy_options = require('lazynvim_options')

require('lazy').setup(plugins, lazy_options)
