#!/bin/sh

# source the env vars
. ./env.sh

echo "Dev Dir: $DEV_DIR"

# enable firewall
sudo ufw enable

# make sure dev dir exists
( [ -d "$DEV_DIR" ] && echo "Found dev at $(pwd $DEV_DIR)" ) || ( mkdir -p "$DEV_DIR" );

echo $PATH
