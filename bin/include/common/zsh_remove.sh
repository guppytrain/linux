#!/bin/sh

puninst.sh zsh

if [ -f "$HOME/.zshrc" ]; then
	rm "$HOME/.zshrc"
fi

cd $DEV_DIR

if [ -d "$DEV_DIR/zsh-syntax-highlighting" ]; then
	rm -rf "$DEV_DIR/zsh-syntax-highlighting"
fi

