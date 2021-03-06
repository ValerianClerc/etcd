package main

// source:  https://github.com/etcd-io/etcd/tree/master/client

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"

	"go.etcd.io/etcd/client"
)

func main() {
	hostName := os.Args[1]
	path := os.Args[2]
	cfg := client.Config{
		Endpoints: []string{hostName},
		Transport: client.DefaultTransport,
		// set timeout per request to fail fast when the target endpoint is unavailable
		HeaderTimeoutPerRequest: time.Second,
	}
	c, err := client.New(cfg)
	if err != nil {
		log.Fatal(err)
	}
	kapi := client.NewKeysAPI(c)

	fmt.Println("Watching key at: ", hostName, path)

	for true {
		resp, err := kapi.Watcher(path, nil).Next(context.Background())

		// log.Printf("Result: %q\n", resp.Action)

		if err != nil {
			log.Fatal(err)
		} else if resp.Action == "set" {
			cmd, err := exec.Command("/bin/bash", "/usr/sbin/sc_lock").Output()
			// cmdOut, err := cmd.Output()
			if err != nil {
				panic(err)
			}
			fmt.Println(string(cmd))
		} else if resp.Action == "expire" {
			cmd, err := exec.Command("/bin/bash", "/usr/sbin/sc_unlock").Output()
			// cmdOut, err := cmd.Output()
			if err != nil {
				panic(err)
			}
			fmt.Println(string(cmd))
		}
	}
}
