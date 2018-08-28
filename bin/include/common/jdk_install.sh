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
filename="jdk-8u171-linux-x64.tar.gz"
jdk_uri="https://www.dropbox.com/s/6ay7ktjs97vsne3/jdk-8u171-linux-x64.tar.gz?dl=1"
#jdk_uri="https://ucdfb278c0764de3b93e2ed6c6f3.dl.dropboxusercontent.com/cd/0/get/AMwtuEr9L5QDqja0LwM3wK0DxAi6qTdYtDlEKzqfZIpO1sxDdOmwp_WWquiMwKXerKdM3vxLP25IDIkBFdtqr8gFACCqAZ6Rly__sM2azKC4tQ0LM0gyNglpa-fe36kIDcv5qQoC4SSMG6JvYIOfVMnb2RON-z57TWRvE4LZiv-tOkXVmOYhCRNXKFpnBEPIHx4/file?dl=1"
#jdk_uri="https://drive.google.com/uc?id=1sKtoo4eTON3NqZNPUmVdAVbbxpqJUznj&export=download"
# dest_dir="/usr/local/jdk"
dest_dir="/usr/lib/jvm"
#dest_dir="/usr/local/test"

# approach: if in share folder, use it; otherwise, download it, but do not copy it to the share folder after downloading
if [ -f "${SHARE_DIR}/docker/$filename" ]; then
    jdk_file_path="${SHARE_DIR}/docker/$filename"
else
    jdk_file_path="$DOWNLOAD_DIR/$filename"
fi

# download file, if not already downloaded
if [ -f "$jdk_file_path" ]; then
	echo "Using existing file: $filename"
else
	echo "About to download file: $filename"
	wget -O "$jdk_file_path" "$jdk_uri"
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


