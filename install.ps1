#!/usr/bin/env pwsh
# Copyright (c) 2019 Abhishek Kumar. All rights reserved. MIT license.

$ErrorActionPreference = 'Stop'

if ($args.Length -gt 0) {
  $Version = $args.Get(0)
}

if ($PSVersionTable.PSEdition -ne 'Core') {
  $IsWindows = $true
  $IsMacOS = $false
}

$OS = if ($IsWindows) {
  'windows'
} else {
  if ($IsMacOS) {
    'darwin'
  } else {
    'linux'
  }
}

$ARCH = if ([System.IntPtr]::Size -eq 4) {
  "386"
} else {
  "amd64"
}

$INSTALLATION_DIR = if ($IsWindows) {
  "$Home\.program\suxm"
} else {
  "$Home/.program/suxm"
}

Write-Output "Installing the Suxm CLI at `n  $INSTALLATION_DIR"

if (Test-Path $INSTALLATION_DIR) {
  Write-Output "Removing previous installation"
  Remove-Item -path "$INSTALLATION_DIR" -recurse 
}

if (!(Test-Path $INSTALLATION_DIR)) {
  Write-Output "Creating installation directory"
  New-Item $INSTALLATION_DIR -ItemType Directory | Out-Null
} 

$ABSOLUTE_FILEPATH = if ($IsWindows) {
  "$INSTALLATION_DIR\suxm.exe"
} else {
  "$INSTALLATION_DIR/suxm"
}

# GitHub requires TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$DOWNLOAD_LINK = if (!$Version) {
  $Response = Invoke-WebRequest 'https://github.com/isurfer21/suxm/releases' -UseBasicParsing
  if ($PSVersionTable.PSEdition -eq 'Core') {
    $Response.Links |
      Where-Object { $_.href -like "/isurfer21/suxm/releases/download/*/suxm_${OS}_${ARCH}" } |
      ForEach-Object { 'https://github.com' + $_.href } |
      Select-Object -First 1
  } else {
    $HTMLFile = New-Object -Com HTMLFile
    if ($HTMLFile.IHTMLDocument2_write) {
      $HTMLFile.IHTMLDocument2_write($Response.Content)
    } else {
      $ResponseBytes = [Text.Encoding]::Unicode.GetBytes($Response.Content)
      $HTMLFile.write($ResponseBytes)
    }
    $HTMLFile.getElementsByTagName('a') |
      Where-Object { $_.href -like "about:/isurfer21/suxm/releases/download/*/suxm_${OS}_${ARCH}.exe" } |
      ForEach-Object { $_.href -replace 'about:', 'https://github.com' } |
      Select-Object -First 1
  }
} else {
  if ($PSVersionTable.PSEdition -eq 'Core') {
    "https://github.com/isurfer21/suxm/releases/download/$Version/suxm_${OS}_${ARCH}"  
  } else {
    "https://github.com/isurfer21/suxm/releases/download/$Version/suxm_${OS}_${ARCH}.exe"
  }
}
Write-Output "Suitable build for ${OS} ${ARCH} `n  $DOWNLOAD_LINK"

Write-Output "Downloading the installation package"
Invoke-WebRequest $DOWNLOAD_LINK -OutFile $ABSOLUTE_FILEPATH -UseBasicParsing

Write-Output "Making it globally accessible"
if ($IsWindows) {
  $User = [EnvironmentVariableTarget]::User
  $Path = [Environment]::GetEnvironmentVariable('Path', $User)
  if (!(";$Path;".ToLower() -like "*;$INSTALLATION_DIR;*".ToLower())) {
    [Environment]::SetEnvironmentVariable('Path', "$Path;$INSTALLATION_DIR", $User)
    $Env:Path += ";$INSTALLATION_DIR"
  }
  Write-Output "Suxm was installed successfully to $ABSOLUTE_FILEPATH"
  Write-Output "Run 'suxm --help' to get started"
} else {
  chmod +x "$INSTALLATION_DIR/suxm"
  Write-Output "Suxm was installed successfully to $ABSOLUTE_FILEPATH"
  if (Get-Command suxm -ErrorAction SilentlyContinue) {
    Write-Output "Run 'suxm --help' to get started"
  } else {
    Write-Output "Manually add the directory to your `$HOME/.bash_profile (or similar)"
    Write-Output "  export PATH=`"${INSTALLATION_DIR}:`$PATH`""
    Write-Output "Run '$ABSOLUTE_FILEPATH --help' to get started"
  }
}

Write-Output "Done!"
