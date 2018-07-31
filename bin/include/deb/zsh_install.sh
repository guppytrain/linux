#!/bin/sh

pinst.sh -y zsh

cd $DEV_DIR

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

cp "$CWH/etc/.zshrc" "$HOME/.zshrc"

