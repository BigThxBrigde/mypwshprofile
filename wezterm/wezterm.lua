local config = { }

require('events').setup()
require('config').setup(config)
require('keymap').setup(config)

return config
