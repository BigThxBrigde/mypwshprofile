
--
-- Execute vscode editor action
--
local function vsc_editor_action(action_id)
    local fmt = "<cmd>call VSCodeCall('editor.action.%s')<cr>"
    return fmt:format(action_id)
end

local key_defs = {
    {
        keys = {
            l = {
                f = {vsc_editor_action('formatDocument'), 'Format Document'},
            }
        },
        opts = {
            prefix = '<leader>',
            mode   = 'n'
        }
    },
    {
        keys = {
            l = {
                f = {vsc_editor_action('formatSelection'), 'Format Document'},
            }
        },
        opts = {
            prefix = '<leader>',
            mode = 'v'
        }
    }
}
return key_defs


