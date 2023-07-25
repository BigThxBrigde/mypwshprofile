return {
    setup = function()
        local cmp          = require('cmp')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local lspconfig    = require('lspconfig')
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- languge sever to install
        --
        -- c,cpp         clangd
        -- py            pylsp
        -- go            gopls
        -- js, ts        typescript-language-server
        -- rs            rust-analyzer
        -- lua           lua_ls

        local servers = {
            'clangd',
            'pylsp',
            'gopls',
            'tsserver',
            'rust_analyzer',
            'lua_ls'
        }

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
        for _, srv in ipairs(servers) do
            if srv == 'lua_ls' then
                lspconfig[srv].setup {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT'
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {'vim'}
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true)
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false
                            }
                        }
                    }
                }
            else
                lspconfig[srv].setup {
                    capabilities = capabilities
                }
            end
        end

    end
}
