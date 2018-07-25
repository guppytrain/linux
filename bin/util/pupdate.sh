#!/bin/sh

# package manager specific update

if [ $# = 0 ]; then
	echo $"Usage: pupdate.sh <arg list>"
	exit 1
fi

if [ -n "$(which apt)" ]; then
	sudo apt-get update
elif [ -n "$(which apk)" ]; then
	sudo apk update
elif [ -n "$(which pacman)" ]; then
	echo "Pacman updates are done automatically during sync"
fi
