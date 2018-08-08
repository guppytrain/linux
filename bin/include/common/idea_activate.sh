#!/bin/sh

echo "Starting idea activate..."

# set idea info
filename="idea.key"
IDEA_DIR="$HOME/Dropbox/idea"
dest_dir="$HOME/.IntelliJIdea2018.1/config"

# insert key
if [ -f "$IDEA_DIR/$filename" ]; then
	$SHARE_DIR/bin/idea.sh &

	sleep 10

	echo "About to add key: $filename"

	if [ -d "$dest_dir" ]; then
		cp "$IDEA_DIR/$filename" "$dest_dir/."
	fi

	IDEA_PID="$(ps aux | egrep '/[i]dea.sh$' | awk '{print $2}')"

	if [ -n "$IDEA_PID" ]; then
		echo "Killing idea process: $IDEA_PID"
		kill -9 "$IDEA_PID"
	else
		echo "Could not find idea process"
	fi

	IDEA_PID2="$(ps aux | egrep '/opt/[i]dea' | awk '{print $2}')"

	if [ -n "$IDEA_PID2" ]; then
		echo "Killing idea process: $IDEA_PID2"
		kill -9 "$IDEA_PID2"
	else
		echo "Could not find idea process"
	fi

	# sleep 5
	# $SHARE_DIR/bin/idea.sh &
else
	echo "Could not find $filename or $dest_dir"
fi
