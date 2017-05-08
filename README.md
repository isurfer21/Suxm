# Suxm

*Copyright (c) 2017 Abhishek Kumar. All rights reserved.*


A micro web-server meant to serve locally and is very fast web-server that will make use of full capacity of your system. 

### Download
	
- [Suxm\_linux\_x86-64.tar.bz2](https://app.box.com/s/zoeet80oebvzrth4wh38iibdulegvlrb)
- [Suxm\_macos\_x86-64.tgz](https://app.box.com/s/aznzq3g4hu26ayw9u0vhay1kmus52yvb)		
- [Suxm\_windows\_x86-64.zip](https://app.box.com/s/e5mf5ujome2ilis25s3hxqs6e0t2rmac)

### Installation

##### On Windows

1. Unzip the `Suxm_windows_x86-64.zip` inside `C:\Programs\Suxm_windows_x86-64\`.
2. Open File Explorer and go to `Control Panel\System and Security\System`, where you will see the basic information about your computer.
3. Click on the **Advance system settings** link provided in sidebar at left, to open *System Properties*.
4. Click on **Environment Variables...** button in *Advanced* tab of *System Properties* window. 
5. Click on **PATH** in System variables section to edit it.
6. Add the absolute path of Suxm like `C:\Programs\Suxm_windows_x86-64\bin` at the end. Suxm path should be separated by semicolon from other existing paths.
7. Click on *OK* button to close all the popup windows one-by-one.

##### On MacOS / Linux

1. Unzip the `Suxm_macos_x86-64.zip` for Mac OS while  `Suxm_linux_x86-64.zip` for Linux; inside `/Users/username/Applications/Suxm/`.
2. There are 2 executables, for 32 bit & 64 bit OS. So you need to keep the executable that is compatible to your system and remove the other one.
3. Now rename the executable that you have kept by shorten it's name to **Suxm**. It will help you when you'll call it via terminal.
4. Open the **Terminal** program (this is in your Applications/Utilites folder by default). Run this command, `touch ~/.bash_profile; open ~/.bash_profile`, it will open the file in the your default text editor.
5. Add this line in the .bash_profile, `export PATH="$PATH:/Users/username/Applications/Suxm/bin/"`
6. Save the file and quit the text editor. Execute your .bash_profile to update your PATH using `source ~/.bash_profile`

### Usage

```
$ ./Suxm -help

Suxm webserver (Version 0.0.1) 
Copyright (c) 2017 Abhishek Kumar. All rights reserved. 

Usage of ./Suxm:
  -browser
    	Open browser (default true)
  -dir string
    	Directory root
  -host string
    	Host IP or address (default "127.0.0.1")
  -port int
    	Port number (default 8080)
  -svr
    	Use server root
```

##### Serving from server-root

When your *webapp* directory is inside **Suxm** directory or alongside it's executable application.

```
$ ./Suxm -svr=true -dir=/webapp -port=9000

Suxm webserver (Version 0.0.1) 
Copyright (c) 2017 Abhishek Kumar. All rights reserved. 

Server settings 
  Root    /Users/abhishekkumar/Applications/Suxm/webapp
  URL     http://127.0.0.1:9000 

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Serving from directory-root

When your *webapp* directory is placed somewhere else on your system. 

```
$ ./Suxm -dir=/Users/abhishekkumar/Documents/webapp/ -port=9000

Suxm webserver (Version 0.0.1) 
Copyright (c) 2017 Abhishek Kumar. All rights reserved. 

Server settings 
  Root    /Users/abhishekkumar/Documents/webapp/ 
  URL     http://127.0.0.1:9000 

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Other commands

To specifiy custom host IP or address

```
$ ./Suxm -dir=/Users/abhishekkumar/webapp/ -host=192.168.0.1 -port=9000
```

To stop, automatic opening of browser on server start

```
$ ./Suxm -browser=false -dir=/Users/abhishekkumar/webapp/ -port=9000
```
