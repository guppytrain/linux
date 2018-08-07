#!/bin/sh

# source the env vars
. ./include/env.sh

# zsh
zsh_remove.sh

# jdk
jdk_remove.sh

# nvm
nvm_remove.sh

echo "Exit terminal to refresh settings"
