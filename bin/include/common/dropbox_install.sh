#!/bin/sh

echo "Starting dropbox install..."

cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

"$HOME/.dropbox-dist/dropboxd"

cp "$CWH/bin/util/dropbox.py" "$SHARE_DIR/bin/."

$SHARE_DIR/bin/dropbox.py autostart y

