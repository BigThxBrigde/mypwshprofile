local vsc_nvim   = require('vscode-neovim')
local vsc_call   = vsc_nvim.call
local vsc_notify = vsc_nvim.notify
--
-- Execute vscode editor action
-- vscode editor.action.action_id
--
local function call_vsc_editor_action(action_id, ...)
    local vararg = { ... }
    return function()
        local fmt = 'editor.action.%s'
        vsc_call(fmt:format(action_id), vararg)
    end
end
local function notify_vsc_editor_action(action_id, ...)
    local vararg = { ... }
    return function()
        local fmt = 'editor.action.%s'
        vsc_notify(fmt:format(action_id), vararg)
    end
end


local key_defs = {
    {
        keys = {
            l = {
                f = { call_vsc_editor_action('formatDocument'), 'Format Document' },
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
                f = { call_vsc_editor_action('formatSelection'), 'Format Selection' },
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
                V = { notify_vsc_editor_action('revealDefinitionAside'), 'Goto Definition Aside' },
                d = { notify_vsc_editor_action('revealDefinition'), 'Goto Definition' },
                D = { notify_vsc_editor_action('revealDeclaration'), 'Goto Declaration' },
                v = { notify_vsc_editor_action('showHover'), 'View Document' }
            }
        },
        opts = {
            prefix = '<leader>',
            mode = { 'v', 'n' }
        }
    }
}

return key_defs
