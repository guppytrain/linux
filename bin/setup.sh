#!/bin/sh

. ./include/env.sh

cd "$CWH/bin"

# make sure folders exist
if [ ! -d "$DOWNLOAD_DIR" ]; then
	mkdir "$DOWNLOAD_DIR"
fi

if [ ! -d "$CLEAN_DIR" ]; then
	mkdir "$CLEAN_DIR"
fi

if [ ! -d "$SHARE_DIR" ]; then
	mkdir "$SHARE_DIR"
fi

if [ ! -d "$SHARE_DIR/bin" ]; then
	mkdir "$SHARE_DIR/bin"
fi

if [ ! -d "$SHARE_DIR/etc" ]; then
	mkdir "$SHARE_DIR/etc"
fi

# build the .share_profile file, remove existing if any
share_file="$HOME/.share_profile"

if [ -f $share_file ]; then
	echo "Removing user share_profile"

	rm "$HOME/.share_profile"
fi


echo "Building new share_profile"
printf "%s\n%s\n" "SHARE_DIR=\"$SHARE_DIR\"" "$(cat $CWH/etc/.share_profile)" > "$HOME/.share_profile"

# include share_profile in .profile
match="$(cat $HOME/.profile | grep '.share_profile')"

if [ -z "$match" ] && [ -f "$HOME/.profile" ]; then 
	cp "$HOME/.profile" "$CLEAN_DIR/.profile"

	echo "Including share_profile in profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "if [ -f \"$HOME/.share_profile\" ]; then . \"$HOME/.share_profile\"; fi" >> $HOME/.profile
fi

# include share_profile in .bash_profile
match2="$(cat $HOME/.bash_profile | grep '.share_profile')"

if [ -z "$match2" ] && [ -f "$HOME/.bash_profile" ]; then 
	cp "$HOME/.bash_profile" "$CLEAN_DIR/.bash_profile"

	echo "Including share_profile in bash_profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "if [ -f \"$HOME/.share_profile\" ]; then . \"$HOME/.share_profile\"; fi" >> $HOME/.bash_profile
fi

# include share_profile in .bashrc
match3="$(cat $HOME/.bashrc | grep '.share_profile')"

if [ -z "$match3" ] && [ -f "$HOME/.bashrc" ]; then
	cp "$HOME/.bashrc" "$CLEAN_DIR/.bashrc"

	echo "Including share_profile in bash_profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "[[ -f \"$HOME/.share_profile\" ]] && . \"$HOME/.share_profile\"" >> $HOME/.bashrc
fi

# copy over etc and bin files
echo "Copying bin and etc files"

cp -f "$CWH/bin/util/addpath.sh" "$SHARE_DIR/bin/."
cp -f "$CWH/bin/util/sd.sh" "$SHARE_DIR/bin/."
cp -f "$CWH/bin/util/setjava.sh" "$SHARE_DIR/bin/."

cp -f "$CWH/etc/.common_aliases" "$SHARE_DIR/etc/."
cp -f "$CWH/etc/.common_env" "$SHARE_DIR/etc/."

