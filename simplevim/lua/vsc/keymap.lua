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

local norm_keys =
{
    { "<leader>l",  group = "Language Server" },
    { "<leader>lf", call_vsc_editor_action('formatDocument'), desc = "Format Document" },
    { "<leader>f",  group = "Files" },
    { "<leader>fn", '<cmd>nohlsearch<cr>',                    desc = 'No highlight search' },
    { "<leader>fs", '<cmd>w!<cr>',                            desc = 'Save current file' },
    { "<leader>fS", '<cmd>wa!<cr>',                           desc = 'Save all files' },
    { "<leader>fw", '<cmd>%s/\\s\\+$//e<cr>',                 desc = 'Trim Trailing Whitespace' },

}

local visual_keys =
{
    mode = { "v" },
    { "<leader>l",  group = "Language Server" },
    { "<leader>lf", call_vsc_editor_action('formatSelection'), desc = "Format Selection" },
}

local norm_visual_keys =
{
    mode = { 'v', 'n' },
    { "<leader>lV", notify_vsc_editor_action('revealDefinitionAside'), desc = 'Goto Definition Aside' },
    { "<leader>ld", notify_vsc_editor_action('revealDefinition'),      desc = 'Goto Definition' },
    { "<leader>lD", notify_vsc_editor_action('revealDeclaration'),     desc = 'Goto Declaration' },
    { "<leader>lv", notify_vsc_editor_action('showHover'),             desc = 'View Document' },

}


local key_defs = {
    norm_keys,
    visual_keys,
    norm_visual_keys
}

return key_defs
