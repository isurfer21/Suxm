#!/usr/bin/bash env
INSTALLATION_DIR="$HOME/Documents/Programs/Suxm"
CURRENT_DIR="$PWD"
CPU_ARCH="$(getconf LONG_BIT)"

printf "\nSuxm webserver (Version 1.0.0) \nCopyright (c) 2017 Abhishek Kumar. All rights reserved. \n"

printf "\nInstalling ... \n\nConfiguring to install \n - at $INSTALLATION_DIR \n - via $CURRENT_DIR"

printf "\nCreating installation directory"
if [ -d "$INSTALLATION_DIR" ]; then
	printf "\nRemoving previous installation"
	rm -rf "$INSTALLATION_DIR"
fi
mkdir -p "$INSTALLATION_DIR"

printf "\nCopying the installation package"
cp -r "$CURRENT_DIR/" "$INSTALLATION_DIR/"

printf "\nRemoving installer file"
rm -rf "$INSTALLATION_DIR/setup.sh"

cd "$INSTALLATION_DIR/bin"
printf "\nGiving short name to $CPU_ARCH bit executable"
if [[ $CPU_ARCH -eq 64 ]]; then
	mv "Suxm_darwin_amd64" "Suxm"
	rm "Suxm_darwin_386"
elif [[ $CPU_ARCH -eq 32 ]]; then
	mv "Suxm_darwin_386" "Suxm"
	rm "Suxm_darwin_amd64"
fi

printf "\nMaking it globally accessible"
printf "\nexport PATH=\"\$PATH:$PWD\"" >> "$HOME/.bash_profile"

printf "\n\nDone!\n"
exit 0