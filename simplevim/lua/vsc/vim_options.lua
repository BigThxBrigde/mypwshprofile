local M = {}

function M.setup()
    vim.o.clipboard      = is_windows and 'unnamed' or 'unnamedplus'
    vim.o.number         = true
    vim.o.relativenumber = true
    vim.o.tabstop        = 4
    vim.o.expandtab      = true
    vim.o.shiftwidth     = 4
    vim.o.smarttab       = true
    vim.o.cursorline     = true

    vim.cmd(
    [[
      let g:loaded_perl_provider = 0
      let g:loaded_ruby_provider = 0
    ]])
end

return M
