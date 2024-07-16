local wk       = require('which-key')
local key_defs = pload('keymap')

return {
    setup = function()
        wk.setup({
            preset = 'helix',
            icons  = {
                rules = {
                    { pattern = "language", icon = "󰃤 ", color = "red" },
                    { pattern = "comments", icon = " ", color = "orange" },
                    { pattern = "extensions", icon = "󰅇", color = "green" },
                    { pattern = "motions", icon = " ", color = "red" },
                }
            }
        })
        for _, mappings in ipairs(key_defs) do
            wk.add(mappings)
        end
    end
}
