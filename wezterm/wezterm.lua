local config      = {}
local user_config = {}

require('events').setup(config, user_config)
require('config').setup(config, user_config)
require('keymap').setup(config, user_config)

return config
