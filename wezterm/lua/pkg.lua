local M = {}

function M.init_pkg_path(self)

    self.default_root  = (
        os.getenv('LOCALAPPDATA')
        and (os.getenv('LOCALAPPDATA') .. '/nvim')
        or (os.getenv('HOME') .. '/.config/nvim')
    )

    -- setup common path
    local comm_pkg_path = self.default_root .. '/common/?.lua'
    package.path        = package.path .. ';' .. comm_pkg_path
end

M:init_pkg_path()

return M
