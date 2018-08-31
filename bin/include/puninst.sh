#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: puninst.sh <arg list>"
	exit 1
fi

if [ -n "$(2>/dev/null which apt)" ]; then
	sudo apt-get purge -y "$@"
elif [ -n "$(2>/dev/null which yum)" ]; then
	sudo yum remove -y "$@"
elif [ -n "$(2>/dev/null which apk)" ]; then
	sudo apk del --purge "$@"
elif [ -n "$(2>/dev/null which pacman)" ]; then
	sudo -R --noconfirm "$@"
fi
