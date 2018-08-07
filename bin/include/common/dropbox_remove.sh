#!/bin/sh

echo "Starting dropbox remove..."

"$SHARE_DIR/bin/dropbox.py autostart n"
"$SHARE_DIR/bin/dropbox.py stop"

rm -rf "$HOME/.dropbox"
rm -rf "$HOME/Dropbox"

rm "$SHARE_DIR/bin/dropbox.py"

