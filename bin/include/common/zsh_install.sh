#!/bin/sh

pinst.sh -y zsh

cd $DEV_DIR

if [ -d "$DEV_DIR/zsh-syntax-highlighting" ]; then
	rm -rf "$DEV_DIR/zsh-syntax-highlighting"
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

cp "$CWH/etc/.zshrc" "$HOME/.zshrc"

# build the .share_profile file, remove existing if any
share_file="$HOME/.share_profile"

if [ -f $share_file ]; then
	# include share_profile in .bashrc
	match4="$(cat $HOME/.zshrc | grep '.share_profile')"

	if [ -z "$match4" ] && [ -f "$HOME/.zshrc" ]; then
		echo "Including share_profile in zsh_profile"

		printf "\n%s\n%s\n" "# include .share_profile if it exists" "[[ -f \"$HOME/.share_profile\" ]] && . \"$HOME/.share_profile\"" >> $HOME/.zshrc
	fi
fi
