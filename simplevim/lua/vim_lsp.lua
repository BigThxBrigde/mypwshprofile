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

        local servers      = {
            'clangd',
            'pylsp',
            'gopls',
            'tsserver',
            'rust_analyzer',
            'lua_ls'
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert(
            {
                ['<C-b>']     = cmp.mapping.scroll_docs(-4),
                ['<C-f>']     = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>']     = cmp.mapping.abort(),
                ['<CR>']      = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources(
            {
                { name = 'nvim_lsp'                 },
                { name = 'luasnip'                  },
                { name = 'nvim_lsp_document_symbol' }
            },
            {
                { name = 'buffer' },
            }),
        })

        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources(
            {
                { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            },
            {
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
            {
                { name = 'path' }
            },
            {
                { name = 'cmdline' }
            })
        })

        local lspkind = require('lspkind')
        cmp.setup ({
            formatting = {
                format = lspkind.cmp_format({
                mode = 'symbol_text', -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function (entry, vim_item)
                    return vim_item
                end
                })
            }
        })

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
                                globals = { 'vim' }
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
