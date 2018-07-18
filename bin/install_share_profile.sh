#!/bin/sh

# make sure folders exist
if [ -z ${SHARE_DIR} ] || [ ! -e ${SHARE_DIR} ]; then
	SHARE_DIR="$HOME/share"

	echo "SHARE_DIR is undefined, using default location $SHARE_DIR"

	if [ ! -d "$SHARE_DIR" ]; then
		mkdir "$SHARE_DIR"
	fi

	if [ ! -d "$SHARE_DIR/bin" ]; then
		mkdir "$SHARE_DIR/bin"
	fi

	if [ ! -d "$SHARE_DIR/etc" ]; then
		mkdir "$SHARE_DIR/etc"
	fi
fi

# build the .share_profile file
share_file="../.share_profile"
if [ -f $share_file ]; then
	echo "Building share_profile"

	rm "$HOME/.share_profile"

	printf "%s\n%s\n" "SHARE_DIR=\"$SHARE_DIR\"" "$(cat $share_file)" > "$HOME/.share_profile"
fi

# include share_profile in profile
match="$(cat $HOME/.profile | grep '.share_profile')"

if [ -z "$match" ]; then 
	echo "Including share_profile in profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "if [ -f \"$HOME/.share_profile\" ]; then . \"$HOME/.share_profile\"; fi" >> $HOME/.profile
fi

# copy over etc and bin files
echo "Copying bin and etc files"

cp -f "./sd.sh" "$SHARE_DIR/bin/."
cp -f "./setjava.sh" "$SHARE_DIR/bin/."

cp -f "../etc/.common_aliases" "$SHARE_DIR/etc/."
cp -f "../etc/.common_env" "$SHARE_DIR/etc/."

