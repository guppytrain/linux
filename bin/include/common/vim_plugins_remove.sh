#!/bin/sh

# NOTE: the install process installs vim, but not going to remove it here

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

# NOTE: vim plugins install does install fzf, but this does not remove it since it's so darned useful, it's fine to leave it behind
