#!/bin/sh

if [ -f "$HOME/.vimrc" ]; then
	rm "$HOME/.vimrc"
fi

if [ -f "$HOME/.vim/plugins.vim" ]; then
	rm "$HOME/.vim/plugins.vim"
fi

if [ -f "$HOME/.vim/keymaps.vim" ]; then
	rm "$HOME/.vim/keymaps.vim"
fi

if [ -d "$HOME/.vim/bundle" ]; then
	rm -rf "$HOME/.vim/bundle"
fi

