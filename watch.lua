if not arg[1] or not arg[2] then
    print("Command usage: lua watch.lua http://example.com:portnum /path/to/watch")
    os.exit(1)
end

local etcd = require('./etcd').new(arg[1])

local inspect = require('inspect')

while 1 do
    local res = etcd:keys_watch(arg[2])

    if res['action'] == 'set' then
        os.execute("bash /usr/sbin/sc_unlock")
    elseif res['action'] == 'expire' then
        os.execute("bash /usr/sbin/sc_lock")
    end
    -- print(res['action'])
end
