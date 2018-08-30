#!/bin/sh

# source the env vars
. ./include/env.sh

# echo "PATH: $PATH"
pupdate.sh

# certs
pinst ca-certificates

# wget
pinst.sh wget

# curl
pinst.sh curl

# tar
pinst.sh tar

# unzip
pinst.sh unzip

# python
pinst.sh python

# vim
pinst.sh vim

# jdk
jdk_install.sh

# nvm
nvm_install.sh


