local root         = os.getenv('PSDOCHOME') .. '/simplevim'
local datapath     = root .. '/data'
local lazypath     = datapath .. '/lazy/lazy.nvim'
local configpath   = root .. '/config'
local projectspath = root .. '/projects'
local statepath    = root .. '/state'

if not vim.loop.fs_stat(lazypath) then

  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath
  })

end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.lightline = {
  colorscheme = 'one'
}

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

vim.cmd([[
    let g:startify_custom_header = [
      \ '                                                                       ',
      \ '   ▄       ▄▄▄▄    ▄▄   ▄▄▄▄   ▄▄▄▄▄  ▄▄   ▄   ▄▄▄                     ',
      \ '   █      ▄▀  ▀▄   ██   █   ▀▄   █    █▀▄  █ ▄▀   ▀                    ',
      \ '   █      █    █  █  █  █    █   █    █ █▄ █ █   ▄▄                    ',
      \ '   █      █    █  █▄▄█  █    █   █    █  █ █ █    █                    ',
      \ '   █▄▄▄▄▄  █▄▄█  █    █ █▄▄▄▀  ▄▄█▄▄  █   ██  ▀▄▄▄▀   █      █      █  ',
      \ '                                                                       ',
      \ ] 
]])

require('lazy').setup(
{
  { 'mhinz/vim-startify' },
  {
    'tpope/vim-surround'
  },
  {
    'justinmk/vim-sneak',
    keys = {
      { 'f', '<Plug>Sneak_s'},
      { 'F', '<Plug>Sneak_S'},
      { 't', '<Plug>Sneak_t'},
      { 'T', '<Plug>Sneak_T'}
    },
    config = function()
        vim.cmd([[
         highlight Sneak guifg=red guibg=NONE ctermfg=red ctermbg=NONE
         highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
        ]])
    end
  },
  {
    'jiangmiao/auto-pairs',
  },
  { 
    'gcmt/wildfire.vim',
  },
  { "junegunn/fzf" },
  { 
	"junegunn/fzf.vim",
	keys = {
      { "<leader>ff", "<cmd>Files<cr>", desc = "Find files" },
      { "<leader>fb", "<cmd>Buffers<cr>", desc = "Find buffers" },
	},

  },
  {
    "nvim-neo-tree/neo-tree.nvim",
      keys = {
        { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
      },
      dependencies = {
        "nvim-lua/plenary.nvim", 
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended 
        "MunifTanjim/nui.nvim"        
      },
      config = function()
        require("neo-tree").setup()
      end,
  },
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
  { 
      "catppuccin/nvim", 
      name = "catppuccin",
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme catppuccin-macchiato]])
      end,
  },
  -- I have a separate config.mappings file where I require which-key.
  -- With lazy the plugin will be automatically loaded when it is required somewhere
  { "folke/which-key.nvim", lazy = true },


  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      -- ...
    end,
  },


  -- you can use the VeryLazy event for things that can
  -- load later and are not important for the initial UI
  { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- {
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
  { "folke/noice.nvim", dev = true },
    
   -- airline
   -- { "vim-avim-airline/vim-airline" },
   -- { "vim-airline/vim-airline-themes" },
    
   { 
       "itchyny/lightline.vim",
   --     config = function()
   --       --
   --       -- vim.cmd([[ let g:lightline = { 'colorscheme' : 'one' } ]])
   --     end,
   },
},
  
{
  root = datapath .. "/lazy", -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
    version = nil,
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  -- leave nil when passing the spec as the first argument to setup()
  spec = nil, ---@type LazySpec
  lockfile = configpath .. "/lazy-lock.json", -- lockfile generated after running update.
  concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "https://github.com/%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  dev = {
    -- directory where you store your local plugin projects
    path = projectspath,
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "catppuccin-macchiato" },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {
      -- you can define custom key maps here.
      -- To disable one of the defaults, set it to false

      -- open lazygit log
      ["<localleader>l"] = function(plugin)
        require("lazy.util").float_term({ "lazygit", "log" }, {
          cwd = plugin.dir,
        })
      end,

      -- open a terminal for the plugin dir
      ["<localleader>t"] = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = statepath .. "/lazy/readme",
    files = { "README.md", "lua/**/README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = statepath .. "/lazy/state.json", -- state info for checker and other things
})
