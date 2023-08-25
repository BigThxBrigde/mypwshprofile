require('pload')

local get_os_name = require('misc').get_os_name
local osname, _   = get_os_name()
local default_root

if osname == 'Windows' then
    default_root = os.getenv('LOCALAPPDATA') .. '/nvim'
else
    default_root = os.getenv('HOME') .. '/.config/nvim'
end

local root     = os.getenv('SIMPLEVIM') or default_root
local datapath = root .. '/data'

-- print(_osname)

return {
    root         = root,
    datapath     = datapath,
    lazypath     = datapath .. '/lazy/lazy.nvim',
    configpath   = root .. '/config',
    projectspath = root .. '/projects',
    statepath    = root .. '/state',
    os_name      = osname,
    is_windows   = osname == 'Windows'
}
