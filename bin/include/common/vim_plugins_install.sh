#!/bin/sh

# vim
pinst.sh vim

if [ ! -d "$HOME/.vim" ]; then
	echo "Creating new .vim directory"

	mkdir "$HOME/.vim"
fi

export VIM_DIR="$HOME/.vim"

rm -rf "$VIM_DIR/bundle"

git clone "https://github.com/VundleVim/Vundle.vim.git" "$VIM_DIR/bundle/Vundle.vim"

vimrc_file="$CWH/etc/.vimrc"

if [ -f "$vimrc_file" ]; then
	echo "Copying vimrc to $HOME"
	cp "$vimrc_file" "$HOME/." 
fi

if [ -f "$CWH/etc/plugins.vim" ]; then
	echo "Copying plugins.vim to $VIM_DIR"
	cp "$CWH/etc/plugins.vim" "$VIM_DIR/." 
fi

if [ -f "$CWH/etc/keymaps.vim" ]; then
    echo "Copying keymaps.vim to $VIM_DIR"
	cp "$CWH/etc/keymaps.vim" "$VIM_DIR/." 
fi

# install fzf
fzf_install.sh

# install plugins in vim
vim +PluginInstall +qall
