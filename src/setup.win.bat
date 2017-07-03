@echo off
set INSTALLATION_DIR=%APPDATA%\Suxm
set CURRENT_DIR=%cd%
echo.
echo Suxm webserver (Version 1.0.0)
echo Copyright (c) 2017 Abhishek Kumar. All rights reserved.
echo.
echo Installing ...
echo  - at "%INSTALLATION_DIR%"
echo  - via "%CURRENT_DIR%"
echo  - creating installation directory
if exist "%INSTALLATION_DIR%" (
	echo  - removing previous installation
	rmdir /s /q "%INSTALLATION_DIR%"
)
mkdir "%INSTALLATION_DIR%"
echo  - copying the installation package
xcopy /e "%CURRENT_DIR%" "%INSTALLATION_DIR%"
cd "%INSTALLATION_DIR%\bin"
echo  - giving short name to executable
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	del Suxm_windows_amd64.exe
	ren Suxm_windows_386.exe Suxm.exe
) else (
	del Suxm_windows_386.exe
	ren Suxm_windows_amd64.exe Suxm.exe
)
echo  - making it globally accessible
setx PATH "%cd%;%PATH%"
cd "%CURRENT_DIR%"
echo.
echo Done!
