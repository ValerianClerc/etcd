# ETCD Lua

credit for starting code goes to https://github.com/anibali/etcd.lua

to run: 
```bash
lua client.lua http://example.com:portnum /path/to/watch 1
```
(where 1 is the number of seconds between each ping)

note: don't include the `/v2/keys` in your `/path/to/watch` (it is implied)
