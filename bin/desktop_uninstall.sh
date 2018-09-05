#!/bin/sh

# source the env vars
. ./include/env.sh

echo "Starting Desktop Uninstall..." 

# start install
cd $CWH/bin/installers 
./vim_plugins_remove.sh 
./dropbox_remove.sh 
./docker_remove.sh 
./idea_remove.sh
echo "Finished Desktop Uninstall"
