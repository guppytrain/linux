#!/bin/sh

echo "Starting dropbox install..."

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
