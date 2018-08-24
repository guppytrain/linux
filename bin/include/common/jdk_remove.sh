#!/bin/sh

# jdk info
filename="jdk-8u171-linux-x64.tar.gz"

# download file, if not already downloaded
if [ -f "$DOWNLOAD_DIR/$filename" ]; then
	jdk_dir="$(tar tzf "$DOWNLOAD_DIR/$filename" | sed -e 's@/.*@@' | uniq)"
else
	exit 0
fi

dest_dir="/usr/lib/jvm"

# extract file to destination
if [ -d "$dest_dir" ]; then
	if [ -d "$dest_dir/$jdk_dir" ]; then
		sudo rm -rf "$dest_dir/$jdk_dir" 
	fi

	if [ -L "$dest_dir/current" ]; then
		sudo rm "$dest_dir/current" 
	fi
else
	exit 0
fi
