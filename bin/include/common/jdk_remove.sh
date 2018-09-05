#!/bin/sh

# NOTE: does not delete the jar file

# remove .jdk file
rm "$SHARE_DIR/etc/include/.jdk"

# jdk full path
if [ -f "$DOWNLOAD_DIR/$JDK_FILENAME" ]; then
    jdk_file_path="$DOWNLOAD_DIR/$JDK_FILENAME"
else
    jdk_file_path="${SHARE_DIR}/docker/$JDK_FILENAME"
fi


# use downloaded file to figure out folder name for deletion
if [ -f "$jdk_file_path" ]; then
    echo "Extracting to find jdk folder name"
	jdk_dir="$(tar tzf "$jdk_file_path" | sed -e 's@/.*@@' | uniq)"
    
    echo "JDK folder name: $jdk_dir"
else
    echo "File not found: $JDK_FILENAME"
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
