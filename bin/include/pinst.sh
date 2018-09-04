#!/bin/sh

# package manager specific install

if [ $# = 0 ]; then
	echo $"Usage: pinst.sh <arg list>"
	exit 1
fi

if [ -n "$(command -v apt)" ]; then
	sudo apt-get install -y "$@"
elif [ -n "$(command -v yum)" ]; then
	sudo yum install -y "$@"
elif [ -n "$(command -v apk)" ]; then
	apk add "$@"
elif [ -n "$(command -v pacman)" ]; then
	sudo pacman -Sy --noconfirm "$@"
fi
