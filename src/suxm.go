package main

import (
	"flag"
	"fmt"
	"github.com/kardianos/osext"
	"log"
	"net/http"
	"os/exec"
	"runtime"
	"strconv"
	"time"
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

var (
	dirRoot, hostIP          string
	portNum                  int
	useSrvrRoot, openBrowser bool
)

func main() {
	fmt.Println("\nSuxm webserver (Version 0.0.1) \nCopyright (c) 2017 Abhishek Kumar. All rights reserved. \n")

	srvrRoot, err := osext.ExecutableFolder()
	if err != nil {
		log.Fatal(err)
	}

	flag.BoolVar(&useSrvrRoot, "svr", false, "Use server root")
	flag.StringVar(&dirRoot, "dir", "", "Directory root")
	flag.StringVar(&hostIP, "host", "127.0.0.1", "Host IP or address")
	flag.IntVar(&portNum, "port", 8080, "Port number")
	flag.BoolVar(&openBrowser, "browser", true, "Open browser")

	flag.Parse()

	var appDir string
	if useSrvrRoot == true {
		appDir = srvrRoot
		if dirRoot != "" {
			appDir += dirRoot
		}
	} else {
		if dirRoot != "" {
			appDir = dirRoot
		} else {
			switch runtime.GOOS {
			case "darwin":
				appDir = "/"
			case "windows":
				appDir = "c:\\"
			default:
				appDir = "/"
			}
		}
	}

	httpAddr := hostIP + ":" + strconv.Itoa(portNum)

	ws := WebService{}
	ws.url = "http://" + httpAddr

	go func() {
		fmt.Println("Server status: STARTED")
		if ws.waitServer() && openBrowser && ws.startBrowser() {
			fmt.Println("A browser window should open. If not, visit the link.")
		} else {
			fmt.Println("Please open your web browser and visit the link.")
		}
		fmt.Println("Please hit 'ctrl + C' to STOP the server.")
	}()

	fmt.Println("Server settings \n  Root   ", appDir, "\n  URL    ", ws.url, "\n")
	http.Handle("/", http.FileServer(http.Dir(appDir)))
	http.ListenAndServe(httpAddr, nil)
}
