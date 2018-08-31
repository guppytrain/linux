#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: pinst.sh <arg list>"
	exit 1
fi

if [ -n "$(2>/dev/null which apt)" ]; then
	sudo apt-get install -y "$@"
elif [ -n "$(2>/dev/null which yum)" ]; then
	sudo yum install -y "$@"
elif [ -n "$(2>/dev/null which apk)" ]; then
	apk add "$@"
elif [ -n "$(2>/dev/null which pacman)" ]; then
	sudo -Sy --noconfirm "$@"
fi
