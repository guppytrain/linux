#!/bin/sh

# clone the fzf repo
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

$HOME/.fzf/install --all
