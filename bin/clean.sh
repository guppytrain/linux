#!/bin/sh

# source the env vars
. ./include/env.sh

# restore prev files
if [ -f "$HOME/.share_profile" ]; then
	rm "$HOME/.share_profile"
fi

if [ -f "$HOME/.inputrc" ]; then
	rm "$HOME/.inputrc"
fi

if [ -f "$CLEAN_DIR/.profile" ]; then
	cp -f "$CLEAN_DIR/.profile" "$HOME/.profile"
fi

if [ -f "$CLEAN_DIR/.bash_profile" ]; then
	cp -f "$CLEAN_DIR/.bash_profile" "$HOME/.bash_profile"
fi

if [ -f "$CLEAN_DIR/.bashrc" ]; then
	cp -f "$CLEAN_DIR/.bashrc" "$HOME/.bashrc"
fi

if [ -d "$SHARE_DIR/bin" ]; then
	rm "$SHARE_DIR/bin/addpath.sh"
	rm "$SHARE_DIR/bin/sd.sh"
	rm "$SHARE_DIR/bin/setjava.sh"
fi

if [ -d "$SHARE_DIR/etc" ]; then
	rm "$SHARE_DIR/etc/.common_env"
	rm "$SHARE_DIR/etc/.common_aliases"
fi

# zsh
zsh_remove.sh

# vim
puninst.sh -y vim

# jdk
#jdk_remove.sh


echo "Exit terminal to refresh settings"
