#!/bin/sh

# source the env vars
. ./include/env.sh

echo "Starting Desktop Install..." 

# directions for dropbox
url="https://www.dropbox.com"

printf "%s\n" "Press ENTER to open Dropbox site to log in to Dropbox account."
bash -c "read -s -e -p \"[ENTER]\""
echo

[ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [ "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )

sleep 5

printf "%s\n" "Press ENTER after successfully logging in."
bash -c "read -s -e -p \"[ENTER]\""
echo

# download license key for IntelliJ
license_file="YMYRG6F1LL.txt"

if [ ! -f "$HOME/Downloads/$license_file" ] || [ ! -f "$DOWNLOAD_DIR/$license_file" ]; then
    url="https://www.jetbrains.com"

    printf "%s\n%s\n" "Press ENTER to open JetBrains site to log in to JetBrains account." "Then download license file ('YMYRG6F1LL.txt') for offline use, into $HOME/Downloads."
    bash -c "read -s -e -p \"[ENTER]\""
    echo

    [ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [ "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )

    sleep 5

    printf "%s\n" "Press ENTER after successfully logging in and downloading license file."
    bash -c "read -s -e -p \"[ENTER]\""
    echo
fi

# start install
cd $CWH/bin/installers
./vim_plugins_install.sh
./dropbox_install.sh 
./virtualbox_install.sh 
./idea_install.sh -t &&  
./idea_activate.sh 

# run docker install last because in some cases it needs a reboot to finish
./docker_install.sh 

echo "Finished Desktop Install"
