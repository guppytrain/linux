#!/bin/sh

echo "Starting idea install..."

# set idea info
filename="ideaIU-2018.1.5.tar.gz"
IDEA_DIR="$HOME/Dropbox/idea"
dest_dir="/opt"
# dest_dir="$HOME/tmp"

# install idea, if found otherwise quit
if [ -f "$IDEA_DIR/$filename" ]; then
	install_dir="$(tar tzf "$IDEA_DIR/$filename" | sed -e 's@/.*@@' | uniq)"
        
	echo "About to install file: $filename"
	sudo tar -xzvf "$IDEA_DIR/$filename" -C "$dest_dir"

	ln -s "$dest_dir/$install_dir/bin/idea.sh" "$SHARE_DIR/bin/."

	# tag the install dir with a marker file
	sudo touch "$dest_dir/$install_dir/.IDEA_HOME"
else
	echo "Could not find $filename"
fi
