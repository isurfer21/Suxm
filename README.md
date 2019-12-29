# Suxm

*Copyright (c) 2017 Abhishek Kumar. This work is licensed under the __Apache License 2.0__*


A micro web-server meant to serve locally and is very fast web-server that will make use of full capacity of your system. 

### Automatic installation
To install the app directly on your system, use the commands given below on Terminal.

##### Recommended script to use
Use the below installation script code based on what your system supports, like

- on **Windows** use *PowerShell* (default)
- on **macOS** / **Linux** use either *Shell* (default) or *PowerShell Core* (if already available)

#### Install latest version

With *Shell*:

```bash
curl -fsSL https://isurfer21.github.io/Suxm/install.sh | sh
```

With *PowerShell*:

```powershell
iwr https://isurfer21.github.io/Suxm/install.ps1 -useb | iex
```

#### Install specific version

With *Shell*:

```bash
curl -fsSL https://isurfer21.github.io/Suxm/install.sh | sh -s v1.0.1
```

With *PowerShell*:

```powershell
iwr https://isurfer21.github.io/Suxm/install.ps1 -useb -outf install.ps1; .\install.ps1 v1.0.1
```

### Semi-automatic installation
To install the app after manually downloading it on your system, use the links given below and follow the commands thereafter.

#### Download portable version
  
- [Suxm\_linux\_x86-64.tar.bz2](https://app.box.com/s/zoeet80oebvzrth4wh38iibdulegvlrb)
- [Suxm\_macos\_x86-64.tgz](https://app.box.com/s/aznzq3g4hu26ayw9u0vhay1kmus52yvb)
- [Suxm\_windows\_x86-64.zip](https://app.box.com/s/e5mf5ujome2ilis25s3hxqs6e0t2rmac)

#### Install portable version on Windows

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

#### Install portable version on MacOS / Linux

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
$ suxm --help

Suxm webserver (Version 1.0.1) 
Copyright (c) 2017 Abhishek Kumar.
Licensed under the Apache License 2.0.

Options:

  -h, --help               display help information
  -p, --port[=8080]        set custom port number
  -u, --host[=127.0.0.1]   set host IP or server address
  -d, --docpath            set document directory's path
  -b, --browser[=true]     open browser on server start
  -a, --approot[=false]    serve from application's root
  -x, --cors[=false]       allows cross domain requests
  -m, --mime[=false]       allows custom content-type header

Done!

```

##### Serving from server-root

When your *webapp* directory is inside **Suxm** directory or alongside it's executable application.

```
$ suxm -a=true -d=/webapp -p=9000

Suxm webserver (Version 1.0.1) 
Copyright (c) 2017 Abhishek Kumar.
Licensed under the Apache License 2.0.

Server settings 
  Root   /Users/abhishekkumar/Applications/Suxm/webapp
  URL    http://127.0.0.1:9000 
  Time   Sun, 25 Jun 2017 02:08:26 IST

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Serving from current directory

When your *webapp* directory is placed somewhere else on your system. 

```
$ cd /Users/abhishekkumar/Documents/webapp/
$ suxm -p=9000

Suxm webserver (Version 1.0.1) 
Copyright (c) 2017 Abhishek Kumar.
Licensed under the Apache License 2.0.

Server settings 
  Root   /Users/abhishekkumar/Documents/webapp/ 
  URL    http://127.0.0.1:9000 
  Time   Sun, 25 Jun 2017 02:08:26 IST

Server status: STARTED
A browser window should open. If not, visit the link.
Please hit 'ctrl + C' to STOP the server.
```

##### Serving from relative directory

When your *webapp* directory is placed further inside the sub-folder of current directory.

```
$ cd /Users/abhishekkumar/Documents/
$ suxm -d=./webapp -p=9000
```

##### Custom host address

To specifiy custom host IP or address, run this command

```
$ suxm -u=192.168.0.1
```

##### Custom port number

To specifiy custom port number, run this command

```
$ suxm -p=9000
```

##### Custom host address & port number

To specifiy custom host IP or address and port number, run this command

```
$ suxm -u=192.168.0.1 -p=9000
```

##### Disable self opening of browser

To disable, automatic opening of browser on server start, run this command

```
$ suxm -b=false
```

##### Cross domain requests

To allow cross domain requests while serving content, run this command

```
$ suxm -x=true
```

##### Custom content-type header

To respond with custom content-type header while serving content, run this command

```
$ suxm -m=true
```

While on browser, add content-type query parameter in URL with custom content-type value.

For example, when requested a *markdown* file via URL [http://localhost/readme.md](http://localhost/readme.md) then by default it is served with 

```
Content-Type: text/plain; charset=utf-8
```

but when `?content-type=text/markdown` is added in the URL as [http://localhost/readme.md?content-type=text/markdown](http://localhost/readme.md?content-type=text/markdown) then it is served with

```
Content-Type: text/markdown
```

if custom content-type header option `-m` is enabled in `suxm`.

#### Notes

1. All of these command-line options can be used alone or together with other options in any combination/order.
2. Any of these *boolean* type command-line options can be declared as
	- `-b`, `-b=1`, `-b=true` → equivalent
	- `-b=0`, `-b=false` → equivalent
3. The static server would be served on single address only, i.e., by default localhost but if declared custom host address then it would be served on that host address only and would not serve on localhost.