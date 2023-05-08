
local root         = os.getenv('PSDOCHOME') .. '/simplevim'
local datapath     = root .. '/data'
local lazypath     = datapath .. '/lazy/lazy.nvim'
local configpath   = root .. '/config'
local projectspath = root .. '/projects'
local statepath    = root .. '/state'

return {
    root         = root,
    datapath     = datapath,
    lazypath     = lazypath,
    configpath   = configpath,
    projectspath = projectspath,
    statepath    = statepath
}
