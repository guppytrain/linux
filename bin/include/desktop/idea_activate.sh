#!/bin/sh

echo "Starting idea activate..."

# download application key
if [ ! -f "$HOME/Downloads/$license_file" ] || [ ! -f "$DOWNLOAD_DIR/$license_file" ]; then
	key_uri="https://account.jetbrains.com/licenses"

	firefox "$key_uri" & > /dev/null 2>&1
fi

bash -c "read -s -e -p \"Log in to JetBrains account, if necessary.  Download license file for offline use.  Press ENTER to continue...\""

license_file="YMYRG6F1LL.txt"
if [ -f "$HOME/Downloads/$license_file" ]; then
	mv -f "$HOME/Downloads/$license_file" "$DOWNLOAD_DIR/." 
fi

# set idea info
filename="idea.key"
dest_dir="$HOME/.IntelliJIdea2018.1/config"

# insert key
if [ -f "$DOWNLOAD_DIR/$license_file" ]; then
	$SHARE_DIR/bin/idea.sh &

	sleep 10

	echo "About to add key: $filename"

	if [ -d "$dest_dir" ]; then
		# cp "$DOWNLOAD_DIR/$filename" "$dest_dir/."
		printf "%s\n%s" "<certificate-key>" "$(cat $DOWNLOAD_DIR/$license_file)" > "$dest_dir/$filename"
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
