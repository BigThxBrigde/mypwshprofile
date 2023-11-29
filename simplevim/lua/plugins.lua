local plugins = {
    { 'terryma/vim-multiple-cursors' },
    { 'junegunn/vim-easy-align' },
    { 'gcmt/wildfire.vim' },
    { "junegunn/fzf" },
    { "junegunn/fzf.vim" },
    {
        'jiangmiao/auto-pairs',
        config = function()
            vim.cmd([[
                let g:AutoPairsFlyMode = 1
            ]])
        end
    },
    {
        'preservim/nerdcommenter',
        config = function()
            vim.cmd([[
               let g:NERDSpaceDelims = 1
               let g:NERDDefaultAlign = 'left'
            ]])
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        -- event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {

        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local evilline = require('evilline')
            require('lualine').setup(evilline)
        end
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            local bufferline = require('bufferline')
            bufferline.setup({
                options = {
                    separator_style = {
                        '|',
                        '|'
                    },
                    -- buffer_close_icon = '✖',
                    style_preset = {
                        bufferline.style_preset.no_italic -- bufferline.style_preset.no_bold
                    },
                    indicator = {
                        icon = '', -- this should be omitted if indicator style is not 'icon'
                        style = 'none'
                    }
                }
            })
        end
    },
    {
        'glepnir/dashboard-nvim',
        -- event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
                config = {
                    header = require('banner')
                }
            }
        end,
        dependencies = {
            { 'nvim-tree/nvim-web-devicons' }
        }
    },
    {
        'justinmk/vim-sneak',
        config = function()
            vim.cmd([[
                 highlight Sneak guifg=red guibg=NONE ctermfg=red ctermbg=NONE
                 highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
            ]])
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    hijack_netrw_behavior = "open_default" -- netrw disabled, opening a directory opens neo-tree
                    -- in whatever position is specified in window.position
                    -- "open_current",  -- netrw disabled, opening a directory opens within the
                    -- window like netrw would, regardless of window.position
                    -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                }
            })
        end
    },
    -- the colorscheme should be available when starting Neovim
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end
    }, -- I have a separate config.mappings file where I require which-key.
    --{
    --    "joshdick/onedark.vim",
    --    priority = 1000, -- make sure to load this before all the other start plugins
    --    config = function()
    --        -- load the colorscheme here
    --        vim.cmd([[colorscheme onedark]])
    --    end
    --}, -- I have a separate config.mappings file where I require which-key.
    -- With lazy the plugin will be automatically loaded when it is required somewhere
    {
        "folke/which-key.nvim",
        config = function()
            require('vim_keys').setup()
        end
        -- lazy = true
    },
    {
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            "hrsh7th/cmp-buffer",
            "neovim/nvim-lspconfig",
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind.nvim'
        },
        config = function()
            require('vim_lsp').setup()
        end
    }
}

return plugins
