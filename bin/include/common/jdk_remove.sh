#!/bin/sh

# jdk info
filename="jdk-8u171-linux-x64.tar.gz"

# download file, use it to figure out folder name for deletion
if [ -f "$DOWNLOAD_DIR/$filename" ]; then
    echo "Extracting to find jdk folder name"
	jdk_dir="$(tar tzf "$DOWNLOAD_DIR/$filename" | sed -e 's@/.*@@' | uniq)"
    
    echo "JDK folder name: $jdk_dir"
else
    echo "File not found: $filename"
	exit 0
fi

dest_dir="/usr/lib/jvm"

# remove jdk dir inside dest_dir
if [ -d "$dest_dir" ]; then
    echo "Inside ${dest_dir}, about to remove jdk_dir"

	if [ -d "$dest_dir/$jdk_dir" ]; then
        echo "Removing ${jdk_dir}"
		sudo rm -rf "$dest_dir/$jdk_dir" 
	fi

	if [ -L "$dest_dir/current" ]; then
        echo "Removing symlink 'current'"
		sudo rm "$dest_dir/current" 
	fi
else
    echo "dest_dir does not exist"
	exit 0
fi
