#!/bin/sh

# source the env vars
. ./include/env.sh

# echo "PATH: $PATH"
 pupdate.sh

# zsh
 zsh_install.sh

# vim
 pinst.sh -y vim

# jdk
jdk_install.sh

