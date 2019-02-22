print(arg[2])
if not arg[1] or not arg[2] then
    print("Command usage: lua client.lua http://example.com:portnum /path/to/watch")
    os.exit(1)
end

local etcd = require('./etcd').new(arg[1])
local inspect = require('inspect')

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

while 1 do
    print(arg[2])
    local res = etcd:keys_get(arg[2])
    print(inspect(res))
    if res == nil then
        os.exit(1)
    end
    sleep(1)
end


