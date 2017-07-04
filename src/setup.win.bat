@echo off
set INSTALLATION_DIR=%APPDATA%\Suxm
set CURRENT_DIR=%cd%
echo.
echo Suxm webserver (Version 1.0.0)
echo Copyright (c) 2017 Abhishek Kumar. All rights reserved.
echo.
echo Installing ...
echo.
echo Configuring to install 
echo  - at "%INSTALLATION_DIR%"
echo  - via "%CURRENT_DIR%"

echo Creating installation directory
if exist "%INSTALLATION_DIR%" (
	echo Removing previous installation
	rmdir /s /q "%INSTALLATION_DIR%"
)
mkdir "%INSTALLATION_DIR%"

echo Copying the installation package
xcopy /e "%CURRENT_DIR%" "%INSTALLATION_DIR%"

echo Removing installer file
del "%INSTALLATION_DIR%\setup.bat"

cd "%INSTALLATION_DIR%\bin"
echo Giving short name to "%PROCESSOR_ARCHITECTURE%" executable
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
	ren Suxm_windows_386.exe Suxm.exe
	del Suxm_windows_amd64.exe
) else if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	ren Suxm_windows_amd64.exe Suxm.exe
	del Suxm_windows_386.exe
)

echo Making it globally accessible
setx PATH "%cd%;%PATH%"

cd "%CURRENT_DIR%"
echo.
echo Done!
