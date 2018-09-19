#!/bin/sh

echo "Starting idea install..."

# set idea info
filename="ideaIU-2018.1.5.tar.gz"
DROPBOX_DIR="$HOME/Dropbox"
IDEA_DIR="$DROPBOX_DIR/idea"
dest_dir="/opt"
# dest_dir="$HOME/tmp"

# get options
til_ready=""

while getopts "t" o; do
    case "$o" in
        t)
            til_ready=true
            ;;
        *)
            usage
            ;;
    esac
done

echo "# Opts supplied: t=$til_ready"

shift $(( OPTIND-1 ))

[ -n "${til_ready}" ] &&  
    echo "Waiting for dropbox folder and ${filename} to be 'ready'" && 
    wait_for_file.sh "${DROPBOX_DIR}" "${IDEA_DIR}/${filename}"

# install idea, if found otherwise quit
if [ -f "$IDEA_DIR/$filename" ]; then
    echo "Extracting install dir name..."

	install_dir="$(tar tzf "$IDEA_DIR/$filename" | sed -e 's@/.*@@' | uniq)"
        
	echo "About to install file: $filename"
	
    sudo tar -xzvf "$IDEA_DIR/$filename" -C "$dest_dir"

	ln -s "$dest_dir/$install_dir/bin/idea.sh" "$SHARE_DIR/bin/."

	# tag the install dir with a marker file
	sudo touch "$dest_dir/$install_dir/.IDEA_HOME"
else
	echo "Could not find $IDEA_DIR/$filename"
fi
