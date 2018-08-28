#!/bin/bash

# include some utils
. "$CWH/bin/util/include/sleepfor.sh"

# get options
while getopts "d" o; do
    case "$o" in
        d)
            download_only=true
            ;;
        *)
            echo "No options specified"
            ;;
    esac
done

shift $(( OPTIND-1 ))

echo "download_only=\"${download_only}\""

if [ -z "$DOWNLOAD_DIR" ] || [ ! -d "$DOWNLOAD_DIR" ]; then
	echo "Download director is not defined, exiting..."
	sleepfor 5
	exit 0
else
	echo "Using download dir: $DOWNLOAD_DIR"
fi

# set jdk info
# dest_dir="/usr/local/jdk"
dest_dir="/usr/lib/jvm"

# approach: if in share folder, use it; otherwise, download it, but do not copy it to the share folder after downloading
if [ -f "$DOWNLOAD_DIR/$JDK_FILENAME" ]; then
    jdk_file_path="$DOWNLOAD_DIR/$JDK_FILENAME"
else
    jdk_file_path="${SHARE_DIR}/docker/$JDK_FILENAME"
fi

# download file, if not already downloaded
if [ -f "$jdk_file_path" ]; then
	echo "Using existing file: $jdk_file_path"
else
	echo "About to download file: $JDK_FILENAME"
	wget -O "$DOWNLOAD_DIR/$JDK_FILENAME" "$JDK_URI"
fi

if [ -n "${download_only}" ]; then
    echo "Download only.  Exiting..."
    sleepfor 3
    exit 0
fi

printf "%s\n\n%s\n" "JDK_INSTALL_DIR=$dest_dir" "$(cat $CWH/etc/.jdk)" > "$SHARE_DIR/etc/include/.jdk"

jdk_dir="$(tar tzf "$jdk_file_path" | sed -e 's@/.*@@' | uniq)"

# ensure destination
if [ ! -d "$dest_dir" ]; then
	sudo mkdir "$dest_dir"
fi

if [ -d "$dest_dir/$jdk_dir" ]; then
	sudo rm -rf "$dest_dir/$jdk_dir" 
fi

if [ -L "$dest_dir/current" ]; then
	sudo rm "$dest_dir/current" 
fi

sudo tar -xzf "$jdk_file_path" -C "$dest_dir"

sudo ln -s "$dest_dir/$jdk_dir" "$dest_dir/current"

echo "Contents of `readlink -f $dest_dir/current`"

ls "$dest_dir/current"


