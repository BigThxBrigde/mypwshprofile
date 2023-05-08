return {{
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('lualine').setup {
            options = {
                component_separators = {
                    -- left = '|',
                    -- right = '|'
                },
                section_separators = {
                    -- left = '',
                    -- right = ''
                },
                theme = 'catppuccin'
            }
        }
    end

}, {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup {
            options = {
                -- buffer_close_icon = ''
            }
        }
    end
}, -- { 'mhinz/vim-startify' },
{
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            -- config
            config = {
                header = require('banner')
            }
        }
    end,
    dependencies = {{'nvim-tree/nvim-web-devicons'}}
}, {'tpope/vim-surround'}, {
    'justinmk/vim-sneak',
    keys = {{'f', '<Plug>Sneak_s'}, {'F', '<Plug>Sneak_S'}, {'t', '<Plug>Sneak_t'}, {'T', '<Plug>Sneak_T'}},
    config = function()
        vim.cmd([[
         highlight Sneak guifg=red guibg=NONE ctermfg=red ctermbg=NONE
         highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
        ]])
    end
}, {'jiangmiao/auto-pairs'}, {'gcmt/wildfire.vim'}, -- { "junegunn/fzf" },
-- { 
--   "junegunn/fzf.vim",
--   keys = {
--     { "<leader>ff", "<cmd>Files<cr>", desc = "Find files" },
--     { "<leader>fb", "<cmd>Buffers<cr>", desc = "Find buffers" },
--   },
-- },
{
    "nvim-neo-tree/neo-tree.nvim",
    keys = {{
        "<leader>ft",
        "<cmd>Neotree toggle<cr>",
        desc = "NeoTree"
    }},
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended 
    "MunifTanjim/nui.nvim"},
    config = function()
        require("neo-tree").setup()
    end
}, -- the colorscheme should be available when starting Neovim
{
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        -- vim.cmd([[colorscheme tokyonight]])
    end
}, {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme catppuccin-macchiato]])
    end
}, -- I have a separate config.mappings file where I require which-key.
-- With lazy the plugin will be automatically loaded when it is required somewhere
{
    "folke/which-key.nvim",
    lazy = true
}, {
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
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer"},
    config = function()
        -- ...
    end
}, -- you can use the VeryLazy event for things that can
-- load later and are not important for the initial UI
{
    "stevearc/dressing.nvim",
    event = "VeryLazy"
} -- {
--   "Wansmer/treesj",
--   keys = {
--     { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
--   },
--   opts = { use_default_keymaps = false, max_join_length = 150 },
-- },
-- {
--   "monaqa/dial.nvim",
--   -- lazy-load on keys
--   -- mode is `n` by default. For more advanced options, check the section on key mappings
--   keys = { "<C-a>", { "<C-x>", mode = "n" } },
-- },
-- local plugins can also be configure with the dev option.
-- This will use {config.dev.path}/noice.nvim/ instead of fetching it from Github
-- With the dev option, you can easily switch between the local and installed version of a plugin
-- { "folke/noice.nvim", dev = true },
-- airline
-- { "vim-avim-airline/vim-airline" },
-- { "vim-airline/vim-airline-themes" },
-- { 
--    "itchyny/lightline.vim",
--     config = function()
--       --
--       -- vim.cmd([[ let g:lightline = { 'colorscheme' : 'one' } ]])
--     end,
-- },
}

