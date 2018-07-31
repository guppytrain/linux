#!/bin/sh

. ./env.sh

cd "$CWH/bin"

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
	echo "Including share_profile in profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "if [ -f \"$HOME/.share_profile\" ]; then . \"$HOME/.share_profile\"; fi" >> $HOME/.profile
fi

# include share_profile in .bash_profile
match2="$(cat $HOME/.bash_profile | grep '.share_profile')"

if [ -z "$match2" ] && [ -f "$HOME/.bash_profile" ]; then 
	echo "Including share_profile in bash_profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "if [ -f \"$HOME/.share_profile\" ]; then . \"$HOME/.share_profile\"; fi" >> $HOME/.bash_profile
fi

# include share_profile in .bashrc
match3="$(cat $HOME/.bashrc | grep '.share_profile')"

if [ -z "$match3" ] && [ -f "$HOME/.bashrc" ]; then
	echo "Including share_profile in bash_profile"

	printf "\n%s\n%s\n" "# include .share_profile if it exists" "[[ -f \"$HOME/.share_profile\" ]] && . \"$HOME/.share_profile\"" >> $HOME/.bashrc
fi

# copy over etc and bin files
echo "Copying bin and etc files"

cp -f "$CWH/bin/addpath.sh" "$SHARE_DIR/bin/."
cp -f "$CWH/bin/sd.sh" "$SHARE_DIR/bin/."
cp -f "$CWH/bin/setjava.sh" "$SHARE_DIR/bin/."

cp -f "$CWH/etc/.common_aliases" "$SHARE_DIR/etc/."
cp -f "$CWH/etc/.common_env" "$SHARE_DIR/etc/."

