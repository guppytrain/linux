#!/bin/sh

# source the env vars
. ./include/env.sh

# restore prev files
if [ -f "$SHARE_DIR/etc/.share_profile" ]; then
	rm "$SHARE_DIR/etc/.share_profile"
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
    rm "$SHARE_DIR/bin/add_ssh_key.sh"
	
    rm -rf "$SHARE_DIR/bin/include"
fi

if [ -d "$SHARE_DIR/etc" ]; then
	rm "$SHARE_DIR/etc/.common_env"
	rm "$SHARE_DIR/etc/.common_aliases"

	rm -rf "$SHARE_DIR/etc/include"
fi

echo "Exit terminal to refresh settings"
