--
-- Set the lua package path
--

local pkgpath = os.getenv('SIMPLEVIM') .. '/lua/?.lua'
package.path  = package.path ..  pkgpath

-- print(package.path)
--

--
-- Install lazy.nvim if not installed
--
require('lazy_inst').install()

--
-- Load vim settings
--
require('options').setup()
--
-- Setup lazynvim
--
local plugins      = require('plugins')
local lazy_options = require('lazy_options')

require('lazy').setup(plugins, lazy_options)
