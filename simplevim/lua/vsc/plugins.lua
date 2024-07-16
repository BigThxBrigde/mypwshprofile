return {
    {
        "folke/which-key.nvim",
        dependencies = {
            "echasnovski/mini.icons",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require('vim_keys').setup()
        end
    },
}
