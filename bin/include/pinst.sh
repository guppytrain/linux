#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: pinst.sh <arg list>"
	exit 1
fi

if [ -n "$(which apt)" ]; then
	sudo apt-get install "$@"
elif [ -n "$(which pacman)" ]; then
	# --needed only does reinstall if needed
	sudo pacman -Sy --needed "$@"
elif [ -n "$(which apk)" ]; then
	sudo apk add "$@"
fi