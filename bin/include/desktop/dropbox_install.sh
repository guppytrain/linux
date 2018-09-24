#!/bin/sh

echo "Starting dropbox install..."

# directions
url="https://www.dropbox.com"

printf "%s\n" "Press ENTER to open Dropbox site to log in to Dropbox account."
bash -c "read -s -e -p \"[ENTER]\""
echo

[ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [ "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )

sleep 5

printf "%s\n" "Press ENTER after successfully logging in."
bash -c "read -s -e -p \"[ENTER]\""
echo

# set dbx info
filename="dropbox-lnx.x86_64-54.4.90.tar.gz"
dbx_uri="https://www.dropbox.com/download?plat=lnx.x86_64"

# download file, if not already downloaded
if [ ! -f "$DOWNLOAD_DIR/$filename" ]; then
    echo "About to download file: $filename"
	wget -O "$DOWNLOAD_DIR/$filename" "$dbx_uri"
fi

echo "Extracting dropbox system files"

tar -xzvf "$DOWNLOAD_DIR/$filename" -C "$HOME"

$HOME/.dropbox-dist/dropboxd &

cp "$CWH/bin/util/dropbox.py" "$SHARE_DIR/bin/."
