
--
-- Execute vscode editor action
-- vscode editor.action.action_id
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
    },
    {

        keys = {
            l = {
                V = {vsc_editor_action('revealDefinitionAside'), 'Goto Definition Aside'},
                d = {vsc_editor_action('revealDefinition'), 'Goto Definition'},
                D = {vsc_editor_action('revealDeclaration'), 'Goto Declaration'},
                v = {vsc_editor_action('showHover'), 'View Document'}
            }
        },
        opts = {
            prefix = '<leader>',
            mode =  {'v', 'n'}
        }
    }
}
return key_defs


