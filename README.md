# ETCD Clients

Credit for starting code goes to `https://github.com/anibali/etcd.lua` and `https://github.com/etcd-io/etcd/tree/master/client`

## Go

### Watch key

```bash
go build client.go
```
```bash
./client http://example.com:portnum /path/to/watch
```

## Lua

### Watch Key

to run:

```bash
lua watch.lua http://example.com:portnum /path/to/watch
```

replace `os.execute()` with anything that you want to run upon change

### GET Loop

to run:

```bash
lua client.lua http://example.com:portnum /path/to/watch 1
```

(where 1 is the number of seconds between each ping)

note: don't include the `/v2/keys` in your `/path/to/watch` (it is implied)
