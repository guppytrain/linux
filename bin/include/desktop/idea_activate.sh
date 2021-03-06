#!/bin/sh

echo "Starting idea activate..."

# download license key for IntelliJ
license_file="YMYRG6F1LL.txt"

# download license files, if needed
if [ ! -f "$HOME/Downloads/$license_file" ] && [ ! -f "$DOWNLOAD_DIR/$license_file" ]; then
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
