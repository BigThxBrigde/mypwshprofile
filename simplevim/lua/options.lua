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

    end
}

