if not arg[1] or not arg[2] then
    print("Command usage: lua client.lua http://example.com:portnum /path/to/watch")
    os.exit(1)
end

local timeout = arg[3] or 1

local etcd = require('./etcd').new(arg[1])

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

while 1 do
    local res = etcd:keys_get(arg[2])
    if res == nil or not res["node"] then
        os.exit(1)
    end
    print(res["node"]["value"])
    sleep(timeout)
end


