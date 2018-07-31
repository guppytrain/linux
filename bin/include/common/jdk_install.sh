#!/bin/sh

if [ -z "$DOWNLOAD_DIR" ] || [ ! -d "$DOWNLOAD_DIR" ]; then
	echo "Download director is not defined, exiting..."
	sleep 5
	exit 0
else
	echo "Using download dir: $DOWNLOAD_DIR"
fi

# set jdk info
filename="jdk-8u171-linux-x64.tar.gz"
jdk_uri="https://www.dropbox.com/s/6ay7ktjs97vsne3/jdk-8u171-linux-x64.tar.gz?dl=1"
#jdk_uri="https://ucdfb278c0764de3b93e2ed6c6f3.dl.dropboxusercontent.com/cd/0/get/AMwtuEr9L5QDqja0LwM3wK0DxAi6qTdYtDlEKzqfZIpO1sxDdOmwp_WWquiMwKXerKdM3vxLP25IDIkBFdtqr8gFACCqAZ6Rly__sM2azKC4tQ0LM0gyNglpa-fe36kIDcv5qQoC4SSMG6JvYIOfVMnb2RON-z57TWRvE4LZiv-tOkXVmOYhCRNXKFpnBEPIHx4/file?dl=1"
#jdk_uri="https://drive.google.com/uc?id=1sKtoo4eTON3NqZNPUmVdAVbbxpqJUznj&export=download"
dest_dir="/usr/local/jdk"
#dest_dir="/usr/local/test"

# download file, if not already downloaded
if [ -f "$DOWNLOAD_DIR/$filename" ]; then
	echo "Using existing file: $filename"
else
	echo "About to download file: $filename"
	wget -O "$DOWNLOAD_DIR/$filename" "$jdk_uri"
fi

jdk_dir="$(tar tzf "$DOWNLOAD_DIR/$filename" | sed -e 's@/.*@@' | uniq)"

# echo "jdk_dir=$jdk_dir"

# extract file to destination
if [ ! -d "$dest_dir" ]; then
	sudo mkdir "$dest_dir"
fi

if [ -d "$dest_dir/$jdk_dir" ]; then
	sudo rm -rf "$dest_dir/$jdk_dir" 
fi

if [ -L "$dest_dir/current" ]; then
	sudo rm "$dest_dir/current" 
fi

sudo tar -xzvf "$DOWNLOAD_DIR/$filename" -C "$dest_dir"

sudo ln -s "$dest_dir/$jdk_dir" "$dest_dir/current"

echo "Contents of `readlink -f $JDKDIR/current`"

ls "$dest_dir/current"


