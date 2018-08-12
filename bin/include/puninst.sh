#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: puninst.sh <arg list>"
	exit 1
fi

if [ -n "$(which apt)" ]; then
	sudo apt-get purge "$@"
elif [ -n "$(which pacman)" ]; then
	sudo pacman -Rns "$@"
elif [ -n "$(which apk)" ]; then
	apk del --purge "$@"
fi
