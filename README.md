# Suxm

*Copyright (c) 2017 Abhishek Kumar. This work is licensed under the __Apache License 2.0__*


A micro web-server meant to serve locally and is very fast web-server that will make use of full capacity of your system. 

### Download
	
- [Suxm\_linux\_x86-64.tar.bz2](https://app.box.com/s/zoeet80oebvzrth4wh38iibdulegvlrb)
- [Suxm\_macos\_x86-64.tgz](https://app.box.com/s/aznzq3g4hu26ayw9u0vhay1kmus52yvb)
- [Suxm\_windows\_x86-64.zip](https://app.box.com/s/e5mf5ujome2ilis25s3hxqs6e0t2rmac)

### Installation

#### On Windows

1. Unzip the `Suxm_windows_x86-64.zip` anywhere on your system.
2. Go to the unzipped folder and double click on `setup.bat` file, it will install the application on your system.

##### Troubleshoot

Open the **Command Prompt**, run `suxm -h`. If you see the following message, 

```
C:\>suxm -h
'suxm is not recognized as an internal or external command, 
operable program or batch file.
``` 

then you need to manually modify or verify if the path is properly added in user's environment variable.

##### How to modify/verify windows environment variable?

1. Open File Explorer and go to `Control Panel\System and Security\System`, where you will see the basic information about your computer.
2. Click on the **Advance system settings** link provided in sidebar at left, to open *System Properties*.
3. Click on **Environment Variables...** button in *Advanced* tab of *System Properties* window. 
4. Click on **PATH** in System variables section to edit it.
5. Add this path `%APPDATA%\Suxm\bin` at the end. Suxm path should be separated by semicolon from other existing paths.
6. Click on *OK* button to close all the popup windows one-by-one.

#### On MacOS / Linux

1. Unzip the `Suxm_macos_x86-64.zip` for Mac OS while  `Suxm_linux_x86-64.zip` for Linux; anywhere on your system.
2. Open the **Terminal** program (this is in your Applications/Utilites folder by default) and go to the unzipped folder using `cd $HOME/Downloads/Suxm_linux_x86-64`.
3. Run this command, `sh setup.sh`, it will install the application on your system.

##### Troubleshoot

Open the **Terminal**, run `suxm -h`. If you see the following message, 

```
$ suxm -h
-bash: suxm: command not found
```

then you need to manually modify or verify if the path is properly added in `~/.bash_profile`.

##### How to modify/verify macos/linux bash_profile?

1. Open the Terminal program (this is in your Applications/Utilites folder by default). Run this command, `touch ~/.bash_profile; open ~/.bash_profile`, it will open the file in the your default text editor.
2. Add this line in the `.bash_profile`, `export PATH="$PATH:$HOME/Documents/Programs/Suxm"` on MacOS, while `export PATH="$PATH:$HOME/Programs/Suxm"` on Linux.
3. Save the file and quit the text editor. Execute your `.bash_profile` to update your PATH using `source ~/.bash_profile`

### Usage

```
$ ./Suxm --help

Suxm webserver (Version 1.0.0) 
Copyright (c) 2017 Abhishek Kumar. Licensed under the Apache License 2.0.

Options:

  -h, --help               display help information
  -p, --port[=8080]        set custom port number
  -u, --host[=127.0.0.1]   set host IP or server address
  -d, --docpath            set document directory's path
  -b, --browser[=true]     open browser on server start
  -a, --approot[=false]    serve from application's root
  -x, --cors[=false]       allows cross domain requests

Done!

```

##### Serving from server-root

When your *webapp* directory is inside **Suxm** directory or alongside it's executable application.

```
$ ./Suxm -a=true -d=/webapp -p=9000

Suxm webserver (Version 1.0.0) 
Copyright (c) 2017 Abhishek Kumar. Licensed under the Apache License 2.0.

Server settings 
  Root   /Users/abhishekkumar/Applications/Suxm/webapp
  URL    http://127.0.0.1:9000 
  Time   Sun, 25 Jun 2017 02:08:26 IST

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Serving from directory-root

When your *webapp* directory is placed somewhere else on your system. 

```
$ cd /Users/abhishekkumar/Documents/webapp/
$ ./Suxm -d=. -p=9000

Suxm webserver (Version 1.0.0) 
Copyright (c) 2017 Abhishek Kumar. Licensed under the Apache License 2.0.

Server settings 
  Root   /Users/abhishekkumar/Documents/webapp/ 
  URL    http://127.0.0.1:9000 
  Time   Sun, 25 Jun 2017 02:08:26 IST

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Other commands

To specifiy custom host IP or address

```
$ ./Suxm -d=/Users/abhishekkumar/webapp/ -u=192.168.0.1 -p=9000
```

To stop, automatic opening of browser on server start

```
$ ./Suxm -b=false -d=/Users/abhishekkumar/webapp/ -p=9000
```
