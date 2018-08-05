#!/bin/sh

if [ -f "$SHARE_DIR/etc/.nvmrc" ]; then
	rm "$SHARE_DIR/etc/.nvmrc"
fi

if [ -f "$SHARE_DIR/etc/npm_completion" ]; then
	rm "$SHARE_DIR/etc/npm_completion"
fi

if [ -d "$HOME/.nvm" ]; then
	rm -rf "$HOME/.nvm"
fi

