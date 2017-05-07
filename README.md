# Suxm

*Copyright (c) 2017 Abhishek Kumar. All rights reserved.*


A micro web-server meant to serve locally and is very fast web-server that will make use of full capacity of your system. 

### Download
	
- [Suxm\_linux\_x86-64.tar.bz2](https://app.box.com/s/zoeet80oebvzrth4wh38iibdulegvlrb)
- [Suxm\_macos\_x86-64.tgz](https://app.box.com/s/aznzq3g4hu26ayw9u0vhay1kmus52yvb)		
- [Suxm\_windows\_x86-64.zip](https://app.box.com/s/e5mf5ujome2ilis25s3hxqs6e0t2rmac)

### Installation

##### On Windows

Unzip the `Suxm_windows_x86-64.zip` inside `C:\Programs\Suxm\`.

Click **Start**, type *cmd*. When the *cmd.exe* icon appears, right click and select *Run as administrator*.

To add/update system environment variables:

```
setx -m PATH "%PATH%;C:\Programs\Suxm\";
```

##### On MacOS / Linux

Unzip the `Suxm_macos_x86-64.zip` for Mac OS while  `Suxm_linux_x86-64.zip` for Linux; inside `/Users/username/Applications/Suxm/`.

Open the Terminal program (this is in your Applications/Utilites folder by default). Run the following command

```
touch ~/.bash_profile; open ~/.bash_profile
```

This will open the file in the your default text editor.

```
export PATH=$PATH:/Users/username/Applications/Suxm/
```

Save the file and quit the text editor. Execute your .bash_profile to update your PATH.

```
source ~/.bash_profile
```

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