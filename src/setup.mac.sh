#!/usr/bin/bash env
USER="$(ID -un)"
INSTALLATION_DIR="$HOME/Documents/Program/Suxm"
CURRENT_DIR="$PWD"
echo "Suxm webserver (Version 1.0.0)"
echo "Copyright (c) 2017 Abhishek Kumar. All rights reserved."
echo " "
echo "Installing ..."
echo " - at $INSTALLATION_DIR"
echo " - via $CURRENT_DIR"
echo " - creating installation directory"
mkdir -p "$INSTALLATION_DIR"
echo " - copying the installation package"
cp -r "$CURRENT_DIR/" "$INSTALLATION_DIR/"
cd "$INSTALLATION_DIR/bin"
echo " - giving short name to executable"
mv "Suxm_darwin_amd64" "Suxm"
echo " - making it globally accessible"
export PATH="$PATH:$PWD" >> "$HOME/.bash_profile"
echo " "
echo "Done!"
exit 0
