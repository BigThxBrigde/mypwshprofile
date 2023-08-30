local module = {}

function module:init_pkg_path()
    self.default_root  = (
        os.getenv('LOCALAPPDATA')
        and (os.getenv('LOCALAPPDATA') .. '/nvim')
        or (os.getenv('HOME') .. '/.config/nvim')
    )

    -- setup common path
    self.comm_pkg_path = self.default_root .. '/common/?.lua'
    package.path       = package.path .. ';' .. self.comm_pkg_path
end

module:init_pkg_path()

return module
