local float_term = require('lazy.util').float_term
local keymap     = vim.keymap.set


local show_lazygit = function()
    float_term({'pwsh', '--nologo',  '-c',  'lg' })
end 

local show_term_pwsh = function()
    float_term({'pwsh', '--nologo'})
end

local show_term_cmd = function()
    float_term({'cmd'})
end

return {
    setup =  function()
        vim.o.guifont        = 'agave NFM r:h12'
        vim.o.clipboard      = 'unnamed'
        vim.o.number         = true
        vim.o.relativenumber = true
        vim.o.tabstop        = 4
        vim.o.shiftwidth     = 4
        vim.o.smarttab       = true
        vim.o.cursorline     = true
        vim.o.completeopt    = 'menu,menuone,noselect'
        vim.o.expandtab      = true
        vim.o.ignorecase     = true
        vim.o.smartcase      = true
        vim.o.smartindent    = true
        vim.o.termguicolors  = true
        vim.o.wildmode       = 'longest:full,full'
        vim.o.wrap           = false
            
        if vim.g.neovide then
            -- Put anything you want to happen only in Neovide here
          vim.g.neovide_fullscreen       = false
          vim.g.neovide_transparency     = 0.9
          vim.g.neovide_floating_opacity = 0.9
        else 
          vim.cmd([[   
              autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
          ]])
        end

        -- 
        -- https://superuser.com/questions/945329/how-to-disable-the-leader-key-in-vim-insert-mode 
        -- :verbose imap <leader>
        --
        keymap('n', '<leader>lg', show_lazygit)
        keymap('n', '<leader>tp', show_term_pwsh)
        keymap('n', '<leader>tc', show_term_cmd)
        keymap('v', '<leader>xa', '<Plug>(EasyAlign)')
        keymap('n', '<leader>ff', '<cmd>Files<cr>')
        keymap('n', '<leader>fb', '<cmd>Buffers<cr>')
        keymap('n', '<leader>d', '<cmd>Dashboard<cr>')
        keymap('n', '<leader>bc', '<cmd>bd!<cr>')
        keymap('n', '<leader>pq', '<cmd>qa!<cr>')
        keymap('n', '<leader>ps', '<cmd>wa!<cr>')

    end
}

