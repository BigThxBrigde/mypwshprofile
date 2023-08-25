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

local pload

if vim.g.vscode then
    pload = pload_factory('vsc')
else
    pload = pload_factory()
end

rawset(_G, 'pload', pload)
