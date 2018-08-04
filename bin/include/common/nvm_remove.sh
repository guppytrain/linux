#!/bin/sh

if [ -f "$SHARE_DIR/etc/.nvmrc" ]; then
	rm "$SHARE_DIR/etc/.nvmrc"
fi

if [ -d "$HOME/.nvm" ]; then
	rm -rf "$HOME/.nvm"
fi

