#!/bin/sh

if [ ! -d "$HOME/.nvm" ]; then
	echo "Creating new .nvm directory"

	mkdir "$HOME/.nvm"
fi

export NVM_DIR="$HOME/.nvm"

if [ -d "$NVM_DIR" ] && [ -z "$(ls -A $NVM_DIR)" ]; then
	git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    	cd "$NVM_DIR"
      	git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	
	. "$NVM_DIR/nvm.sh"
fi

# add nvm.sh to needed files

nvmrc_file="$CWH/etc/.nvmrc"

if [ -f "$nvmrc_file" ]; then
	echo "Copying nvmrc to share folder"
	
	cp "$nvmrc_file" "$SHARE_DIR/etc/.nvmrc" 

	echo "Including .nvmrc in profile"

	if [ -f "$HOME/.profile" ]; then
		if [ -z "$(cat $HOME/.profile | grep '.nvmrc')" ]; then
			printf "\n%s\n%s\n" "# include .nvmrc if it exists" "[[ -f \"$SHARE_DIR/etc/.nvmrc\" ]] && . \"$SHARE_DIR/etc/.nvmrc\"" >> $HOME/.profile
		fi
	fi

	echo "Including .nvmrc in bashrc"

	if [ -f "$HOME/.bashrc" ]; then
		if [ -z "$(cat $HOME/.bashrc | grep '.nvmrc')" ]; then
			printf "\n%s\n%s\n" "# include .nvmrc if it exists" "[[ -f \"$SHARE_DIR/etc/.nvmrc\" ]] && . \"$SHARE_DIR/etc/.nvmrc\"" >> $HOME/.bashrc
		fi
	fi

	echo "Including .nvmrc in zshrc"

	if [ -f "$HOME/.zshrc" ]; then
		if [ -z "$(cat $HOME/.zshrc | grep '.nvmrc')" ]; then
			printf "\n%s\n%s\n" "# include .nvmrc if it exists" "[[ -f \"$SHARE_DIR/etc/.nvmrc\" ]] && . \"$SHARE_DIR/etc/.nvmrc\"" >> $HOME/.zshrc
		fi
	fi

fi


