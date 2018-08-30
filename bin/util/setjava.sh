#!/bin/sh

echo "JDK_DIR: $JDK_DIR"

if [ -z ${JDK_DIR} ] || [ ! -d ${JDK_DIR} ]; then
	echo "JDK_DIR is undefined. Exiting..."
    sleep 1
	exit 1
fi

SELECTED_JDK="$(ls $JDK_DIR | fzf --height="25%" -q jdk)"

if [ -z "${SELECTED_JDK}" ]; then
    echo "No selection made. Exiting..."
    sleep 1
    exit 2
fi

cd $JDK_DIR
pwd

if [ -L "$JDK_DIR/current" ]; then
    echo "Removing current link to $(readlink -f $JDK_DIR/current)"
    sudo rm current 
    sync
fi

echo "Setting Java to ${SELECTED_JDK}"
sudo ln -s ${SELECTED_JDK} current

echo "Current symlink: $(readlink -f $JDK_DIR/current)"

