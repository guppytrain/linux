#!/bin/sh

# source the env vars
. ./include/env.sh

# echo "PATH: $PATH"
pupdate.sh

# zsh
zsh_install.sh

# wget
pinst.sh wget

# curl
pinst.sh curl

# python
pinst.sh python

# vim
pinst.sh vim

# jdk
jdk_install.sh

# nvm
nvm_install.sh


