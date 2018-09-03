#!/bin/bash

# include some utils
. "$CWH/bin/util/include/sleepfor.sh"

# get options
while getopts "df" o; do
    case "$o" in
        d)
            download_only=true
            ;;
        f)
            force=true
            ;;
        *)
            echo "No options specified"
            ;;
    esac
done

shift $(( OPTIND-1 ))

printf "%s, %s \n" "download_only=\"${download_only}\"" "force=\"${force}\""

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
if [ -f "$SHARE_DIR/docker/$JDK_FILENAME" ]; then
    jdk_file_path="${SHARE_DIR}/docker/$JDK_FILENAME"
else
    jdk_file_path="$DOWNLOAD_DIR/$JDK_FILENAME"
fi

if [ -f "$SHARE_DIR/docker/$JCE_FILENAME" ]; then
    jce_file_path="${SHARE_DIR}/docker/$JCE_FILENAME"
else
    jce_file_path="$DOWNLOAD_DIR/$JCE_FILENAME"
fi

# download file, if not already downloaded, and not force=true
if [ -f "$jdk_file_path" ] && [ "$force" != true ]; then
	echo "Using existing file: $jdk_file_path"
else
	echo "About to download file: $JDK_FILENAME"
	wget --progress=dot:giga --header "${JDK_REQ_HEADER}" -O "$DOWNLOAD_DIR/$JDK_FILENAME" "$JDK_URI"
    jdk_file_path="$DOWNLOAD_DIR/$JDK_FILENAME"
fi

# download file, if not already downloaded, and not force=true
if [ -f "$jce_file_path" ] && [ "$force" != true ]; then
	echo "Using existing file: $jce_file_path"
else
	echo "About to download file: $JCE_FILENAME"
    wget --progress=dot:binary --header "${JDK_REQ_HEADER}" -O "$DOWNLOAD_DIR/$JCE_FILENAME" "$JCE_URI"
    jce_file_path="$DOWNLOAD_DIR/$JCE_FILENAME"
fi

if [ -n "${download_only}" ]; then
    echo "Download only.  Exiting..."
    sleepfor 3
    exit 0
fi

printf "%s\n\n%s\n" "JDK_INSTALL_DIR=$dest_dir" "$(cat $CWH/etc/.jdk)" > "$SHARE_DIR/etc/include/.jdk"

echo "Extracting folder name..."
jdk_dir="$(tar tzf "$jdk_file_path" | sed -e 's@/.*@@' | uniq)"

# ensure destination
if [ ! -d "$dest_dir" ]; then
	sudo mkdir "$dest_dir"
fi

# clean up existing
if [ -L "$dest_dir/current" ]; then
	sudo rm "$dest_dir/current" 
fi

if [ -d "$dest_dir/$jdk_dir" ]; then
	sudo rm -rf "$dest_dir/$jdk_dir" 
fi

# extract
echo "Extracting jdk files..."
sudo tar -xzf "$jdk_file_path" -C "$dest_dir"

sudo ln -s "$dest_dir/$jdk_dir" "$dest_dir/current"

echo "Contents of `readlink -f $dest_dir/current`"

ls "$dest_dir/current"

# unzip the jce
sudo unzip -jo -d "${dest_dir}/${jdk_dir}/jre/lib/security" "$jce_file_path"
# sudo rm "${dest_dir}/${jdk_dir}/jre/lib/security/README.txt"

if [ "${PRUNE_JDK}" = true ]; then
    jdk_prune.sh "${dest_dir}/${jdk_dir}"
fi

# print out the version
"$dest_dir/current/bin/java" -version
