if not arg[1] or not arg[2] then
    print("Command usage: lua client.lua http://example.com:portnum /path/to/watch")
    os.exit(1)
end

local timeout = arg[3] or 1

local etcd = require('./etcd').new(arg[1])

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

local currState = false

local res = etcd:keys_get(arg[2])

if res == nil then
    print("Invalid request")
    os.exit(1)
end

while 1 do
    if not res["node"] and currState == true then
        -- print("false")
        currState = false
        os.execute("bash /usr/sbin/sc_lock")
    elseif res["node"] and res["node"]["value"] == "true" and currState == false then
        currState = true
        os.execute("bash /usr/sbin/sc_unlock")
        -- print(res["node"]["value"])
    else
        -- print("no change")
    end

    sleep(timeout)

    res = etcd:keys_get(arg[2])
end


