local get_os_name   = require('misc').get_os_name
local _root         = os.getenv('SIMPLEVIM')
local _datapath     = _root .. '/data'
local _osname, _    = get_os_name()

-- print(_osname)

return {
    root         = _root,
    datapath     = _datapath,
    lazypath     = _datapath .. '/lazy/lazy.nvim',
    configpath   = _root .. '/config',
    projectspath = _root .. '/projects',
    statepath    = _root .. '/state',
    osname       = _osname,
    iswindows    = _osname == 'Windows'
}
