#!/bin/sh

echo "Starting dropbox remove..."

if [ -f "$SHARE_DIR/bin/dropboxy.py" ]; then
	echo "Stopping dropbox"

	"$SHARE_DIR/bin/dropbox.py stop"
fi

sleep 30

DBX_PID="$(ps aux | egrep '/[d]ropbox$' | awk '{print $2}')"
# DBX_PID="$(ps -ef | egrep "/dropbox$" | egrep -o "[0-9]{3,}" | sed -n '1 p')"
# DBX_PID="$(ps -ef | egrep "/dropbox$" | sed -n 's/[[:blank:]]\+/\n/gp' | sed -n '2p')"

echo "Checking dropbox process: $DBX_PID"
	
if [ -n "$DBX_PID" ]; then
	echo "Killing dropbox process: $DBX_PID"
	kill -9 "$DBX_PID"
fi

sleep 2

if [ -d "$HOME/.dropbox-dist" ]; then 
	rm -rf "$HOME/.dropbox-dist"
fi

if [ -d "$HOME/.dropbox" ]; then 
	rm -rf "$HOME/.dropbox"
fi

if [ -d "$HOME/Dropbox" ]; then 
	rm -rf "$HOME/Dropbox"
fi

if [ -f "$SHARE_DIR/bin/dropbox.py" ]; then
	rm "$SHARE_DIR/bin/dropbox.py"
fi
