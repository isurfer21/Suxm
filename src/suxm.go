package main

import (
	"flag"
	"fmt"
	"github.com/kardianos/osext"
	"log"
	"net"
	"net/http"
	"os/exec"
	"runtime"
	"time"
)

var (
	appDir, httpAddr string
	webDir           = flag.String("dir", "/Users/", "root directory of www")
	webSrv           = flag.String("srv", "127.0.0.1:8080", "host:port to listen on")
	openBrowser      = flag.Bool("browser", true, "open browser automatically")
)

// WebService contains browser specific commands.
type WebService struct {
	url string
}

func (w WebService) waitServer() bool {
	tries := 20
	for tries > 0 {
		resp, err := http.Get(w.url)
		if err == nil {
			resp.Body.Close()
			return true
		}
		time.Sleep(100 * time.Millisecond)
		tries--
	}
	return false
}

func (w WebService) startBrowser() bool {
	var args []string
	switch runtime.GOOS {
	case "darwin":
		args = []string{"open"}
	case "windows":
		args = []string{"cmd", "/c", "start"}
	default:
		args = []string{"xdg-open"}
	}
	cmd := exec.Command(args[0], append(args[1:], w.url)...)
	return cmd.Start() == nil
}

func main() {
	fmt.Println("\n Suxm webserver (Version 0.0.1) \n Copyright (c) 2017 Abhishek Kumar. All rights reserved. \n")

	log.Print(*webDir)
	log.Print(*webSrv)

	currDir, err := osext.ExecutableFolder()
	if err != nil {
		log.Fatal(err)
	} else {
		if *webDir == "" {
			appDir = currDir
		} else {
			appDir = *webDir
		}
	}

	host, port, err := net.SplitHostPort(*webSrv)
	if err != nil {
		log.Fatal(err)
	}
	if host == "" {
		host = "localhost"
	}

	httpAddr = host + ":" + port
	if host != "127.0.0.1" && host != "localhost" {
		fmt.Printf(" Warning: Address %s is not available. \n Please hit 'ctrl + C' to terminate this process.", httpAddr)
	}

	go func() {
		ws := WebService{}
		ws.url = "http://" + httpAddr
		if ws.waitServer() && *openBrowser && ws.startBrowser() {
			fmt.Println(" A browser window should open. If not, visit the link.")
		} else {
			fmt.Println(" Please open your web browser and visit the link.")
		}
		fmt.Printf(" Serving at %s \n", ws.url)
		fmt.Println(" Please hit 'ctrl + C' to terminate this process.")
	}()

	fmt.Printf(" Serving from %s \n", appDir)
	http.Handle("/", http.FileServer(http.Dir(appDir)))

	http.ListenAndServe(httpAddr, nil)
}
