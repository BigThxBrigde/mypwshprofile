local M = {}

local function num2bs(num)
    local _mod = math.fmod
    local _floor = math.floor
    --
    local index, result = 1, ""
    if (num == 0) then
        return "0"
    end
    while (num > 0) do
        result = _mod(num, 2) .. result
        num = _floor(num * 0.5)
    end
    return result
end

local function bs2num(num)
    local _sub = string.sub
    local index, result = 0, 0
    if (num == "0") then
        return 0;
    end
    for p = #num, 1, -1 do
        local this_val = _sub(num, p, p)
        if this_val == "1" then
            result = result + (2 ^ index)
        end
        index = index + 1
    end
    return result
end

local function padbits(num, bits)
    if #num == bits then
        return num
    end
    if #num > bits then
        print("too many bits")
    end
    local pad = bits - #num
    for i = 1, pad do
        num = "0" .. num
    end
    return num
end

function M.get_uuid()
    local _rnd = math.random
    local _sub = string.sub
    local _fmt = string.format
    --
    local time_low = os.time()
    math.randomseed(time_low)
    --
    local time_mid = _rnd(0, 65535)
    --
    local time_hi = _rnd(0, 65535)
    time_hi = padbits(num2bs(time_hi), 16)
    time_hi = _sub(time_hi, 1, 12)
    local time_hi_and_version = bs2num(time_hi .. "0100")
    --
    local clock_seq_hi_res = _rnd(0, 255)
    clock_seq_hi_res = padbits(num2bs(clock_seq_hi_res), 8)
    clock_seq_hi_res = _sub(clock_seq_hi_res, 1, 6) .. "01"
    --
    local clock_seq_low = _rnd(0, 255)
    clock_seq_low = padbits(num2bs(clock_seq_low), 8)
    --
    local clock_seq = bs2num(clock_seq_hi_res .. clock_seq_low)
    --
    local node = {}
    node[1] = (128 + _rnd(0, 127))
    for i = 2, 6 do
        node[i] = _rnd(0, 255)
    end
    --
    local guid = ""
    guid = guid .. padbits(_fmt("%X", time_low), 8) .. "-"
    guid = guid .. padbits(_fmt("%X", time_mid), 4) .. "-"
    guid = guid .. padbits(_fmt("%X", time_hi_and_version), 4) .. "-"
    guid = guid .. padbits(_fmt("%X", clock_seq), 4) .. "-"
    --
    for i = 1, 6 do
        guid = guid .. padbits(_fmt("%X", node[i]), 2)
    end
    --
    return guid
end

--
-- Method for defined class
-- Example like
--
--     ```lua
--     local define_class = require('util').define_class
--
--     -- Define class Shape
--
--     local Shape = define_class('Animal')
--     function Shape:get_area()
--     end
--
--     -- Define a rectangle
--     local Rectangle = define_class('Rectangle', Shape)
--     function Rectangle:constructor(width, height)
--         self.width  = width
--         self.height = height
--     end
--     function Rectangle:get_area()
--         return self.width * self.height
--     end
--
--     -- Define a circle
--     local Circle = define_class('Circle', Shape)
--     Circle.PI = 3.14
--
--     function Circle:constructor(radius)
--         self.radius = radius
--     end
--     function Circle:get_area()
--         return Circle.PI * radius * radius
--     end
--
--     -- Logic code here
--     local rect = Rectangle.new(3.0, 4.0)
--     print(rect:get_area())
--
--     local circle = Circle.new(2.0)
--     print(circle:get_area())
--
--     ```
--

function M.define_class(class_name, super)
    local class = {
        __cname = class_name,
        super   = super
    }
    if super then
        setmetatable(class,
            {
                __index = super
            })
    end

    -- class constructor
    class.new = function(...)
        local instance = {}
        setmetatable(instance,
            {
                __index = class
            })
        if class.constructor then
            class.constructor(instance, ...)
        end
        return instance
    end

    return class
end

function M.table_merge(x, y)
    for k, v in pairs(y) do
        x[k] = v
    end
end

function M.file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

-- Return two strings describing the OS name and OS architecture.
-- For Windows, the OS identification is based on environment variables
-- On unix, a call to uname is used.
--
-- OS possible values: Windows, Linux, Mac, BSD, Solaris
-- Arch possible values: x86, x86864, powerpc, arm, mips
--
-- On Windows, detection based on environment variable is limited
-- to what Windows is willing to tell through environement variables. In particular
-- 64bits is not always indicated so do not rely hardly on this value.
function M.get_os_name()
    local raw_os_name, raw_arch_name = '', ''

    -- LuaJIT shortcut
    if jit and jit.os and jit.arch then
        raw_os_name = jit.os
        raw_arch_name = jit.arch
        -- print( ("Debug jit name: %q %q"):format( raw_os_name, raw_arch_name ) )
    else
        if package.config:sub(1, 1) == '\\' then
            -- Windows
            local env_OS = os.getenv('OS')
            local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')
            -- print( ("Debug: %q %q"):format( env_OS, env_ARCH ) )
            if env_OS and env_ARCH then
                raw_os_name, raw_arch_name = env_OS, env_ARCH
            end
        else
            -- other platform, assume uname support and popen support
            raw_os_name = io.popen('uname -s', 'r'):read('*l')
            raw_arch_name = io.popen('uname -m', 'r'):read('*l')
        end
    end

    raw_os_name = (raw_os_name):lower()
    raw_arch_name = (raw_arch_name):lower()

    -- print( ("Debug: %q %q"):format( raw_os_name, raw_arch_name) )

    local os_patterns = {
        ['windows'] = 'Windows',
        ['linux']   = 'Linux',
        ['osx']     = 'Mac',
        ['mac']     = 'Mac',
        ['darwin']  = 'Mac',
        ['^mingw']  = 'Windows',
        ['^cygwin'] = 'Windows',
        ['bsd$']    = 'BSD',
        ['sunos']   = 'Solaris',
    }

    local arch_patterns = {
        ['^x86$']           = 'x86',
        ['i[%d]86']         = 'x86',
        ['amd64']           = 'x86_64',
        ['x86_64']          = 'x86_64',
        ['x64']             = 'x86_64',
        ['power macintosh'] = 'powerpc',
        ['^arm']            = 'arm',
        ['^mips']           = 'mips',
        ['i86pc']           = 'x86',
    }

    local os_name, arch_name = 'unknown', 'unknown'

    for pattern, name in pairs(os_patterns) do
        if raw_os_name:match(pattern) then
            os_name = name
            break
        end
    end
    for pattern, name in pairs(arch_patterns) do
        if raw_arch_name:match(pattern) then
            arch_name = name
            break
        end
    end
    return os_name, arch_name
end

return M
