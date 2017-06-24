package main

import (
	"fmt"
	"github.com/kardianos/osext"
	"github.com/mkideal/cli"
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

// Server is an application server
type Server struct {
	docRoot string
}

func (s Server) probeDocRoot() string {
	serverRoot, err := osext.ExecutableFolder()
	if err != nil {
		log.Fatal(err)
	}

	if appRoot == true {
		s.docRoot = serverRoot
		if docPath != "" {
			s.docRoot += docPath
		}
	} else {
		if docPath != "" {
			s.docRoot = docPath
		} else {
			switch runtime.GOOS {
			case "darwin":
				s.docRoot = "/"
			case "windows":
				s.docRoot = "c:\\"
			default:
				s.docRoot = "/"
			}
		}
	}
	return s.docRoot
}

func (s Server) initialize() {
	s.probeDocRoot()
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

	timestamp := time.Now()
	fmt.Println("Server settings \n  Root \t", s.docRoot, "\n  URL \t", ws.url, "\n  Time \t", timestamp.Format(time.RFC1123), "\n")
	http.Handle("/", http.FileServer(http.Dir(s.docRoot)))
	http.ListenAndServe(httpAddr, nil)
}

var (
	version     = "1.0.0"
	docPath     = ""
	hostIP      = "127.0.0.1"
	portNum     = 8080
	appRoot     = false
	openBrowser = true
)

type argT struct {
	cli.Helper
	Port    int    `cli:"p,port" usage:"set custom port number" dft:"8080"`
	Host    string `cli:"u,host" usage:"set host IP or server address" dft:"127.0.0.1"`
	DocPath string `cli:"d,docpath" usage:"set document directory's path" dft:""`
	Browser bool   `cli:"b,browser" usage:"open browser on server start" dft:"true"`
	AppRoot bool   `cli:"a,approot" usage:"serve from application's root" dft:"false"`
}

func main() {
	fmt.Printf("\nSuxm webserver (Version %s) \nCopyright (c) 2017 Abhishek Kumar. All rights reserved. \n\n", version)

	mode := false
	cli.Run(new(argT), func(ctx *cli.Context) error {
		argv := ctx.Argv().(*argT)
		docPath = argv.DocPath
		hostIP = argv.Host
		portNum = argv.Port
		openBrowser = argv.Browser
		appRoot = argv.AppRoot
		mode = true
		return nil
	})

	if mode {
		server := Server{}
		server.initialize()
	}

	fmt.Println("\nDone!\n")
}
