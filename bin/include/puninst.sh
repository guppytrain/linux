#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: puninst.sh <arg list>"
	exit 1
fi

if [ -n "$(command -v apt)" ]; then
	sudo apt-get purge -y "$@"
elif [ -n "$(command -v yum)" ]; then
	sudo yum remove -y "$@"
elif [ -n "$(command -v apk)" ]; then
	sudo apk del --purge "$@"
elif [ -n "$(command -v pacman)" ]; then
	sudo pacman -R --noconfirm "$@"
fi
