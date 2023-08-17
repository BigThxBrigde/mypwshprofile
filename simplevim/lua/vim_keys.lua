local wk       = require('which-key')
local key_defs = require('keymap')



return {
    setup = function()
        for _, mappings in ipairs(key_defs) do
            wk.register(mappings.keys, mappings.opts)
        end
    end
}
