return {
    setup = function()
        local cmp          = require('cmp')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local lspconfig    = require('lspconfig')
        local capabilities = cmp_nvim_lsp.default_capabilities()

        cmp.setup{
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer',
                    option = {
                        keyword_pattern = [[\k\+]],
                    },
                },
            }
        }

        -- The following example advertise capabilities to `clangd`.
        lspconfig.clangd.setup {
          capabilities = capabilities,
        }
    end
}
