#!/bin/sh

# source the env vars
. ./include/env.sh

# echo "PATH: $PATH"
pupdate.sh

# zsh
zsh_install.sh

# curl
pinst.sh -y curl

# python
pinst.sh -y python

# vim
pinst.sh -y vim

# jdk
jdk_install.sh

# nvm
nvm_install.sh


