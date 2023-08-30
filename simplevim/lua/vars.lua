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

--
-- Initialize a safe require wrapper according to
-- vscode environment or not refer to `vim.g.vscode`
--
function module:init_pload()
    --
    -- A factory to create a function safe
    -- loading the lua module
    --
    local function pload_factory(prefix)
        return function(name)
            if not prefix then
                return require(name)
            end
            local n = string.format("%s.%s", prefix, name)

            local r, m = pcall(require, n)
            if r then return m end
            return require(name)
        end
    end

    local pload = (
        vim.g.vscode
        and pload_factory('vsc')
        or pload_factory()
    )

    rawset(_G, 'pload', pload)
end

function module.init(self)
    -- init package path, include common folder
    self:init_pkg_path()
    local get_os_name = require('util').get_os_name
    local os_name, _  = get_os_name()

    self.root         = os.getenv('SIMPLEVIM') or self.default_root
    self.os_name      = os_name
    self.is_windows   = self.os_name == 'Windows'
    self.datapath     = self.root .. '/data'
    self.lazypath     = self.datapath .. '/lazy/lazy.nvim'
    self.configpath   = self.root .. '/config'
    self.projectspath = self.root .. '/projects'
    self.statepath    = self.root .. '/state'


    self:init_pload()
end

module:init()

return module
