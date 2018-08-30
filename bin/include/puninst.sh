#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: puninst.sh <arg list>"
	exit 1
fi

if [ -n "$(which apt)" ]; then
	sudo apt-get purge -y "$@"
elif [ -n "$(which yum)" ]; then
	sudo yum remove -y "$@"
elif [ -n "$(which apk)" ]; then
	sudo apk del --purge "$@"
elif [ -n "$(which pacman)" ]; then
	sudo -R --noconfirm "$@"
fi
